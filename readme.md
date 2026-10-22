# Nix Config

My setup for NixOS.

I use Colemak-DH-ISO keyboard layout by default, you can change this in [keyboard.nix](./nixos/services/default.nix).

> [!IMPORTANT]
> New NixOS installs usually require copying `/etc/nixos/hardware-configuration.nix` to the host directory or you won't be able to boot.

## Install

Choose a `<host>` from one of the values below. (See my current configurations in [hosts](./hosts)

- desktop                             
- asahi (arm64, needs --impure flag) 

```bash
# Clone this repo using nix-shell:
nix-shell -p git neovim --command "git clone https://github.com/jaycem-dev/nix-config ~/Projects/nix-config && cd ~/Projects/nix-config; return"

# Modify config if necessary, then rebuild:
sudo nixos-rebuild switch --flake .#<host>
```

The pkg [nh](https://github.com/nix-community/nh) is configured to use `~/Projects/nix-config` automatically, so after the initial rebuild you can use `nh os switch` from anywhere.

## Software

- Compositor and tools: Hyprland, Noctalia
- Main programs: Neovim, Kitty
- Theming: Stylix
