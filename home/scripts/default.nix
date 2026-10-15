{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "projects-picker";
      text = builtins.readFile ./projects-picker.sh;
      runtimeInputs = with pkgs; [
        fd
        fzf
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

    (pkgs.writeShellApplication {
      name = "spawn-or-focus";
      text = builtins.readFile ./spawn-or-focus.sh;
      runtimeInputs = with pkgs; [
        kitty
        jq
        brave-origin
      ];
    })
  ];
}
