{
  description = "Nixverse: collection of packages and modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { self, nixpkgs, flake-parts, ... } @inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      # Define the default overlay
      flake.overlays.default = final: prev: {
        CascadiaCode-NerdFont = self.packages.${final.stdenv.hostPlatform.system}.CascadiaCode-NerdFont;
      };

      # Define packages per system
      perSystem = { pkgs, ... }: {
        packages = {
          CascadiaCode-NerdFont = pkgs.callPackage ./packages/fonts/CascadiaCode-NerdFont.nix { };
        };
      };
    };
}
