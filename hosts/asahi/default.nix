{
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../nixos
  ];

  # Aurora enables GRUB, which is what the m1n1 boot chain expects.
  boot.loader.systemd-boot.enable = false;

  # Keep this install's state version; Aurora defaults to 26.05 for new images.
  system.stateVersion = lib.mkForce "25.05";

  # Aurora's `minimal` profile only brings the hardware stack; Hyprland comes
  # from home-manager, so do not pull in KDE, GNOME, Firefox or a display manager.
  aurora.desktop = "minimal";

  # Aurora enables Flatpak with its Mesa integration by default.
  # aurora.flatpak.enable = false;

  # Home-manager's pkgs do not have the Aurora overlay, so install Aurora's
  # aarch64 Steam client (4K userpages) from the NixOS side.
  hardware.steam-hardware.enable = true;
  environment.systemPackages = [ pkgs.steam ];

  zramSwap.enable = true;
  networking.hostName = "asahi";

  hardware.bluetooth.enable = true;

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];
}
