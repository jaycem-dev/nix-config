# Repository Guidelines

## Project Structure & Module Organization

This repository is a Nix flake for NixOS and standalone Home Manager. Home Manager is configured independently through the flake's `homeConfigurations` outputs. `flake.nix` defines host names and their system architectures. Under `hosts/<host>/`, `default.nix` configures the NixOS system and `home.nix` configures Home Manager; hardware-specific settings also live in the host directory. Shared system modules, services, and programs are under `nixos/`; user settings, programs, services, overlays, and scripts are under `home/`. Keep host-only changes in the relevant host directory and reusable configuration in the shared trees. Shell utilities belong in `home/scripts/` and are exposed through its Nix module.

## Build, Test, and Development Commands

- `nix flake check` evaluates the flake outputs and catches many evaluation errors.
- `nix eval .#nixosConfigurations.<host>.config.system.build.toplevel.drvPath` evaluates a host's system derivation.
- `nix build .#nixosConfigurations.<host>.config.system.build.toplevel` builds a host's system without activating it.
- `nix build '.#homeConfigurations.<user>@<host>.activationPackage'` builds that user's Home Manager activation package without activating it. Quote this installable because it contains `@` and angle brackets are shell redirection syntax.

There is no separate automated test suite. For testing, use evaluation and builds only. Never run `nixos-rebuild` or `home-manager switch`.

Use `nix-shell -p <package>` to get a tool temporarily without adding it to the configuration; for example, `nix-shell -p stylua`.

## Coding Style & Naming Conventions

Follow `.editorconfig`: use spaces and four-space indentation. Format Nix files with `nixfmt` and Lua files with `stylua` (also configured in `home/programs/neovim/lua/languages.lua`). Use descriptive lower-case filenames (typically `kebab-case.nix`) and group related options into the existing modules. Keep consecutive one-line options together, for example `test.enable = true;` and `test2.enable = true;`. Add a blank line before a multi-line option set such as `test = { ... };`. Shell scripts should remain readable and executable where invoked directly. Avoid unrelated formatting or configuration changes.

## Testing Guidelines

For changes to a module, run `nix flake check` or evaluate/build the affected host output. Keep testing to Nix evaluation and builds; do not activate configurations. No coverage requirement or test naming convention is configured.

## Commit & Pull Request Guidelines

Recent commits use short, imperative, mostly lower-case subjects; script and feature changes often include a scope, such as `kitty-sessions: focus or launch tabs by title`. Keep commits focused. A pull request should describe the affected host or shared module, summarize behavior changes, and include the evaluation or manual checks performed. Include screenshots only when a change affects a visual interface.

## Security & Configuration Tips

Do not commit secrets, private keys, or machine-specific credentials. Never edit any `hardware-configuration.nix`; treat those files as host-generated hardware records. Put other host-specific settings in the matching host directory.
