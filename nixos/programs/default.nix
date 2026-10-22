{
  pkgs,
  lib,
  user,
  ...
}:
{
  programs = {
    gamemode.enable = true;
    virt-manager.enable = true;
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

    steam = lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };

  fonts.packages = with pkgs; [
    font-awesome
    jetbrains-mono
    geist-font
    nerd-fonts.symbols-only
  ];

  environment.systemPackages =
    with pkgs;
    [
      # libvirt networking
      dnsmasq

      # apps
      zapfast
      ente-desktop
      gimp
      proton-vpn
      jellyfin-desktop
      localsend
      lollypop
      adw-gtk3
      moonlight-qt
      nicotine-plus
      file-roller # archive manager used by thunar-archive-plugin
      pavucontrol
      seahorse
      signal-desktop
      transmission_4-gtk
      qalculate-gtk

      # file manager
      (thunar.override {
        thunarPlugins = with pkgs; [
          thunar-archive-plugin
          thunar-volman
        ];
      })

      # cli
      stow
      bluetui
      udiskie
      brightnessctl
      ddcutil
      exfatprogs
      ffmpeg
      fwupd
      grim
      imagemagick
      libnotify
      playerctl
      slurp
      tealdeer
      trash-cli
      unrar
      wl-clipboard

      # dev
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

      # gaming
      mangohud
      duckstation
      gamescope
      lsfg-vk
      ryubing
      dolphin-emu
      gopher64
      # rpcs3

      # programs (packages only, configs still to migrate)
      anki
      freetube
      mpv
      zed-editor
      libreoffice
      imv
      beets
      brave-origin
      zoxide
      bat
      btop
      fastfetch
      fd
      jq
      parallel
      ripgrep
      yt-dlp
      yazi
      impala
      wiremix
      fzf
      eza
      lazygit
      gh
      nodejs
      git
      git-lfs
      kitty
      tmux
      bash
      zsh
      starship
      carapace
      neovim
      hyprshutdown
      antigravity-cli
      codex
      opencode
      noctalia
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      pcsx2
      shadps4
      heroic
    ];
}
