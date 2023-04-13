common:
{ self, ... }:

{
  _file = __curPos.file;
  imports = [
    common.inputs.treefmt-nix.flakeModule
  ];
  perSystem = { self', config, pkgs, lib, system, ... }: {
    treefmt.config = {
      inherit (config.flake-root) projectRootFile;
      package = pkgs.treefmt;

      programs.nixpkgs-fmt.enable = true;
      # FIXME: Disabled until https://github.com/nammayatri/nammayatri/issues/31
      # programs.hlint.enable = true;
      programs.ormolu.enable = true;

      programs.ormolu.package = common.inputs.nixpkgs-21_11.legacyPackages.${system}.haskellPackages.ormolu;
      settings.formatter.ormolu = {
        options = [
          "--ghc-opt"
          "-XTypeApplications"
          "--ghc-opt"
          "-fplugin=RecordDotPreprocessor"
        ];
      };

      programs.dhall.enable = true;
    };

    # Add it to the default Haskell project shell.
    haskellProjects.default = {
      devShell.tools = _: {
        treefmt = config.treefmt.build.wrapper;
      } // config.treefmt.build.programs;
    };
  };
}
