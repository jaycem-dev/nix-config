{ pkgs, ... }:
let
  fexRootfs = pkgs.fetchurl {
    url = "https://rootfs.fex-emu.gg/Fedora_44/2026-08-11/Fedora_44.ero";
    sha256 = "db2503c4ff24a2e0d39ab169d05a13a91202b26d2e87323400cc51b46a6e1c58";
  };
in
{
  boot.kernelModules = [
    "erofs"
    "loop"
  ];

  fileSystems."/var/lib/aurora/fex/rootfs" = {
    device = "${fexRootfs}";
    fsType = "erofs";
    # nofail keeps the machine bootable if the image cannot be mounted;
    # x86 games are the only thing lost in that case.
    options = [
      "loop"
      "ro"
      "nofail"
    ];
  };
}
