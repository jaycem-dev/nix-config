{
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "America/Santiago";
  i18n.extraLocaleSettings.LC_TIME = "en_GB.UTF-8"; # monday as 1st week day
  hardware.i2c.enable = true; # ddcutil req

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "@wheel"
      "@admin"
    ];
  };
}
