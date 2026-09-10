{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "dmenu-power";
      text = builtins.readFile ./dmenu-power.sh;
      runtimeInputs = with pkgs; [
        fuzzel
        swaylock
      ];
    })

    (pkgs.writeShellApplication {
      name = "brightness";
      text = builtins.readFile ./brightness.sh;
      runtimeInputs = with pkgs; [
        libnotify
        brightnessctl
        ddcutil
      ];
    })

    (pkgs.writeShellApplication {
      name = "volume";
      text = builtins.readFile ./volume.sh;
      runtimeInputs = with pkgs; [
        libnotify
        wireplumber
      ];
    })

    (pkgs.writeShellApplication {
      name = "set-wallpaper";
      text = builtins.readFile ./set-wallpaper.sh;
      runtimeInputs = with pkgs; [
        wpaperd
        file
        libnotify
      ];
    })
  ];
}
