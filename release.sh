#!/usr/bin/env bash

set -ev

NEW_VERSION=$(nix --version | awk '{ print $3 }')
OLD_VERSION=$(cat version)

if [ "$NEW_VERSION" = "$OLD_VERSION" ]; then
  echo "New version hasn't been released"
  exit 0
fi

echo $NEW_VERSION > version

git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git add version
git commit -m "Update to $NEW_VERSION" || echo "No changes"
git push

BLOB="nix-$NEW_VERSION.tar.gz"
rsync -a --copy-unsafe-links result/ result-resolved/
tar -czvf $BLOB -C result-resolved .
gh release create "$NEW_VERSION" $BLOB
