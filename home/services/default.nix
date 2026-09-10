{
  imports = [
    ./mako.nix
    ./polkit.nix
    ./hypridle.nix
  ];

  services = {
    wpaperd.enable = true;
  };
}
