# common

Nix-based project configuration shared between nammayatri repositories

## What's provided

- Common Nix configuration
    - treefmt-based autoformatters: ormolu, hlint, dhall-format, nixpkgs-fmt
    - Common Haskell configuration
- GHC 8.10 package set (matching LTS 16.31 in part)
- `nix run .#cachix-push` app to push local build to cachix.
