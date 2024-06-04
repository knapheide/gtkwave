{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.outputs.legacyPackages.${system};
      in {
        packages.gtkwave = pkgs.callPackage ./. { };
        packages.default = self.outputs.packages.${system}.gtkwave;
      });
}
