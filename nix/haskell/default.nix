{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.default = project: {
      imports = [
        ./no-global-cache.nix
        ./devtools.nix
      ];
      basePackages = config.haskellProjects.ghc928.outputs.finalPackages;
      defaults.settings.default = { name, package, config, ... }:
        lib.optionalAttrs (package.local.toDefinedProject or false) {
          # Disabling haddock and profiling is mainly to speed up Nix builds.
          haddock = lib.mkDefault false;
          # Avoid double-compilation.
          libraryProfiling = lib.mkDefault false;
          separateBinOutput = package.cabal.executables != [ ];
        };
    };
  };
}
