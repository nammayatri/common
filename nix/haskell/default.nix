{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.default = project: {
      imports = [
        ./no-global-cache.nix
        ./devtools.nix
      ];
      basePackages = config.haskellProjects.ghc927.outputs.finalPackages;
      defaults.settings.default = { name, package, config, ... }:
        lib.optionalAttrs (package.local.toDefinedProject or false) {
          # Disabling haddock and profiling is mainly to speed up Nix builds.
          haddock = lib.mkDefault false;
          # Avoid double-compilation.
          libraryProfiling = lib.mkDefault false;
          separateBinOutput =
            if package.cabal.executables == [ ]
            then null
            # The use of -fwhole-archive-hs-libs (see hpack/defaults.yaml)
            # breaks builds on macOS (cyclic references between bin and out); this
            # works around that.
            else !pkgs.stdenv.isDarwin;
        };
    };
  };
}
