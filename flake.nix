{
  description = "TypeQuest: A lightweight CLI typing coach written in Janet";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
       Medieval = pkgs.janet;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            janet
            jpm # Janet Project Manager (for building/dependencies)
          ];

          shellHook = ''
            echo "================================================="
            echo " Welcome to the TypeQuest Development Environment"
            echo " Janet Version: $(janet -v)"
            echo "================================================="
          '';
        };
      });
}
