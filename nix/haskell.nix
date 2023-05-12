common:
{ self, ... }:

{
  _file = __curPos.file;
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.default = project: {
      basePackages = config.haskellProjects.ghc810.outputs.finalPackages;
      devShell = {
        tools = hp: {
          inherit (pkgs.haskellPackages)
            hpack
            ;
          inherit (hp)
            ghcid
            ;

          # Disable ormolu in HLS, until we upgrade to the latest version, or
          # switch to fourmolu
          #
          # See https://github.com/nammayatri/nammayatri/issues/649
          haskell-language-server = (pkgs.haskell.lib.compose.disableCabalFlag "ormolu" hp.haskell-language-server).override {
            hls-ormolu-plugin = null;
          };
        };

        # For more reproducible dev shell env
        # cf. https://github.com/srid/haskell-flake/issues/160
        mkShellArgs.shellHook =
          let
            subdir = lib.strings.removePrefix
              (builtins.toString self)
              (builtins.toString project.config.projectRoot);
          in
          ''
            export HIE_BIOS_CACHE_DIR=''${FLAKE_ROOT}/${subdir}/.hie-bios-cache
            export CABAL_DIR=''${FLAKE_ROOT}/${subdir}/.cabal-dir
          '';
      };
    };
  };
}
