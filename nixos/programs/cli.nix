{ pkgs, user, ... }:
{
  programs = {
    hyprland.enable = true;
    fish.enable = true;

    nh = {
      enable = true;
      flake = "/home/${user}/Projects/nix-config";
      clean = {
        enable = true;
        extraArgs = "--keep 2";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    android-tools
    beets
    bat
    neovim
    bluetui
    brightnessctl
    btop
    ddcutil
    exfatprogs
    eza
    fastfetch
    fd
    ffmpeg
    fzf
    hyprshutdown
    imagemagick
    impala
    jq
    libnotify
    parallel
    ripgrep
    stow
    tealdeer
    tmux
    trash-cli
    udiskie
    unrar
    wiremix
    wl-clipboard
    yazi
    yt-dlp
    zoxide
  ];
}
