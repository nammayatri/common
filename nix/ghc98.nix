# To use this package set in your `haskell-flake` projects, set the
# `basePackages` option as follows:
#
# > basePackages = config.haskellProjects.ghc98.outputs.finalPackages;
#
{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.ghc98 = {
      projectFlakeName = "nammayatri:common";

      # This is not a local project, so disable those options.
      defaults.packages = {};
      devShell.enable = false;
      autoWire = [ ];

      # Uses GHC-9.8 package set as base

      # We use a versioned package-set instead of the more
      # general `pkgs.haskellPackages` set in order to be
      # more explicit about our intentions to use a
      # specific GHC version and by extension the related
      # packages versions that come with this snapshot

      basePackages = pkgs.haskell.packages.ghc98;

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
          broken = false;
          jailbreak = true;
        };
        servant-foreign = {
          broken = false;
          jailbreak = true;
        };
        openapi3 = {
          broken = false;
          check = false;
        };
        int-cast = {
          broken = false;
          jailbreak = true;
        };
        tcp-streams = { self, ... }: {
          broken = false;
          jailbreak = true;

          extraBuildDepends = [ self.crypton-x509-system ];
          custom = drv: pkgs.haskell.lib.overrideCabal drv (old: {
            postPatch = (old.postPatch or "") + ''
              sed -i -E 's/\bx509(-store|-system)?\b/crypton-x509\1/g' tcp-streams.cabal
            '';
          });

        };

        # remove this dependency?
        record-dot-preprocessor = {
          broken = false;
          jailbreak = true;
        };
        connection = {
          broken = false;
          jailbreak = true;
        };
        unix-memory = {
          broken = false;
          jailbreak = true;
        };
        text-format = {
          broken = false;
          jailbreak = true;
        };
        kleene = {
          broken = false;
          jailbreak = true;
        };
        unix-memory = {
          check = false;
        };
      };
    };
  };
}
