{
  config,
  pkgs,
  lib,
  ...
}:
let
  border = if config.userSettings.theme.borderRadius == 0 then "single" else "rounded";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      conform-nvim
      copilot-vim
      diffview-nvim
      flash-nvim
      friendly-snippets
      fzf-lua
      mini-ai
      mini-diff
      mini-git
      mini-icons
      mini-pairs
      mini-statusline
      mini-surround
      neogit
      nvim-colorizer-lua
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      oil-nvim
      render-markdown-nvim
      which-key-nvim
    ];

    extraPackages = with pkgs; [
      fd
      fzf
      ripgrep
    ];

    initLua = ''
      vim.opt.shell = "${lib.getExe pkgs.zsh}"
      vim.opt.winborder = "${border}"
      vim.opt.pumborder = "${border}"
      ${builtins.readFile ./lua/main.lua}
      ${builtins.readFile ./lua/picker.lua}
      ${builtins.readFile ./lua/languages.lua}
      ${builtins.readFile ./lua/keymaps.lua}
    '';
  };
}
