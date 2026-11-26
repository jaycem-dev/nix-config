{ pkgs, ... }: {
  home.packages = [
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
      name = "steam-exes";
      text = builtins.readFile ./steam-exes.sh;
      runtimeInputs = with pkgs; [
        coreutils
        fd
        gnused
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
