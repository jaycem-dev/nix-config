{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "dmenu-projects";
      text = builtins.readFile ./dmenu-projects.sh;
      runtimeInputs = with pkgs; [kitty];
    })

    (pkgs.writeShellApplication {
      name = "launch-or-focus";
      text = builtins.readFile ./launch-or-focus.sh;
      runtimeInputs = with pkgs; [jq];
    })

    (pkgs.writeShellApplication {
      name = "tmux-sessions";
      text = builtins.readFile ./sessions.sh;
      runtimeInputs = with pkgs; [fd fzf tmux];
    })
  ];
}
