common:
{ pkgs, lib, config, perSystem, ... }:

{
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
      treefmt = perSystem.config.treefmt.build.wrapper;
    } // perSystem.config.treefmt.build.programs;
    mkShellArgs.shellHook = ''
      ${lib.getExe perSystem.config.flake-root.package}
      # Re-generate .cabal files so HLS will work (per hie.yaml)
      time ${pkgs.findutils}/bin/find -name package.yaml -exec hpack {} \;
    '';
  };
}
