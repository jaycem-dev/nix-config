{
  pkgs,
  lib,
  ...
}:
{
  programs = {
    gamemode.enable = true;

    gamescope = {
      enable = true;
      capSysNice = true;
    };

    steam = lib.mkIf pkgs.stdenv.hostPlatform.isx86_64 {
      enable = true;
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };

  environment.systemPackages =
    with pkgs;
    [
      # rpcs3
      dolphin-emu
      duckstation
      gopher64
      lsfg-vk
      mangohud
      ryubing
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      heroic
      pcsx2
      shadps4
    ];
}
