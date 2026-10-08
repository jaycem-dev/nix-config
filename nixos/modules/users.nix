{ user, pkgs, ... }: {
  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.zsh;

    extraGroups = [
      "video"
      "networkmanager"
      "wheel"
      "i2c" # allow ddcutil control
      "podman"
      "libvirtd"
      "kvm"
      "gamemode" # allows gamemode to change power scheme
    ];
  };
}
