{
  pkgs,
  lib,
  flakePath,
  ...
}:
{
  programs = {
    gamemode.enable = true;
    virt-manager.enable = true;

    niri = {
      enable = true;
      useNautilus = false;
    };

    nh = {
      enable = true;
      flake = flakePath;
      clean = {
        enable = true;
        extraArgs = "--keep 2";
      };
    };

    steam = lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };

  environment.systemPackages = with pkgs; [
    # libvirt networking
    dnsmasq
  ];
}
