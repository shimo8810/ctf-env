{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "nix-ctf";
          packages = with pkgs; [
            binwalk
            imhex
            pwndbg
            python3
            tshark
            zsh
          ];

          shellHook = ''
            exec zsh
          '';
        };
      }
    );
}
