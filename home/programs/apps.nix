{ pkgs, ... }: {
  programs = {
    anki.enable = true;
    freetube.enable = true;
    mpv.enable = true;
    zed-editor.enable = true;
    libreoffice.enable = true;
    imv.enable = true;
  };

  home.packages = with pkgs; [
    zapfast
    ente-desktop
    gimp
    proton-vpn
    jellyfin-desktop
    localsend
    lollypop
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

    # fonts
    font-awesome
    jetbrains-mono
    geist-font
    nerd-fonts.symbols-only
  ];
}
