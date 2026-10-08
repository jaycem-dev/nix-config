{ pkgs, ... }: {
  programs = {
    lazygit.enable = true;
    gh.enable = true;
    npm.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        pull.rebase = true;
        user = {
          name = "Jay";
          email = "45575946+jaycem-dev@users.noreply.github.com";
        };
      };
    };
  };

  home.packages = with pkgs; [
    android-tools

    # nix
    nixfmt
    alejandra
    nixd

    # lua
    stylua
    lua-language-server

    # web
    vscode-langservers-extracted
    oxfmt
    oxlint

    bash-language-server
    shellcheck
  ];
}
