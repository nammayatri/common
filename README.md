# common

Nix-based project configuration shared between nammayatri repositories

## What's provided

- Shared `nixpkgs` (used via [`follows`](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-flake#flake-inputs))
- treefmt-based autoformatters: ormolu, hlint, dhall-format, nixpkgs-fmt
- Common Haskell configuration
  - ~~GHC 8.10 package set (matching LTS 16.31 in part)~~ (DEPRECATED, file and references kept for posterity only)
  - GHC 9.2.7 package set
- `mission-control`
- `process-compose-flake`
- pre-commit hooks
- Flake app (`nix run .#cachix-push`) to push outputs to cachix.
