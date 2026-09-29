{
  inputs,
  config,
  ...
}:
let
  skills = {
    caveman = "${inputs.caveman}/skills/caveman";
  };
in
{
  programs = {
    antigravity-cli = {
      enable = true;
      inherit skills;
      permissions = {
        allow = [
          "read_file(/nix/store)"
          "read_file(/tmp)"
          "read_file(~/.config)"
        ];
        deny = [
          "write_file(/nix/store)"
        ];
        ask = [
          "write_file(~/.config)"
        ];
      };
      settings = {
        privacy.usageStatisticsEnabled = false;
        telemetry.enabled = false;
      };
    };
    codex = {
      enable = true;
      inherit skills;
      settings = {
        analytics.enabled = false;
        default_permissions = "mine";
        permissions.mine = {
          extends = ":workspace";
          filesystem = {
            "/nix/store" = "read";
            "/tmp" = "read";
            "${config.xdg.configHome}" = "read";
          };
        };
      };
    };

    opencode = {
      enable = true;
      inherit skills;
      tui.attention = {
        enabled = true;
        sound = false;
      };
      settings = {
        permission = {
          external_directory = {
            "/nix/store/**" = "allow";
            "/tmp/**" = "allow";
            "~/.config/**" = "allow";
          };
          edit = {
            "/nix/store/**" = "deny";
            "~/.config/**" = "ask";
          };
        };
      };
    };
  };
}
