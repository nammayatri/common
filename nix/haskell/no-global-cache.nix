# For more reproducible dev shell env
# cf. https://github.com/srid/haskell-flake/issues/160
{ self, config, lib, ... }: {
  devShell.mkShellArgs.shellHook =
    let
      subdir = lib.strings.removePrefix
        (builtins.toString self)
        (builtins.toString config.projectRoot);
    in
    ''
      export HIE_BIOS_CACHE_DIR=''${FLAKE_ROOT}/${subdir}/.hie-bios-cache
      export CABAL_DIR=''${FLAKE_ROOT}/${subdir}/.cabal-dir
    '';
}
