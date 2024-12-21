# https://pre-commit.com/ hooks defined in Nix
# cf. https://github.com/cachix/pre-commit-hooks.nix
{ inputs, ... }:

{
  perSystem = { pkgs, lib, system, config, ... }: {
    pre-commit = {
      pkgs = inputs.common.inputs.nixpkgs-latest.legacyPackages.${system};
      check.enable = true;
      settings = {
        hooks = {
          treefmt = {
            enable = true;
            excludes = [ config.pre-commit.settings.hooks.cabal2nix.settings.outputFilename ];
          };
          cabal2nix = {
            enable = true;
            settings.outputFilename = "cabal.nix";
          };
          nil.enable = lib.mkDefault true;
          hpack.enable = true;
          # FIXME: Disabled due to purity issues
          # nix-flake-lock.enable = true;
          statix.enable = lib.mkDefault true;

          # Custom hooks
          trailing-ws = {
            enable = true;
            name = "trailing-ws";
            description = "Remove trailing spaces";
            types = [ "text" ];
            # files = "Backend/.*$";
            pass_filenames = true;
            entry = lib.getExe (pkgs.writeShellApplication {
              name = "trailing-ws";
              text = ''
                if [[ ''$# -gt 0 ]]; then
                  echo "Checking for trailing spaces in ''$# files"
                  FILES_WITH_TRAILING_WS=$(grep -r -l '  *$' "''$@" || true)
                  if [ -z "$FILES_WITH_TRAILING_WS" ]; then
                    echo "No trailing spaces found"
                  else
                    echo "Trailing spaces found in:"
                    echo "''$FILES_WITH_TRAILING_WS"

                    echo "Removing trailing spaces, please check and git add the changes"
                    if [[ "''$OSTYPE" == 'darwin'* ]]; then
                      BACKUP_EXTENSION=pqmc98hxvymotiyb4rz34
                      sed -i".''${BACKUP_EXTENSION}" -e 's/  *$//' "''$FILES_WITH_TRAILING_WS"
                      find ./ -name "*.''${BACKUP_EXTENSION}" -exec rm {} +
                    else
                      sed -i -e 's/  *$//' "''$FILES_WITH_TRAILING_WS"
                    fi
                  fi
                fi
              '';
            });
          };
        };
      };
    };
  };
}
