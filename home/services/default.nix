{
  imports = [
    ./mako.nix
    ./hypridle.nix
  ];

  services = {
    udiskie.enable = true;
    playerctld.enable = true;
    hyprpolkitagent.enable = true;
    gnome-keyring.enable = true;
    wpaperd.enable = true;

    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      tray.enable = true;
    };
  };
}
