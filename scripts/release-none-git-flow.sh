#!/bin/bash

# Ensure you are on the main branch
git checkout develop

# Make sure the main branch is up-to-date
git pull origin develop


# Get the latest tag
latest_tag=$(git describe --tags --abbrev=0)
echo "************************************"
echo "****** git tag latest: $latest_tag ******"
echo "************************************"

# Enter the release version
echo "Enter the release version (e.g. 1.0.0): "
read version

# Create a release branch
git checkout -b release/$version

# Update the version number in the file (if any) and commit
# Example: update version.txt, replace "version.txt" with the name of your file containing version information
echo $version > version.txt
git add version.txt
git commit -m "Bump version to $version"

# Merge release branch into main
git checkout main
git merge release/$version --no-ff -m "Merge release $version into main"

# Tag the release
git tag "v$version"

# Push the changes to the remote repository, including main branch and tags
git push origin main
git push origin "v$version"

# Delete the local release branch
git branch -d release/$version

# Optionally, delete the remote release branch
git push origin --delete release/$version
