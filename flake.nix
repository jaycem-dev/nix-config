{
  description = "Main flake configuration for NixOS";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    aurora.url = "github:aurora-silicon/nixos-aurora/channel-testing";
    home-manager.url = "github:nix-community/home-manager";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:nix-community/stylix";
    caveman = {
      url = "github:JuliusBrussee/caveman/v2.6.0";
      flake = false;
    };
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://aurorasilicon.org/nixos-aurora/cache"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "aurora-nixos-1:ZxmPNEWsrzgXai+W+dlTE8cachb1xaatfXKK8X8go14="
    ];
  };

  outputs =
    { nixpkgs, aurora, ... }@inputs:
    let
      user = "jay";
      commonArgs = { inherit inputs user aurora; };

      systems = {
        linux-arm = "aarch64-linux";
        linux = "x86_64-linux";
      };
    in
    {
      # TODO: create helpers for nix and home
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = systems.linux;
          specialArgs = commonArgs;
          modules = [ ./hosts/desktop ];
        };
        asahi = aurora.inputs.nixpkgs.lib.nixosSystem {
          system = systems.linux-arm;
          specialArgs = commonArgs;
          modules = [ ./hosts/asahi ];
        };
      };

      homeConfigurations = {
        "${user}@desktop" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${systems.linux};
          extraSpecialArgs = commonArgs;
          modules = [ ./hosts/desktop/home.nix ];
        };
        "${user}@asahi" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${systems.linux-arm};
          extraSpecialArgs = commonArgs;
          modules = [ ./hosts/asahi/home.nix ];
        };
      };
    };
}
