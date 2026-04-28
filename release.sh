#!/usr/bin/env bash
set -ev
NEW_HASH=$(sha256sum result/bin/nix | awk '{ print $1 }')
OLD_HASH=$(grep 'sha256 "' Formula/nix-static.rb | cut -d '"' -f 2 || echo "")
if [ "$NEW_HASH" = "$OLD_HASH" ]; then
  echo "Binary hasn't changed. Skipping update."
  exit 0
fi
cat <<EOF > Formula/nix-static.rb
class NixStatic < Formula
  desc "Static build of the Nix CLI"
  homepage "https://nixos.org"
  url "https://github.com/${GITHUB_REPOSITORY}/releases/download/${GITHUB_RUN_ID}/nix"
  version "${GITHUB_RUN_ID}"
  sha256 "${NEW_HASH}"
  def install; bin.install "nix"; end
end
EOF
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git add Formula/nix-static.rb
git commit -m "Update to ${GITHUB_RUN_ID}" || echo "No changes"
git push

gh release create "${GITHUB_RUN_ID}" result/bin/nix

OLD_RELEASES=$(gh release list --limit 100 | awk '{print $1}' | tail -n +4)
for TAG in $OLD_RELEASES; do
  gh release delete "$TAG" --yes --cleanup-tag
done
