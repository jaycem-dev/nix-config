{
  lib,
  user,
  pkgs,
  ...
}:
{
  imports = [
    ./dns.nix
    ./homelab.nix
    ./keyd.nix
  ];

  services = {
    userdbd.enable = lib.mkForce false; # avoids systemd's age verification change
    gvfs.enable = true;
    udisks2.enable = true; # this is necessary for udiskie to work
    hardware.openrgb.enable = true;
    tumbler.enable = true; # thumbnails
    gnome.gnome-keyring.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "colemak_dh_iso";
    };

    greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          user = "greeter";
          command = lib.getExe' pkgs.tuigreet "tuigreet";
        };
        # autologin
        initial_session = {
          user = user;
          command = lib.getExe' pkgs.hyprland "start-hyprland";
        };
      };
    };

    openssh = {
      enable = true;
      startWhenNeeded = true;
    };

    # Power management with profiles
    tuned = {
      enable = true;
      settings.dynamic_tuning = true;
    };
  };
}
