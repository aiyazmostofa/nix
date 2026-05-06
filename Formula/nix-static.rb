class NixStatic < Formula
  desc "Static build of the Nix CLI"
  homepage "https://nixos.org"
  url "https://github.com/aiyazmostofa/homebrew-nix-static/releases/download/25412431706/nix"
  version "25412431706"
  sha256 "2277472f7234004905b3d5e0df9cecba0701ba643888c7da76b449be1bdde58a"
  def install; bin.install "nix"; end
end
