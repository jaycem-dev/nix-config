{
  config,
  pkgs,
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
      mini-ai
      mini-diff
      mini-extra
      mini-git
      mini-icons
      mini-pairs
      mini-pick
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
    initLua = ''
      vim.opt.winborder = "${border}"
      vim.opt.pumborder = "${border}"
      ${builtins.readFile ./lua/options.lua}
      ${builtins.readFile ./lua/plugins.lua}
      ${builtins.readFile ./lua/picker.lua}
      ${builtins.readFile ./lua/languages.lua}
      ${builtins.readFile ./lua/keymaps.lua}
      ${builtins.readFile ./lua/autocmd.lua}
    '';
  };
}
