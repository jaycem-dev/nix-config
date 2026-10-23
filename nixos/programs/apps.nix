{ pkgs, ... }: {

  programs = {
    seahorse.enable = true;
    localsend.enable = true;
    virt-manager.enable = true;

    moonlight-qt = {
      enable = true;
      capSysNice = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    anki
    brave-origin
    dnsmasq # libvirt networking
    ente-desktop
    file-roller # archive manager used by thunar-archive-plugin
    freetube
    gimp
    imv
    jellyfin-desktop
    kitty
    libreoffice
    lollypop
    moonlight-qt
    mpv
    nicotine-plus
    noctalia
    pavucontrol
    proton-vpn
    qalculate-gtk
    signal-desktop
    transmission_4-gtk
    zapfast
    zed-editor
  ];
}
