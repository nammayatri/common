common:
{ self, inputs, ... }:

{
  imports = [
    common.inputs.flake-root.flakeModule
    (import ./nix/treefmt.nix common)
    (import ./nix/haskell.nix common)
    ./nix/ghc810.nix
  ];
}
