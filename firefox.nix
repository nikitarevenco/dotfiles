{
  enable = true;
  profiles.nikita = {
    # extensions = with (import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz")).repos.rycee.firefox-addons; [
    #   # https://github.com/TLATER/dotfiles/blob/b39af91fbd13d338559a05d69f56c5a97f8c905d/home-config/config/graphical-applications/firefox.nix
    #   react-devtools
    #   ublock-origin
    #   clearurls
    #   stylus
    #   darkreader
    #   proton-pass
    #   sponsorblock
    # ];
    settings = {
      "app.update.auto" = false;
      "browser.discovery.enabled" = false;
      "browser.startup.homepage" = "about:blank";
      "general.smoothScroll" = true;
      "signon.rememberSignons" = false;
      "signon.autofillForms" = false;
      "widget.non-native-theme.scrollbar.style" = 3;
      "browser.uidensity" = 1;
      "browser.compactmode.show" = true;
      # disable full screen fade animation
      "full-screen-api.transition-duration.enter" = "0 0";
      "full-screen-api.transition-duration.leave" = "0 0";
      "full-screen-api.transition.timeout" = 0;
      "full-screen-api.warning.delay" = 0;
      "full-screen-api.warning.timeout" = 0;
    };
  };
}
