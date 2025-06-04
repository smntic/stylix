# Based on the official catppuccin themes https://github.com/yazi-rs/themes
{
  config,
  lib,
  ...
}: {
  options.stylix.targets.yazi = {
    enable = config.lib.stylix.mkEnableTarget "Yazi" true;
  };

  config = lib.mkIf (config.stylix.enable && config.stylix.targets.yazi.enable) {
    programs.yazi.theme = with config.lib.stylix.colors.withHashtag; let
      mkFg = fg: {inherit fg;};
      mkBg = bg: {inherit bg;};
      mkBoth = fg: bg: {inherit fg bg;};
      mkSame = c: (mkBoth c c);
    in {
      mgr = rec {
        # Reusing bat themes, since it's suggested in the stying guide
        # https://yazi-rs.github.io/docs/configuration/theme#manager
        syntect_theme = config.lib.stylix.colors {
          template = ../bat/base16-stylix.mustache;
          extension = ".tmTheme";
        };

        cwd = mkFg base0C;
        hovered = (mkBg base02) // {
          bold = true;
        };
        preview_hovered = hovered;
        find_keyword = (mkFg green) // {
          bold = true;
        };
        find_position = mkFg magenta;
        marker_selected = mkSame yellow;
        marker_copied = mkSame green;
        marker_cut = mkSame red;
        tab_active = mkBoth base00 blue;
        tab_inactive = mkBoth base05 base01;
        border_style = mkFg base04;
  
        count_copied = mkBoth base00 green;
        count_cut = mkBoth base00 red;
        count_selected = mkBoth base00 yellow;
      };

      mode = {
        normal_main = (mkBoth base00 blue) // {
          bold = true;
        };
        normal_alt = mkBoth blue base00;
        select_main = (mkBoth base00 green) // {
          bold = true;
        };
        select_alt = mkBoth green base00;
        unset_main = (mkBoth base00 brown) // {
          bold = true;
        };
        unset_alt = mkBoth brown base00;
      };

      status = {
        progress_label = mkBoth base05 base00;
        progress_normal = mkBoth base05 base00;
        progress_error = mkBoth red base00;
        perm_type = mkFg blue;
        perm_read = mkFg yellow;
        perm_write = mkFg red;
        perm_exec = mkFg green;
        perm_sep = mkFg cyan;
      };

      pick = {
        border = mkFg blue;
        active = mkFg magenta;
        inactive = mkFg base05;
      };

      input = {
        border = mkFg blue;
        title = mkFg base05;
        value = mkFg base05;
        selected = mkBg base03;
      };

      completion = {
        border = mkFg blue;
        active = mkBoth magenta base03;
        inactive = mkFg base05;
      };

      tasks = {
        border = mkFg blue;
        title = mkFg base05;
        hovered = mkBoth base05 base03;
      };

      which = {
        mask = mkBg base02;
        cand = mkFg cyan;
        rest = mkFg brown;
        desc = mkFg base05;
        separator_style = mkFg base04;
      };

      help = {
        on = mkFg magenta;
        run = mkFg cyan;
        desc = mkFg base05;
        hovered = mkBoth base05 base03;
        footer = mkFg base05;
      };

      # https://github.com/sxyazi/yazi/blob/main/yazi-config/preset/theme.toml
      filetype.rules = let
        mkRule = mime: fg: {inherit mime fg;};
      in [
        (mkRule "image/*" base0C)
        (mkRule "video/*" base0A)
        (mkRule "audio/*" base0A)

        (mkRule "application/zip" base0E)
        (mkRule "application/gzip" base0E)
        (mkRule "application/x-tar" base0E)
        (mkRule "application/x-bzip" base0E)
        (mkRule "application/x-bzip2" base0E)
        (mkRule "application/x-7z-compressed" base0E)
        (mkRule "application/x-rar" base0E)
        (mkRule "application/xz" base0E)

        (mkRule "application/doc" base0B)
        (mkRule "application/pdf" base0B)
        (mkRule "application/rtf" base0B)
        (mkRule "application/vnd.*" base0B)

        ((mkRule "inode/directory" base0D) // {bold = true;})
        (mkRule "*" base05)
      ];
    };
  };
}
