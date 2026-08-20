{pkgs, ...}: {
  imports = [
    ./nixvim
    ./niri
    ./stylix
    ./noctalia.nix
    ./beets.nix
    ./browser.nix
    ./desktop-items.nix
    ./dev.nix
    ./gaming.nix
    ./sh.nix
    ./terminal.nix
    ./tmux.nix
    ./yazi.nix
  ];

  programs = {
    home-manager.enable = true;
    fzf = {
      enable = true;
      fileWidget.options = [
        "--walker-skip"
        ".cache,.codeium,.codex,.gemini,.grok,.icons,.local,.nix-profile,.npm,.git,node_modules"
        "--preview"
        "'bat -n --color=always {}'"
      ];
      changeDirWidget.options = [
        "--walker-skip"
        ".cache,.codeium,.codex,.gemini,.grok,.icons,.local,.nix-profile,.npm,.git,node_modules"
      ];
    };
    zoxide.enable = true;
    bat.enable = true;
    btop.enable = true;
    eza.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    jq.enable = true;
    parallel.enable = true;
    ripgrep.enable = true;
    yt-dlp.enable = true;
    anki.enable = true;
    freetube.enable = true;
    mpv.enable = true;
    zed-editor.enable = true;
  };

  home.packages = with pkgs; [
    # cli
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

    # style
    adw-gtk3
    adwaita-icon-theme
    bibata-cursors
    kdePackages.breeze
    kdePackages.breeze-icons
    papirus-icon-theme

    # fonts
    dejavu_fonts
    font-awesome
    geist-font
    jetbrains-mono
    liberation_ttf
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji

    # desktop
    ente-auth
    ente-desktop
    gimp
    proton-vpn
    jellyfin-desktop
    kopuz
    libreoffice
    localsend
    lollypop
    moonlight-qt
    nautilus
    nicotine-plus
    nirius
    pavucontrol
    seahorse
    signal-desktop
    transmission_4-gtk
  ];
}
