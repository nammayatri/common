common:
{ self, inputs, ... }:

{
  _file = __curPos.file;
  imports = [
    common.inputs.flake-root.flakeModule
    common.inputs.haskell-flake.flakeModule
    common.inputs.nix-health.flakeModule
    (import ./nix/treefmt.nix common)
    ./nix/haskell
    # ./nix/ghc810.nix
    ./nix/ghc927.nix
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
      # Note:-
      # Temporarily allow nodejs14, just to advance with testing build purposes.
      # DO NOT DEPLOY OR MERGE THIS, IT IS INSECURE!
      #
      # UPDATE on Note:-
      #   The Frontend team will take up the nodejs upgrade separately
      config.permittedInsecurePackages = [
        "nodejs-14.21.3"
        "openssl-1.1.1w"
      ];
      overlays = [
        common.inputs.rust-overlay.overlays.default
        (self: super: {
          hpack = super.callPackage ./nix/haskell/hpack { inherit (super) hpack; };
          python310 = super.python310.override {
            packageOverrides = self.callPackage ./nix/python310/overrides.nix {};
          };
          process-compose = common.inputs.process-compose.packages.${system}.process-compose;
          nix-health = common.inputs.nix-health.packages.${system}.nix-health;
        })
      ];
    };
  };
}
