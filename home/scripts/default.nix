{ pkgs, ... }: {
  home.packages = [
    # workaround script until the hyprland-workspace-taskbar sort is fixed
    (pkgs.writeShellApplication {
      name = "ws-dots";
      text = builtins.readFile ./ws-dots.sh;
      runtimeInputs = with pkgs; [
        hyprland
        jq
        libressl.nc
      ];
    })

    (pkgs.writeShellApplication {
      name = "projects-picker";
      text = builtins.readFile ./projects-picker.sh;
      runtimeInputs = with pkgs; [
        fd
        fzf
      ];
    })

    (pkgs.writeShellApplication {
      name = "tmux-sessions";
      text = builtins.readFile ./sessions.sh;
      runtimeInputs = with pkgs; [
        fd
        fzf
        tmux
      ];
    })

    (pkgs.writeShellApplication {
      name = "dmenu-power";
      text = builtins.readFile ./dmenu-power.sh;
      runtimeInputs = with pkgs; [
        fuzzel
        hyprlock
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
      name = "screenshot";
      text = builtins.readFile ./screenshot.sh;
      runtimeInputs = with pkgs; [
        grim
        libnotify
        slurp
        wl-clipboard
      ];
    })

    (pkgs.writeShellApplication {
      name = "set-wallpaper";
      text = builtins.readFile ./set-wallpaper.sh;
      runtimeInputs = with pkgs; [
        hyprland
        file
        libnotify
      ];
    })

    (pkgs.writeShellApplication {
      name = "hyprsunset-toggle";
      text = builtins.readFile ./hyprsunset-toggle.sh;
      runtimeInputs = with pkgs; [
        hyprland
        hyprsunset
      ];
    })
  ];
}
