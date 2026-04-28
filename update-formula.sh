#!/usr/bin/env bash
set -ev
HASH=$(sha256sum result/bin/nix | awk '{ print $1 }')
cat <<EOF > Formula/nix-static.rb
class NixStatic < Formula
  desc "Static build of the Nix package manager"
  homepage "https://nixos.org"
  url "https://github.com/${GITHUB_REPOSITORY}/releases/download/${GITHUB_RUN_ID}/nix"
  version "${GITHUB_RUN_ID}"
  sha256 "${HASH}"
  def install; bin.install "nix"; end
end
EOF
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git add Formula/nix-static.rb
git commit -m "Update to ${GITHUB_RUN_ID}" || echo "No changes"
git push
