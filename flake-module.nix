common:
{ self, inputs, ... }:

{
  imports = [
    (import ./nix/treefmt.nix common)
    common.inputs.flake-root.flakeModule
  ];
  perSystem = { self', config, ... }: {
    haskellProjects.default = {
      imports = [
        (import ./nix/haskell.nix (common // { inherit config; }))
      ];
    };
  };
}
