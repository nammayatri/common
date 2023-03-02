{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    flake-root.url = "github:srid/flake-root";
    nixpkgs-21_11.url = "github:nixos/nixpkgs/nixos-21.11"; # Used for ormolu
    nixpkgs-140774-workaround.url = "github:srid/nixpkgs-140774-workaround";
  };
  outputs = inputs: {
    flakeModule = import ./flake-module.nix { inherit inputs; };
    haskellFlakeProjectModules.ghc810 = ./nix/ghc810.nix;
  };
}
