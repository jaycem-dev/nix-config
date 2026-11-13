{ lib, ... }:
{
  boot = {
    plymouth.enable = true; # boot animation
    consoleLogLevel = 0; # silent boot
    kernelModules = [ "ntsync" ];

    loader = {
      systemd-boot.enable = lib.mkDefault true;
      efi.canTouchEfiVariables = lib.mkDefault true;
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=false"
    ];
  };
}
