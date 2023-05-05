common:
{ self, ... }:

{
  _file = __curPos.file;
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.default = {
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
      };
    };
  };
}
