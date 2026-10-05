{ pkgs, ... }: {
  programs = {
    home-manager.enable = true;
    zoxide.enable = true;
    bat.enable = true;
    btop.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    jq.enable = true;
    parallel.enable = true;
    ripgrep.enable = true;
    yt-dlp.enable = true;
    lazygit.enable = true;
    devenv.enable = true;
    gh.enable = true;
    yazi.enable = true;
    fzf = {
      enable = true;
      defaultOptions = [ "--no-color" ];
    };
    npm.enable = true;
    impala.enable = true;
    wiremix.enable = true;

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

    eza = {
      enable = true;
      icons = "auto";
      extraOptions = [ "--group-directories-first" ];
    };
  };

  home.packages = with pkgs; [
    bluetui
    brightnessctl
    android-tools
    ddcutil
    exfatprogs
    ffmpeg
    fwupd
    imagemagick
    libnotify
    tealdeer
    trash-cli
    unrar
    wl-clipboard
    nixfmt
    alejandra
    nixd
    stylua
    lua-language-server
  ];
}
