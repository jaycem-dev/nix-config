{ inputs, ... }:
{
  imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    enable = true;

    packages = [
      {
        flatpakref = "https://flatpak.ladybird.org/ladybird.flatpakref";
        sha256 = "11yvglmzxaxzhlkiy2qvybvas2djl8rzzcad1j86dksb528csr3q";
      }
    ];
  };
}
