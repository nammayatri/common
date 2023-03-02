common:
{ self, inputs, ... }:

{
  _file = __curPos.file;
  config = {
    perSystem = { self', config, pkgs, lib, system, ... }: {
      treefmt.config = {
        inherit (config.flake-root) projectRootFile;
        package = pkgs.treefmt;

        programs.nixpkgs-fmt.enable = true;
        # FIXME: Disabled until https://github.com/nammayatri/nammayatri/issues/31
        # programs.hlint.enable = true;
        programs.ormolu.enable = true;

        programs.ormolu.package =
          let pkgs-21_11 = common.inputs.nixpkgs-21_11.legacyPackages.${system};
          in common.inputs.nixpkgs-140774-workaround.patch pkgs-21_11 pkgs-21_11.haskellPackages.ormolu;
        settings.formatter.ormolu = {
          options = [
            "--ghc-opt"
            "-XTypeApplications"
            "--ghc-opt"
            "-fplugin=RecordDotPreprocessor"
          ];
        };
      };

      # Add it to the default Haskell project shell.
      haskellProjects.default = {
        devShell.tools = _: {
          treefmt = config.treefmt.build.wrapper;
        } // config.treefmt.build.programs;
      };
    };
  };
}
