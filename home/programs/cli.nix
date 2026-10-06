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
    yazi.enable = true;
    impala.enable = true;
    wiremix.enable = true;

    fzf = {
      enable = true;
      defaultOptions = [ "--no-color" ];
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
  ];
}
