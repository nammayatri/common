{
  inputs = {
    nixpkgs-21_11.url = "github:nixos/nixpkgs/nixos-21.11";
  };
  outputs = inputs: {
    flakeModules.default = {
      imports = [
        (import ./nix/treefmt.nix { inherit inputs; })
      ];
    };
  };
}
