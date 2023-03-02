common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.flake-root.flakeModule
    (import ./nix/treefmt.nix common)
    (import ./nix/haskell.nix common)
    ./nix/ghc810.nix
    common.inputs.cachix-push.flakeModule
  ];
  perSystem = { ... }: {
    cachix-push.cacheName = "nammayatri";
  };
}
