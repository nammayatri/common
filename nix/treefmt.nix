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

      flakeCheck = false; # Because, we use pre-commit-hooks.nix

      programs.nixpkgs-fmt.enable = true;
      # FIXME: Disabled until https://github.com/nammayatri/nammayatri/issues/31
      # programs.hlint.enable = true;
      programs.ormolu.enable = true;

      settings.formatter.ormolu = {
        options = [
          "--ghc-opt"
          "-XTypeApplications"
          "--ghc-opt"
          "-XRecordDotSyntax"
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
