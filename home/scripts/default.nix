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
      name = "kitty-sessions";
      text = builtins.readFile ./kitty-sessions.sh;
      runtimeInputs = with pkgs; [
        fd
        fzf
        kitty
        libnotify
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
