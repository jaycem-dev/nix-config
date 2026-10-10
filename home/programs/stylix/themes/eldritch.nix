{
  polarity = "dark";
  base16Scheme = {
    base00 = "#111111";
    base01 = "#2a2a2d";
    base02 = "#3f3f45";
    base03 = "#7081d0";
    base04 = "#a1abe0";
    base05 = "#ebfafa";
    base06 = "#f0f2f4";
    base07 = "#ffffff";
    base08 = "#f16c75";
    base09 = "#f7c67f";
    base0A = "#f1fc79";
    base0B = "#37f499";
    base0C = "#04d1f9";
    base0D = "#39ddfd";
    base0E = "#a48cf2";
    base0F = "#f265b5";
  };
  image = {
    url = "https://w.wallhaven.cc/full/p8/wallhaven-p88lvp.jpg";
    hash = "sha256-GSV1fEwV4p1e0f72cyGhKuOKGWDSvbhejJOSuEYQweI=";
  };

  neovim = {
    plugin = "eldritch-nvim";
    config = ''
      require("eldritch").setup({ transparent = true })

      vim.cmd.colorscheme("eldritch")
    '';
  };
}
