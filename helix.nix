# {
#   config,
#   pkgs,
#   lib,
#   ...
# }:
{
  programs.helix = {
    defaultEditor = true;
    enable = true;
    # package = pkgs.unstable.helix;

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        auto-info = false;
        soft-wrap.enable = true;
        line-number = "relative";
        cursorline = true;
        statusline = {
          left = [ ];
          center = [ ];
          right = [
            "spinner"
            "file-name"
            "diagnostics"
          ];
        };
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
        "," = {
          "." = "repeat_last_motion";
          "`" = "switch_to_uppercase";
          d = "delete_selection_noyank";
          c = "change_selection_noyank";
          C = "copy_selection_on_prev_line";
          s = "split_selection_on_newline";
          minus = "merge_selections";
          _ = "merge_consecutive_selections";
          ";" = "flip_selections";
          o = "expand_selection";
          i = "shrink_selection";
          I = "select_all_children";
          m = "select_all_children";
          p = "select_prev_sibling";
          n = "select_next_sibling";
          e = "move_parent_node_end";
          b = "move_parent_node_start";
          a = "select_all_siblings";
          x = "shrink_to_line_bounds";
          J = "join_selections_space";
          K = "remove_selections";
          "," = "remove_primary_selection";
          "(" = "rotate_selection_contents_backward";
          ")" = "rotate_selection_contents_forward";
          ":" = "ensure_selections_forward";
          B = "toggle_block_comments";
          "!" = "shell_append_output";
          "|" = "shell_pipe_to";
          u = "earlier";
          U = "later";
        };
        S-left = "jump_backward";
        S-right = "jump_forward";
        ret = ":write";
        space.x = ":write-quit-all";
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
        C-g = [
          ":write-all"
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
          ":reload-all"
        ];
        esc = [
          "keep_primary_selection"
          "collapse_selection"
        ];
      };
    };

    # languages =
    #   let
    #     prettierd-formatted = (
    #       map
    #         (language: {
    #           name = language;
    #           formatter = {
    #             command = lib.getExe pkgs.unstable.prettierd;
    #             args = [
    #               "--stdin-filepath"
    #               "{}"
    #             ];
    #           };
    #         })
    #         [
    #           "javascript"
    #           "json"
    #           "markdown"
    #           "typescript"
    #           "jsx"
    #           "tsx"
    #           "toml"
    #         ]
    #     );
    #   in
    #   {
    #     language-server = {
    #       tailwind = {
    #         command = lib.getExe pkgs.unstable.tailwindcss-language-server;
    #       };
    #     };

    #     language = map (language: language // { auto-format = true; }) (
    #       prettierd-formatted
    #       ++ [
    #         {
    #           name = "nix";
    #           formatter.command = lib.getExe pkgs.unstable.nixfmt-rfc-style;
    #         }
    #         {
    #           name = "lua";
    #           formatter.command = lib.getExe pkgs.unstable.stylua;
    #           formatter.args = [ "-" ];
    #         }
    #         {
    #           name = "python";
    #           formatter.command = lib.getExe pkgs.unstable.ruff;
    #           formatter.args = [
    #             "format"
    #             "--line-length"
    #             "88"
    #             "-"
    #           ];
    #         }
    #         {
    #           name = "bash";
    #           indent = {
    #             tab-width = 4;
    #             unit = "\t";
    #           };
    #           formatter.command = lib.getExe pkgs.unstable.shfmt;
    #         }
    #       ]
    #     );
    #   };
  };
}
