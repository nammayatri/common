{ writeShellApplication, hpack, lib, ... }:

# A hpack wrapper that merges our default configuratio
# In lieu of https://github.com/sol/hpack/issues/249
writeShellApplication {
  name = "hpack";
  text = ''
    DIR=$(mktemp -d)
    cp "''${@: -1}" "$DIR"/package.yaml

    # Merge defaults with package.yaml
    cat ${./defaults.yaml} "$DIR"/package.yaml > "''${@: -1}"
    ${lib.getExe hpack} "$@"

    # Restore original
    cp "$DIR"/package.yaml "''${@: -1}"
    rm -rf "$DIR"
  '';
}
