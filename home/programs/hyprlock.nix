{
  programs.hyprlock = {
    enable = true;
    settings = {
      label = {
        text = "<b>$TIME</b>";
        font_size = 96;
        position = "0, 8%";
      };

      input-field = {
        position = "0, -8%";
        fade_on_empty = false;
      };
    };
  };
}
