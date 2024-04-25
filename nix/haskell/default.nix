{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.default = project: {
      imports = [
        ./no-global-cache.nix
        ./devtools.nix
      ];
      basePackages = config.haskellProjects.ghc927.outputs.finalPackages;
      defaults.settings.defined = { name, package, config, ... }: {
        # Disabling haddock and profiling is mainly to speed up Nix builds.
        haddock = lib.mkDefault false;
        # Avoid double-compilation.
        libraryProfiling = lib.mkDefault false;
        buildFromSdist = lib.mkDefault true; # Ensure release-worthiness
        separateBinOutput = package.cabal.executables != [ ];
      };
    };
  };
}
