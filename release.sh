#!/usr/bin/env bash

set -ev

NEW_VERSION=$(nix --version | awk '{ print $3 }')
OLD_VERSION=$(cat version)

if [ "$NEW_VERSION" = "$OLD_VERSION" ]; then
  echo "New version hasn't been released"
  exit 0
fi

echo $NEW_VERSION >> version

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git add version
git commit -m "Update to ${GITHUB_RUN_ID}" || echo "No changes"
git push

BLOB="nixStatic-$NEW_VERSION.tar.gz"
tar -czvhf $BLOB result/
gh release create "$NEW_VERSION" $BLOB
