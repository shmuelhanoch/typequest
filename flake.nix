{
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            janet
            jpm
            stdenv.cc
            gnumake
            pkg-config
          ];
          
          shellHook = ''
            # Force JPM to install packages locally in your project root 
            # instead of trying to write to /usr/local/lib or Nix store paths
            export JANET_PATH="$PWD/.jpm"
            export JANET_TREE="$PWD/.jpm"
            export PATH="$PWD/.jpm/bin:$PATH"
          '';
        };
      });
}
