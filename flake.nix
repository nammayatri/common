{
  outputs = {
    flakeModules.default = {
      imports = [
        ./nix/treefmt.nix
      ];
    };
  };
}
