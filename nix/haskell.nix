common:
{ pkgs, lib, config, ... }:

{
  _file = __curPos.file;
  perSystem = { pkgs, lib, config, ... }: {
    haskellProjects.default = {
      imports = [
        common.inputs.nixpkgs-140774-workaround.haskellFlakeProjectModules.default
      ];
      devShell = {
        tools = hp: {
          inherit (pkgs.haskellPackages)
            hpack
            ;
          inherit (hp)
            ghcid
            ;
        };
        mkShellArgs.shellHook = ''
          ${lib.getExe config.flake-root.package}
          # Re-generate .cabal files so HLS will work (per hie.yaml)
          time ${pkgs.findutils}/bin/find -name package.yaml -exec hpack {} \;
        '';
      };
    };
  };
}
