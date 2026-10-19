{
  imports = [
    ./mako.nix
    ./hypridle.nix
  ];

  services = {
    udiskie.enable = true;
    playerctld.enable = true;
    hyprpaper.enable = true;
    hyprsunset.enable = true;
    hyprpolkitagent.enable = true;

    syncthing = {
      enable = true;
      guiAddress = "0.0.0.0:8384";
      tray.enable = true;
    };
  };
}
