#!/bin/bash
# This script performs the following tasks:
# - Copy template scripts and config files to repository root
# - Run the 'run-after-clone.sh' script
# - Commit the changes

templateDir=$(dirname "$0")
resourcesDir=$templateDir/resources
rootDir=$templateDir/..
copyOnly=(README.md)
copyAndAdd=(.gitattributes run-after-clone.sh)

function copy() {
  for f in "$@"
  do
    cp -v "$resourcesDir/$f" "$rootDir/$f"
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
mv -v "$rootDir/README.md" "$rootDir/README-EightBall.md"
git add -v "$rootDir/README-EightBall.md"

copy ${copyOnly[*]} ${copyAndAdd[*]}
add ${copyAndAdd[*]}

# Configure Git repository
$rootDir/run-after-clone.sh

# Commit changes
git commit -m "Setup as derived repository"
