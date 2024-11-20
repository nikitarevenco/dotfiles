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
      };
      keys.normal = {
        x = "select_line_below";
        X = "select_line_above";
        up = "select_textobject_inner";
        down = "select_textobject_around";
        left = "@]";
        right = "@[";
        backspace = "goto_word";
        D = "copy_selection_on_prev_line";
        V = "remove_primary_selection";
        L = "expand_selection";
        H = "shrink_selection";
        S-left = "jump_backward";
        S-right = "jump_forward";
        ret = ":write";
        space.x = ":write-quit-all";
        space.n = "file_browser";
        g.s = "extend_to_first_nonwhitespace";
        C-g = [
          ":write-all"
          ":new"
          ":insert-output lazygit"
          ":buffer-close!"
          ":redraw"
          ":reload-all"
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

      language =
        let
          prettier = lib.getExe pkgs-unstable.prettierd;
        in
        map (language: language // { auto-format = true; }) ([
          {
            name = "typescript";
            formatter.command = prettier;
            formatter.args = [ ".ts" ];
            language-servers = [
              "tailwindcss"
              "typescript-language-server"
            ];
          }
          {
            name = "astro";
            formatter.command = prettier;
            formatter.args = [ "--parser astro" ];
          }
          {
            name = "yaml";
            formatter.command = prettier;
            formatter.args = [ ".yaml" ];
          }
          {
            name = "markdown";
            formatter.command = prettier;
            formatter.args = [ ".md" ];
          }
          {
            name = "scss";
            formatter.command = prettier;
            formatter.args = [ ".scss" ];
          }
          {
            name = "css";
            formatter.command = prettier;
            formatter.args = [ ".css" ];
          }
          {
            name = "tsx";
            formatter.command = prettier;
            formatter.args = [ ".tsx" ];
            language-servers = [
              "tailwindcss"
              "typescript-language-server"
            ];
          }
          {
            name = "jsx";
            formatter.command = prettier;
            formatter.args = [ ".jsx" ];
          }
          {
            name = "json";
            formatter.command = prettier;
            formatter.args = [ ".json" ];
          }
          {
            name = "html";
            formatter.command = prettier;
            formatter.args = [ ".html" ];
          }
          {
            name = "javascript";
            formatter.command = prettier;
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
          {
            name = "haskell";
          }
          # {
          #   name = "haskell";
          # }
          # {
          #   name = "haskell";
          # }
          # {
          #   name = "haskell";
          #   formatter.command = lib.getExe pkgs-unstable.ormolu;
          #   formatter.ags = [
          #     "--stdin-input-file"
          #     "."
          #   ];
          # }
        ]);
    };
  };
}
