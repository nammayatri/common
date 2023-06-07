# common

Nix-based project configuration shared between nammayatri repositories

## What's provided

- A `lib.mkFlake` function uses flake-parts.lib.mkFlake, in addition to providing:
  - Shared `nixpkgs` input
  - Automatic setting of `systems` (using nix-systems)
  - Automatic importing of the common flakeModule.
- The common flakeModule provides:
  - treefmt-based autoformatters: ormolu, hlint, dhall-format, nixpkgs-fmt
  - Common Haskell configuration
    - ~~GHC 8.10 package set (matching LTS 16.31 in part)~~ (DEPRECATED, file and references kept for posterity only)
    - GHC 9.2.7 package set
    - Avoid global tool caches (`no-global-cache.nix`)
  - `mission-control`
  - `process-compose-flake`
  - pre-commit hooks
  - Flake app (`nix run .#cachix-push`) to push outputs to cachix, until we [automate it in CI](https://github.com/juspay/jenkins-nix-ci/issues/18).
