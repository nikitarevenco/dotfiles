{
  pkgs,
  lib,
  inputs,
  pkgs-unstable,
  ...
}:
{
  programs.helix = {
    defaultEditor = true;
    enable = true;
    package = inputs.helix.packages.${pkgs.system}.helix;

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
      keys.select = {
        H = "extend_prev_sub_word_start";
        L = "extend_next_sub_word_start";
      };
      keys.normal = {
        right = "goto_word";
        up = "select_textobject_inner";
        down = "select_textobject_around";
        H = "move_prev_sub_word_start";
        L = "move_next_sub_word_start";
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
        space.n = "file_browser";
        g.s = [
          "collapse_selection"
          "select_mode"
          "goto_first_nonwhitespace"
          "exit_select_mode"
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

    languages = {
      language-server = {
        tailwindcss = {
          command = lib.getExe pkgs-unstable.tailwindcss-language-server;
          args = [ "--stdio" ];
        };
      };

      language = map (language: language // { auto-format = true; }) ([
        {
          name = "typescript";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".ts" ];
          language-servers = [
            "tailwindcss"
            "typescript-language-server"
          ];
        }
        {
          name = "yaml";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".yaml" ];
        }
        {
          name = "markdown";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".md" ];
        }
        {
          name = "scss";
          formatter.command = "prettierd";
          formatter.args = [ ".scss" ];
        }
        {
          name = "css";
          formatter.command = "prettierd";
          formatter.args = [ ".css" ];
        }
        {
          name = "tsx";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".tsx" ];
          language-servers = [
            "tailwindcss"
            "typescript-language-server"
          ];
        }
        {
          name = "jsx";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".jsx" ];
        }
        {
          name = "json";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".json" ];
        }
        {
          name = "html";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".html" ];
        }
        {
          name = "javascript";
          formatter.command = lib.getExe pkgs-unstable.prettierd;
          formatter.args = [ ".js" ];
        }
        {
          name = "nix";
          formatter.command = lib.getExe pkgs-unstable.nixfmt-rfc-style;
        }
        {
          name = "lua";
          formatter.command = lib.getExe pkgs-unstable.stylua;
          formatter.args = [ "-" ];
        }
        {
          name = "bash";
          formatter.command = lib.getExe pkgs-unstable.shfmt;
        }
      ]);
    };
  };
}
