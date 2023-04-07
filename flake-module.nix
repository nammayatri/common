common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.flake-root.flakeModule
    common.inputs.haskell-flake.flakeModule
    common.inputs.check-flake.flakeModule
    (import ./nix/treefmt.nix common)
    (import ./nix/haskell.nix common)
    ./nix/ghc810.nix
    common.inputs.cachix-push.flakeModule
    common.inputs.mission-control.flakeModule
    common.inputs.process-compose-flake.flakeModule
  ];
  perSystem = { system, inputs', ... }: {
    cachix-push.cacheName = "nammayatri";

    # Remove this after fixing
    # https://github.com/nammayatri/nammayatri/issues/13
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (self: super: {
          arion = common.inputs.arion.packages.${system}.arion;
        })
      ];
    };
  };
}
