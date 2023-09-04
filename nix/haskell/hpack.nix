{ writeShellApplication, hpack, lib, ... }:

writeShellApplication {
  name = "hpack";
  text = ''
    set -x

    DIR=$(mktemp -d)
    cp "''${@: -1}" "$DIR"/package.yaml

    # Merge defaults with package.yaml
    cat ${../../.hpack/defaults.yaml} "$DIR"/package.yaml > "''${@: -1}"
    ${lib.getExe hpack} "$@"

    # Restore original
    cp "$DIR"/package.yaml "''${@: -1}"
    rm -rf "$DIR"
  '';
}
