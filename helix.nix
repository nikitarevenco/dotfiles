{
  programs.helix = {
    enable = true;
  	settings = {
      theme = "catppuccin_mocha";
  	  editor = {
        auto-info = false;
        soft-wrap.enable = true;
        line-number = "relative";
        auto-save = true;
        cursorline = true;
        statusline.left = [ "mode" "spinner" "version-control" "file-name" ];
        indent-guides = {
          character = "╎";
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
      };
  	};
  };
}
