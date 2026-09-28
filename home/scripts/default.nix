{ pkgs, ... }: {
  home.packages = [
    (pkgs.writeShellApplication {
      name = "dmenu-power";
      text = builtins.readFile ./dmenu-power.sh;
      runtimeInputs = with pkgs; [
        noctalia
        swaylock
      ];
    })

    (pkgs.writeShellApplication {
      name = "projects-picker";
      text = builtins.readFile ./projects-picker.sh;
      runtimeInputs = with pkgs; [
        fd
        fzf
      ];
    })

    (pkgs.writeShellApplication {
      name = "projects";
      text = builtins.readFile ./projects.sh;
      runtimeInputs = with pkgs; [
        kitty
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
