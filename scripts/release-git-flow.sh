#!/bin/bash

# Ensure you are on the develop branch
git checkout develop

# Make sure the develop branch is up-to-date
git pull origin develop

# Enter the release version
echo "Enter the release version (e.g. 1.0.0): "
read version

# Create a release branch from the develop branch
git flow release start $version

# Update the version number in the file (if any) and commit
# Example: update version.txt, replace "version.txt" with the name of your file containing version information
echo $version > version.txt
git add version.txt
git commit -m "Bump version to $version"

# Finish the release branch, merge into main and develop, create a tag, and delete the temporary release branch
# git flow release finish -m "Release $version" $version
git flow release finish -n $version
git tag -a "v$version" -m "Release $version"

# Push the changes to the remote repository, including main, develop, and tags
git push origin main:main
git push origin develop:develop
git push origin --tags