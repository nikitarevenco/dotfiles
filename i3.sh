focus_wrapping no

# borders
default_border pixel 2
default_floating_border pixel 2
# hide borders if only 1 window on workspace
hide_edge_borders smart

# target                 title        bg        text      indicator   border
client.focused           #cba6f7      #1e1e2e   #cdd6f4   #f5e0dc     #cba6f7
client.focused_inactive  #1e1e2e      #1e1e2e   #cdd6f4   #f5e0dc     #181825
client.unfocused         #1e1e2e      #1e1e2e   #cdd6f4   #f5e0dc     #181825
client.urgent            #fab387      #1e1e2e   #fab387   #6c7086     #fab387
client.placeholder       #1e1e2e      #1e1e2e   #cdd6f4   #1e1e2e     #181825
client.background        #1e1e2e

# media keys
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle
bindsym XF86MonBrightnessUp exec --no-startup-id brightnessctl set +5%
bindsym XF86MonBrightnessDown exec --no-startup-id brightnessctl set 5%-

# launch programs
bindsym F7 exec boomer
bindsym Mod1+k exec flameshot gui
bindsym Mod1+s exec wezterm-gui
bindsym Mod1+r exec firefox
bindsym Mod1+d exec --no-startup-id dmenu_run -fn 'JetBrainsMono Nerd Font' -nf "#cdd6f4" -nb "#181825" -sb "#11111b"

# kill focused window
bindsym Mod1+t kill

# change focus
bindsym Mod1+n focus left
bindsym Mod1+e focus up
bindsym Mod1+i focus down
bindsym Mod1+o focus right

# move focused window
bindsym Mod1+2 move left
bindsym Mod1+4 move down
bindsym Mod1+1 move up
bindsym Mod1+8 move right

bindsym Mod1+m fullscreen toggle
bindsym Mod1+g floating toggle

# switch to workspace
bindsym Mod1+w workspace number 1
bindsym Mod1+f workspace number 2
bindsym Mod1+p workspace number 3
bindsym Mod1+b workspace number 4

# move focused container to workspace
bindsym Mod1+5 move container to workspace number 1
bindsym Mod1+0 move container to workspace number 2
bindsym Mod1+3 move container to workspace number 3
bindsym Mod1+7 move container to workspace number 4

# reload the configuration file
bindsym Mod1+z reload

# resize
bindsym Mod1+j resize grow width 10 px or 10 ppt
bindsym Mod1+l resize shrink width 10 px or 10 ppt
bindsym Mod1+u resize grow height 10 px or 10 ppt
bindsym Mod1+y resize shrink height 10 px or 10 ppt
