{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "dmenu-projects";
      text = builtins.readFile ./dmenu-projects.sh;
      runtimeInputs = with pkgs; [
        fd
        kitty
        noctalia
      ];
    })

    (pkgs.writeShellApplication {
      name = "tmux-sessions";
      text = builtins.readFile ./sessions.sh;
      runtimeInputs = with pkgs; [
        fd
        fzf
        tmux
      ];
    })
  ];
}
