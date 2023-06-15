common:
{ self, inputs, ... }:

{
  _file = __curPos.file;
  imports = [
    common.inputs.flake-root.flakeModule
    common.inputs.haskell-flake.flakeModule
    (import ./nix/treefmt.nix common)
    ./nix/haskell
    ./nix/ghc810.nix
    ./nix/pre-commit.nix
    ./nix/arion.nix
    common.inputs.cachix-push.flakeModule
    common.inputs.mission-control.flakeModule
    common.inputs.process-compose-flake.flakeModule
    common.inputs.pre-commit-hooks-nix.flakeModule
  ];
  perSystem = { system, inputs', lib, ... }: {
    cachix-push.cacheName = "nammayatri";

    # Remove this after fixing
    # https://github.com/nammayatri/nammayatri/issues/13
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
