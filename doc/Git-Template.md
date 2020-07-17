# Using this project as a template

This section describes how to use this repository as a template for other repositories,
for example if you wish to add sample pipelines/workflows/... that demonstrate how to 
scan the EightBall application in a particular CI/CD environment.

To set up a new repository, you can use the following steps:

1. Create new, empty Git repository, for example https://github.com/user/sample-eightball-derived
2. Clone your empty repository and add the template remote:
    1. `git clone https://github.com/user/sample-eightball-derived.git`
	2. `git remote add template https://github.com/fortify/sample-eightball.git`
3. Merge template changes to your current branch:
	1. `git fetch --all`
	2. `git merge template/master`
4. Push changes
	1. `git push`

If you wish to clone your `sample-eightball-derived` repository onto a new machine/directory, you will need
to repeat steps 2.1 (clone) and 2.2 (add template remote). If you want to merge any updates on the original 
sample-eightball repository into your current repository, you will need to repeat steps 3.1 (fetch) and 3.2 (merge).
