{
  inputs = {
    # nixpkgs is not used in 'common', it is shared with repos that use common.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    haskell-flake.url = "github:srid/haskell-flake";
    systems.url = "github:nix-systems/default";
    flake-root.url = "github:srid/flake-root";
    nixpkgs-21_11.url = "github:nixos/nixpkgs/nixos-21.11"; # Used for ormolu
    nixpkgs-140774-workaround.url = "github:srid/nixpkgs-140774-workaround";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    cachix-push.url = "github:juspay/cachix-push";

    # Commonly useful flakes
    mission-control.url = "github:Platonic-Systems/mission-control";
    process-compose-flake.url = "github:Platonic-Systems/process-compose-flake";
    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";
  };
  outputs = inputs: {
    flakeModules = {
      default = import ./flake-module.nix { inherit inputs; };
      # ghc810 = ./nix/ghc810.nix;
      ghc927 = ./nix/ghc927.nix;
    };

    lib.mkFlake = args: mod:
      inputs.flake-parts.lib.mkFlake
        { inputs = args.inputs // { inherit (inputs) nixpkgs; }; }
        {
          systems = import inputs.systems;
          imports = [
            inputs.self.flakeModules.default
            mod
          ];
        };
  };
}
