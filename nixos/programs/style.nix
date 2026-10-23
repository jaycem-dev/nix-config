{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      font-awesome
      geist-font
      jetbrains-mono
      nerd-fonts.symbols-only
    ];
  };

  environment.systemPackages = with pkgs; [
    adw-gtk3
  ];
}
