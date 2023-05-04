# To use this package set in your `haskell-flake` projects, set the
# `basePackages` option as follows:
#
# > basePackages = config.haskellProjects.ghc927.outputs.finalPackages;
#
{ self, lib, ... }:

let
  # A function that enables us to write `foo = [ dontCheck ]` instead of `foo =
  # lib.pipe super.foo [ dontCheck ]` in haskell-flake's `overrides`.
  compilePipe = f: self: super:
    lib.mapAttrs
      (name: value:
        if lib.isList value then
          lib.pipe super.${name} value
        else
          value
      )
      (f self super);
in
{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.ghc927 = {
      # This is not a local project, so disable those options.
      packages = { };
      devShell.enable = false;
      autoWire = [ ];

      # Uses GHC-9.2.7 package set as base

      # We use a versioned package-set instead of the more
      # general `pkgs.haskellPackages` set in order to be
      # more explicit about our intentions to use a
      # specific GHC version and by extension the related
      # packages versions that come with this snapshot

      basePackages = pkgs.haskell.packages.ghc927;

      source-overrides = {
        # Dependencies from Hackage

      };

      overrides = compilePipe (self: super: with pkgs.haskell.lib.compose; {
        binary-parsers = [ unmarkBroken doJailbreak ];
        mysql-haskell = [ doJailbreak ];
        prometheus-proc = [ unmarkBroken doJailbreak ];
        lrucaching = [ unmarkBroken doJailbreak ];
        wire-streams = [doJailbreak];
      });
    };
  };
}
