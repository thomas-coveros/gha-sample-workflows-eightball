#!/bin/bash
# This script performs the following tasks:
# - Copy template scripts and config files to repository root
# - Run the 'run-after-clone.sh' script
# - Commit the changes

templateDir=$(dirname "$0")
rootDir=$templateDir/..
copyOnly=(README.md)
copyAndAdd=(.gitattributes run-after-clone.sh pull-template.sh)

function copy() {
  for f in "$@"
  do
    cp -v "$templateDir/$f" "$rootDir/$f"
  done
}

function add() {
  for f in "$@"
  do
    git add -v "$rootDir/$f"
  done
}

# Check Git status
if [[ ! -z $(git status -s) ]] 
then
  echo "Error: Git working tree must be clean before running this script"
  exit 1
fi

# Move original README.md and add to Git index
mv -v "$rootDir/README.md" "$rootDir/doc/EightBall.md"
git add -v "$rootDir/doc/EightBall.md"

copy ${copyOnly[*]} ${copyAndAdd[*]}
add ${copyAndAdd[*]}

# Configure Git repository
$rootDir/run-after-clone.sh

# Commit changes
git commit -m "Copied template scripts"
