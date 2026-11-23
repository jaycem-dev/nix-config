{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    kitty = {
      enable = true;
      enableGitIntegration = true;
      quickAccessTerminalConfig.background_opacity = config.stylix.opacity.terminal;

      settings = {
        shell = lib.getExe pkgs.zsh;
        cursor_trail = 1;
        tab_bar_edge = "top";
        tab_title_template = "{'[' + session_name + '] ' if session_name else ''}{title}";
        tab_bar_filter = "session:~ or session:^$";
        allow_remote_control = "socket-only";
        enable_audio_bell = false;
        update_check_interval = 0;
        background_blur = 1;
      };

      actionAliases = {
        launch_tab = "launch --cwd current --type tab";
        launch_overlay = "launch --cwd current --type overlay";
      };

      keybindings = {
        "kitty_mod+t" = "launch_tab";
        "kitty_mod+g" = "launch_tab --tab-title git --focus-existing=@title lazygit";
        "kitty_mod+a" = "launch_tab --tab-title opencode --focus-existing=@title opencode";
      };
    };
  };
}
