{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.default = project: {
      imports = [
        ./no-global-cache.nix
        ./devtools.nix
      ];
      basePackages = config.haskellProjects.ghc927.outputs.finalPackages;
    };
  };
}
