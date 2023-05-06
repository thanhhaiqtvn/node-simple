#!/bin/bash

# Ensure you are on the develop branch
git checkout develop

# Make sure the develop branch is up-to-date
git pull --rebase origin develop

# Enter the release version
echo "Enter the release version (e.g. 1.0.0): "
read version

# Make sure not have any commit change in current branch.
if [[ -n $(git status --porcelain) ]]; then
  echo "Your working directory is not clean. Please commit or stash your changes before starting the release process."
  exit 1
fi

# Create a release branch from the develop branch
git checkout -b release/$version develop

# Update the version number in the file (if any) and commit
echo $version > version.txt
git add version.txt
git commit -m "Bump version to $version"

# Merge release branch into main and create a tag
git checkout main
git merge --no-ff --no-commit release/$version
git commit -m "Release $version"
git tag -a $version -m "Release $version"

# Merge release branch into develop
git checkout develop
git merge --no-ff --no-commit release/$version
git commit -m "Merge release $version into develop"

# Delete the temporary release branch
git branch -d release/$version

# Push the changes to the remote repository, including main, develop, and tags
git push origin main:main
git push origin develop:develop
git push origin --tags