# To use this package set in your `haskell-flake` projects, set the
# `basePackages` option as follows:
# 
# > basePackages = config.haskellProjects.ghc810.outputs.finalPackages;
#
{
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.ghc810 = {
      projectFlakeName = "nammayatri:common";
      projectRoot = ../;

      # This is not a local project, so disable those options.
      defaults.packages = { };
      devShell.enable = false;
      autoWire = [ ];

      # NammaYatri is not upgraded to 9.2 yet (could take weeks per Hemant)
      # We can't use 884, because that's broken in nixpkgs. So 8.10 it is.
      basePackages = pkgs.haskell.packages.ghc8107;

      # Dependencies from Hackage
      packages = {
        aeson.source = "1.5.6.0";
        dhall.source = "1.35.0";
        esqueleto.source = "3.5.2.0";
        geojson.source = "4.0.4";
        hspec.source = "2.7.6";
        hspec-core.source = "2.7.6";
        hspec-discover.source = "2.7.6";
        hspec-meta.source = "2.6.0";
        http2.source = "3.0.2";
        jwt.source = "0.10.0";
        lens.source = "4.19.2";
        megaparsec.source = "9.0.0";
        mmorph.source = "1.1.3";
        openapi3.source = "3.1.0";
        optparse-applicative.source = "0.15.1.0";
        servant.source = "0.18.3";
        servant-client.source = "0.18.1";
        servant-client-core.source = "0.18.1";
        servant-docs.source = "0.11.7";
        servant-foreign.source = "0.15.2";
        servant-mock.source = "0.8.7";
        servant-multipart.source = "0.12";
        servant-openapi3.source = "2.0.1.2";
        servant-server.source = "0.18.1";
        singletons.source = "2.6";
        streamly.source = "0.7.3.1";
        tasty-hspec.source = "1.1.6";
        th-desugar.source = "1.10";
        universum.source = "1.6.1";
      };

      # NOTE: A lot of these overrides try to match
      # https://www.stackage.org/lts-16.31 because that's what the project is
      # mostly using. As we migrate to GHC 9.2, we can remove most of these.
      settings = {
        aeson.jailbreak = true;
        aeson-casing.check = false;
        amazonka-core = {
          broken = false;
          check = false;
          jailbreak = true;
        };
        binary-parsers = {
          broken = false;
        };
        dhall = {
          check = false;
          jailbreak = true;
        };
        esqueleto = {
          check = false;
        };
        geojson = {
          check = false;
        };
        hex-text = {
          check = false;
        };
        http2 = {
          check = false;
        };
        jwt = {
          check = false;
          jailbreak = true;
        };
        lens = {
          check = false;
          jailbreak = true;
        };
        lrucaching = {
          broken = false;
        };
        megaparsec = {
          check = false;
          jailbreak = true;
        };
        mmorph = {
          jailbreak = true;
        };
        openapi3 = {
          check = false;
          jailbreak = true;
        };
        optparse-applicative = {
          jailbreak = true;
        };
        prometheus-proc = {
          broken = false;
        };
        servant = {
          jailbreak = true;
        };
        servant-client = {
          check = false;
          jailbreak = true;
        };
        servant-client-core = {
          check = false;
          jailbreak = true;
        };
        servant-docs = {
          check = false;
          jailbreak = true;
        };
        servant-foreign = {
          check = false;
          jailbreak = true;
        };
        servant-mock = {
          check = false;
          jailbreak = true;
        };
        servant-multipart = {
          check = false;
          jailbreak = true;
        };
        servant-openapi3 = {
          check = false;
          jailbreak = true;
        };
        servant-server = {
          check = false;
          jailbreak = true;
        };
        singletons = {
          check = false;
          jailbreak = true;
        };
        streamly = {
          check = false;
          jailbreak = true;
        };
        th-desugar = {
          check = false;
          jailbreak = true;
        };
        tinylog = {
          broken = false;
        };
        universum = {
          check = false;
          jailbreak = true;
        };
        word24 = {
          broken = false;
        };
      };
    };
  };
}
