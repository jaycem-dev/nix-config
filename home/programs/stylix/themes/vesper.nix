{
  polarity = "dark";
  base16Scheme = {
    # Greyscale Ramp (from Rauno Freiberg's original Vesper & Noctalia surface tokens)
    base00 = "#101010"; # Background (Rauno original editor.background)
    base01 = "#1c1c1c"; # Lighter background / gutter (Rauno input.background / Noctalia mSurfaceVariant)
    base02 = "#282828"; # Selection / hover (Rauno list.hoverBackground / Noctalia mHover)
    base03 = "#505050"; # Comments / line numbers (Rauno editorLineNumber / Noctalia mOutline)
    base04 = "#a0a0a0"; # Dark foreground / muted (Rauno keyword, operator / Noctalia mOnSurfaceVariant)
    base05 = "#ffffff"; # Default text / variables (Rauno editor.foreground / Noctalia mOnSurface)
    base06 = "#f5f5f5"; # Light foreground
    base07 = "#ffffff"; # Lightest tone

    # Accent Colors (grounded in upstream Noctalia mPrimary + Rauno original token colors)
    base08 = "#ff8080"; # Red: errors, deleted, invalid (Rauno invalid / Noctalia mError)
    base09 = "#ffb170"; # Warm Amber: numbers, constants (Noctalia light.mPrimary)
    base0A = "#ffcfa8"; # Peach / Soft Orange: classes, types, search (Rauno link/button hover)
    base0B = "#99ffe4"; # Peppermint: strings, added diff (Rauno string / Noctalia mSecondary)
    base0C = "#7be8d5"; # Mint Cyan: regex, escape chars (peppermint cyan)
    base0D = "#ffc799"; # PRIMARY: functions, headings, active UI borders (Noctalia mPrimary / Rauno Function)
    base0E = "#fbadff"; # Lavender: keywords, storage, tags (Noctalia mTertiary)
    base0F = "#ff7300"; # Deep Orange: warnings, delimiters (Rauno statusBar.debuggingBackground)
  };
  image = {
    url = "https://github.com/AngelJumbo/gruvbox-wallpapers/blob/main/wallpapers/photography/forest-2.jpg?raw=true";
    hash = "sha256-RqzCCnn4b5kU7EYgaPF19Gr9I5cZrkEdsTu+wGaaMFI=";
  };
}
