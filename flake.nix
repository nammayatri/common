{
  inputs = {
    nixpkgs-21_11.url = "github:nixos/nixpkgs/nixos-21.11"; # Used for ormolu

    nixpkgs-140774-workaround.url = "github:srid/nixpkgs-140774-workaround";
  };
  outputs = inputs: {
    flakeModules.default = {
      imports = [
        (import ./nix/treefmt.nix { inherit inputs; })
      ];
    };
    haskellFlakeProjectModules.default =
      import ./nix/haskell.nix { inherit inputs; };
  };
}
