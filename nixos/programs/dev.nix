{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # ai
    antigravity-cli
    codex
    opencode

    # git
    lazygit
    gh
    git
    git-lfs

    # nix
    nixfmt
    alejandra
    nixd

    # lua
    stylua
    lua-language-server

    # web
    nodejs
    vscode-langservers-extracted
    oxfmt
    oxlint

    # shell
    bash-language-server
    shellcheck
  ];
}
