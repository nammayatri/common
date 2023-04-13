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
        };
      };
    };
  };
}
