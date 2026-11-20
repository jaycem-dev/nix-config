{ aurora, pkgs, ... }:
{
  imports = [
    aurora.inputs.apple-silicon.nixosModules.default
    aurora.nixosModules.default
    aurora.nixosModules.installed
    ./hardware-configuration.nix
    ./fex-rootfs.nix
    ../../nixos
  ];

  nixpkgs.overlays = [
    aurora.inputs.apple-silicon.overlays.default
    aurora.overlays.default
  ];

  aurora.desktop = "minimal"; # dont's install DE
  zramSwap.enable = true;
  networking.hostName = "asahi";
  system.stateVersion = "25.05";
  environment.systemPackages = [ pkgs.fex ];

  programs.steam = {
    enable = true;
    package = pkgs.steam.override { proton = null; };
  };

  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = false;

    # The macOS ESP is only ~476 MiB. GRUB has to copy each generation's
    # kernel + initrd there (root is LUKS, so it can't read /nix/store).
    # Keep just the current and one previous generation.
    grub.configurationLimit = 2;
  };

  hardware = {
    # asahi.enable = true;
    bluetooth.enable = true;
  };

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 8 * 1024;
    }
  ];

}
