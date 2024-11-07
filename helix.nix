{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs.unstable; [
    # language servers
    typescript-language-server
    vscode-langservers-extracted
    bash-language-server
    rust-analyzer
    lua-language-server
    vue-language-server
    svelte-language-server
    yaml-language-server
    taplo
    dockerfile-language-server-nodejs
    nil
    marksman

    # formatters
    prettierd
    nixfmt-rfc-style
    stylua
    deno
    shfmt
    rustfmt

    # package managers
    pnpm
    cargo

    # compilers
    rustc
    gcc
  ];
  home-manager.users.${config.user}.programs.helix = {
    enable = true;
    defaultEditor = true;
    package = pkgs.unstable.helix;

    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "nix";
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
          auto-format = true;
        }
        {
          name = "toml";
          formatter.command = "${pkgs.taplo}/bin/taplo";
          formatter.args = [
            "format"
            "-"
          ];
          auto-format = true;
        }
        {
          name = "lua";
          formatter.command = "${pkgs.stylua}/bin/stylua";
          formatter.args = [ "-" ];
        }
        {
          name = "python";
          formatter.command = "${pkgs.ruff}/bin/ruff";
          formatter.args = [
            "format"
            "--line-length"
            "88"
            "-"
          ];
          auto-format = true;
        }
        {
          name = "bash";
          indent = {
            tab-width = 4;
            unit = "\t";
          };
          formatter.command = "${pkgs.shfmt}/bin/shfmt";
          auto-format = true;
        }
        {
          name = "javascript";
          formatter.command = "${pkgs.deno}/bin/deno";
          formatter.args = [
            "fmt"
            "-"
            "--ext"
            "js"
          ];
          auto-format = true;
        }
        {
          name = "json";
          formatter.command = "${pkgs.deno}/bin/deno";
          formatter.args = [
            "fmt"
            "-"
            "--ext"
            "json"
          ];
        }
        {
          name = "markdown";
          formatter.command = "${pkgs.deno}/bin/deno";
          formatter.args = [
            "fmt"
            "-"
            "--ext"
            "md"
          ];
          auto-format = true;
        }
        {
          name = "typescript";
          formatter.command = "${pkgs.deno}/bin/deno";
          formatter.args = [
            "fmt"
            "-"
            "--ext"
            "ts"
          ];
          auto-format = true;
        }
        {
          name = "jsx";
          formatter.command = "${pkgs.deno}/bin/deno";
          formatter.args = [
            "fmt"
            "-"
            "--ext"
            "jsx"
          ];
          auto-format = true;
        }
        {
          name = "tsx";
          formatter.command = "${pkgs.deno}/bin/deno";
          formatter.args = [
            "fmt"
            "-"
            "--ext"
            "tsx"
          ];
          auto-format = true;
        }
      ];
    };

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        auto-info = false;
        soft-wrap.enable = true;
        line-number = "relative";
        cursorline = true;
        statusline.left = [ ];
        statusline.center = [ ];
        statusline.right = [
          "spinner"
          "file-name"
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
        backspace = ":write-buffer-close";
        right = "goto_word";
        up = "select_textobject_inner";
        down = "select_textobject_around";
        x = "select_line_below";
        X = "select_line_above";
        g.l = "extend_to_line_end";
        g.h = "extend_to_line_start";
        S-left = "jump_backward";
        S-right = "jump_forward";
        ret = ":write";
        space.x = ":write-quit-all";
        g.x = ":buffer-close-others";
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
        ];
        esc = [
          "keep_primary_selection"
          "collapse_selection"
        ];
        p = "paste_clipboard_after";
        P = "paste_clipboard_before";
        y = "yank_to_clipboard";
        Y = "yank_joined_to_clipboard";
        R = "replace_selections_with_clipboard";
        d = [
          "yank_to_clipboard"
          "delete_selection_noyank"
        ];
        # g.U = "switch_to_uppercase"
        #Alt-s Alt-_ Alt-C Alt-J Alt-K e
      };
    };

  };
}
