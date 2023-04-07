{
  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    check-flake.url = "github:srid/check-flake";
    flake-root.url = "github:srid/flake-root";
    nixpkgs-21_11.url = "github:nixos/nixpkgs/nixos-21.11"; # Used for ormolu
    nixpkgs-140774-workaround.url = "github:srid/nixpkgs-140774-workaround";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    cachix-push.url = "github:juspay/cachix-push";

    # Commonly useful flakes
    mission-control.url = "github:Platonic-Systems/mission-control";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";

    # nixpkgs overrides
    # https://github.com/hercules-ci/arion/pull/192
    arion.url = "github:srid/arion/patch-1";
  };
  outputs = inputs: {
    flakeModules = {
      default = import ./flake-module.nix { inherit inputs; };
      ghc810 = ./nix/ghc810.nix;
    };
  };
}
