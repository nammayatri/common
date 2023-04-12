# TODO: Upstream this, while supporting multiple docker-compose configurations
# https://github.com/hercules-ci/arion/issues/193
{ self, config, lib, flake-parts-lib, ... }:

let
  inherit (flake-parts-lib)
    mkPerSystemOption;
  inherit (lib)
    mkOption
    types
    raw;
in
{
  options = {
    perSystem = mkPerSystemOption
      ({ config, self', pkgs, system, ... }: {
        options = {
          arionProjectConfiguration = mkOption {
            type = types.nullOr types.deferredModule;
            default = null;
            description = ''
              docker-compose configuration as modularized by arion.

              Adding configuration here will produce an `arion` package that
              uses it. You can invoke it and pass the arguments you normally
              pass to `docker-compose`, but to arion. 
            '';
          };
        };
        config = {
          packages =
            lib.optionalAttrs (config.arionProjectConfiguration != null) {
              arion =
                let
                  dcYaml = pkgs.arion.passthru.build {
                    modules = [
                      config.arionProjectConfiguration
                    ];
                  };
                in
                pkgs.writeShellApplication {
                  name = "arion";
                  text = ''
                    set -x
                    ${lib.getExe pkgs.arion} \
                      --prebuilt-file ${dcYaml} \
                      "$@"
                  '';
                };
            };
        };
      });
  };
}
