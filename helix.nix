{
  u,
  lib,
  pkgs,
}:
{
  enable = true;
  defaultEditor = true;
  package = u.helix;

  settings = {
    theme = "catppuccin_mocha";
    editor = {
      auto-info = false;
      soft-wrap.enable = true;
      line-number = "relative";
      auto-save = true;
      cursorline = true;
      statusline.left = [ ];
      statusline.center = [ ];
      statusline.right = [
        "spinner"
        "file-name"
        "read-only-indicator"
        "file-modification-indicator"
        "diagnostics"
      ];
      indent-guides = {
        character = "╎";
        skip-levels = 1;
        render = true;
      };
      cursor-shape = {
        insert = "bar";
        select = "underline";
      };
    };
    keys.normal = {
      right = "goto_word";
      up = "select_textobject_inner";
      down = "select_textobject_around";
      x = "select_line_below";
      X = "select_line_above";
      g.l = "extend_to_line_end";
      g.h = "extend_to_line_start";
      g.s = [
        "collapse_selection"
        "select_mode"
        "goto_first_nonwhitespace"
        "exit_select_mode"
      ];
      C-d = [
        "page_cursor_half_down"
        "align_view_center"
      ];
      C-u = [
        "page_cursor_half_up"
        "align_view_center"
      ];
      esc = [
        "keep_primary_selection"
        "collapse_selection"
      ];
      # g.U = "switch_to_uppercase"
      #Alt-s Alt-_ Alt-C Alt-J Alt-K
    };
  };
}
