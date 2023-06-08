# To use this package set in your `haskell-flake` projects, set the
# `basePackages` option as follows:
#
# > basePackages = config.haskellProjects.ghc927.outputs.finalPackages;
#
{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.ghc927 = {
      projectFlakeName = "nammayatri:common";

      # This is not a local project, so disable those options.
      defaults.packages = {};
      devShell.enable = false;
      autoWire = [ ];

      # Uses GHC-9.2.7 package set as base

      # We use a versioned package-set instead of the more
      # general `pkgs.haskellPackages` set in order to be
      # more explicit about our intentions to use a
      # specific GHC version and by extension the related
      # packages versions that come with this snapshot

      basePackages = pkgs.haskell.packages.ghc927;

      packages = {
        # Dependencies from Hackage

      };

      settings = {
        binary-parsers = {
          broken = false;
          jailbreak = true;
        };
        mysql-haskell = {
          jailbreak = true;
        };
        prometheus-proc = {
          broken = false;
          jailbreak = true;
        };
        lrucaching = {
          broken = false;
          jailbreak = true;
        };
        wire-streams = {
          jailbreak = true;
        };
      };
    };
  };
}
