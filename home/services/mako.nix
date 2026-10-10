{ config, ... }:
{
  services.mako = {
    enable = true;

    settings = {
      width = 400;
      padding = 10;
      margin = 15;
      border-size = 2;
      border-radius = config.userSettings.theme.borderRadius;
      layer = "overlay";

      "category=osd" = {
        anchor = "top-center";
        padding = 5;
        width = 200;
        height = 50;
        default-timeout = 1500;
      };
    };
  };
}
