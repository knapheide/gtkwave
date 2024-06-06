{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.outputs.legacyPackages.${system};
      in rec {
        packages = {
          gtkwave = pkgs.callPackage ./. { };
          default = packages.gtkwave;
        };

        devShells.default = packages.gtkwave.overrideDerivation (old: {
          nativeBuildInputs = old.nativeBuildInputs
                              ++ (with pkgs; [ clang-tools bear ]);
          shellHook = ''
            export PATH="$(pwd)/build/src:$PATH"
            export LOCAL_EMACS_CONFIG=$(realpath local.el)
            export LOCAL_EMACS_SOCKET=$(realpath .emacssock)
          '';
        });
      });
}
