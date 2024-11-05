{
  enable = true;
	settings = {
    theme = "catppuccin_mocha";
	  editor = {
      # persistence = {
      #   old-files = true;
      #   commands = true;
      #   search = true;
      #   clipboard = true;
      # };
      auto-info = false;
      soft-wrap.enable = true;
      line-number = "relative";
      auto-save = true;
      cursorline = true;
      statusline.left = [ "mode" "spinner" "version-control" "file-name" ];
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
    };
	};
}
