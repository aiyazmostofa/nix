class NixStatic < Formula
  desc "Static build of the Nix package manager"
  homepage "https://nixos.org"
  url "https://github.com/aiyazmostofa/homebrew-nix-static/releases/download/25030297399/nix"
  version "25030297399"
  sha256 "0b7ab1dec9a270a091d373b1627e493d9bdbb84cfd2fef67bd17b8fb182ff0d4"
  def install; bin.install "nix"; end
end
