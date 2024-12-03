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

    settings =
      let
        keybindings = {
          P = "paste_clipboard_before";
          p = "paste_clipboard_after";
          y = "yank_to_clipboard";
          R = "replace_selections_with_clipboard";
          d = [
            "yank_to_clipboard"
            "delete_selection_noyank"
          ];
          space.R = "replace_with_yanked";
          space.y = "yank";
          space.p = "paste_after";
          space.P = "paste_before";
          x = "select_line_below";
          X = "select_line_above";
          S-left = "jump_backward";
          S-right = "jump_forward";
          S = "split_selection_on_newline";
          ret = ":write";
          space.x = ":write-quit-all";
          space.n = "file_browser";
          g.S = "extend_to_first_nonwhitespace";
          D = "copy_selection_on_prev_line";
          L = "expand_selection";
          H = "shrink_selection";
          up = "select_textobject_inner";
          down = "select_textobject_around";
          left = "@]";
          right = "@[";
          "`"."u" = "switch_to_uppercase";
          "`"."l" = "switch_to_lowercase";
          # delete current line
          A-d = [
            "collapse_selection"
            "extend_to_line_bounds"
            "yank_to_clipboard"
            "delete_selection_noyank"
          ];
          # change current line
          A-c = [
            "collapse_selection"
            "extend_to_line_bounds"
            "change_selection"
          ];
          # open lazygit
          C-g = [
            ":write-all"
            ":new"
            ":insert-output lazygit"
            ":buffer-close!"
            ":redraw"
            ":reload-all"
          ];
          # delete two lines below
          C-j = [
            "extend_to_line_bounds"
            "extend_line_below"
            "delete_selection"
          ];
          # delete two lines above
          C-k = [
            "extend_to_line_bounds"
            "extend_line_above"
            "delete_selection"
          ];
        };
      in
      {
        theme = "catppuccin_mocha";
        editor = {
          auto-info = false;
          soft-wrap.enable = true;
          line-number = "relative";
          inline-diagnostics = {
            cursor-line = "hint";
          };
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
        keys.select = keybindings // {
          backspace = "extend_to_word";
        };
        keys.normal = keybindings // {
          backspace = "goto_word";
        };
      };

    languages = {
      language-server = {
        mdx = {
          command = "mdx-language-server";
          args = [ "--stdio" ];
        };
        tailwindcss = {
          command = lib.getExe pkgs-unstable.tailwindcss-language-server;
          args = [ "--stdio" ];
        };
        ruff = {
          command = lib.getExe pkgs-unstable.ruff;
        };
        gopls.config.gofumpt = true;
        astro-ls = {
          command = lib.getExe pkgs-unstable.nodePackages."@astrojs/language-server";
          args = [ "--stdio" ];
          config = {
            typescript = {
              tsdk = "${pkgs-unstable.typescript}/lib/node_modules/typescript/lib";
              environment = "node";
            };
          };
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
            scope = "source.astro";
            injection-regex = "astro";
            file-types = [ "astro" ];
            roots = [
              "package.json"
              "astro.config.mjs"
            ];
            language-servers = [ "astro-ls" ];
            formatter = {
              command = prettier;
              args = [
                "--plugin"
                "prettier-plugin-astro"
                "--parser"
                "astro"
              ];
            };
          }
          {
            name = "yaml";
            formatter.command = prettier;
            formatter.args = [ ".yaml" ];
          }
          {
            name = "python";
            language-servers = [
              "pyright"
              "ruff"
            ];
          }
          {
            name = "markdown";
            formatter.command = prettier;
            language-servers = [
              "mdx"
              "tailwind"
            ];
            formatter.args = [ "--parser markdown" ];
          }
          {
            name = "mdx";
            formatter.command = prettier;
            formatter.args = [ "--parser mdx" ];
            grammar = "markdown";
            file-types = [ "mdx" ];
            roots = [ ];
            scope = "source.mdx";
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
            formatter.command = lib.getExe pkgs-unstable.ormolu;
            formatter.args = [
              "--stdin-input-file"
              "."
            ];
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
