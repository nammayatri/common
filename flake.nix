{
  outputs = inputs: {
    flakeModules.default = {
      imports = [
        ./nix/treefmt.nix
      ];
    };
  };
}
