set $mod Mod1

default_border pixel 2
default_floating_border pixel 2

# target                 title        bg        text      indicator   border
client.focused           #cba6f7      #1e1e2e   #cdd6f4   #f5e0dc     #cba6f7
client.focused_inactive  #1e1e2e      #1e1e2e   #cdd6f4   #f5e0dc     #181825
client.unfocused         #1e1e2e      #1e1e2e   #cdd6f4   #f5e0dc     #181825
client.urgent            #fab387      #1e1e2e   #fab387   #6c7086     #fab387
client.placeholder       #1e1e2e      #1e1e2e   #cdd6f4   #1e1e2e     #181825
client.background        #1e1e2e

# audio keys
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && $refresh_i3status
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && $refresh_i3status
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

# launch programs
bindsym $mod+s exec wezterm-gui
bindsym $mod+r exec firefox
bindsym $mod+d exec --no-startup-id dmenu_run -fn 'JetBrainsMono Nerd Font' -nf "#cdd6f4" -nb "#181825" -sb "#11111b"

# kill focused window
bindsym $mod+t kill

# change focus
bindsym $mod+n focus left
bindsym $mod+e focus up
bindsym $mod+i focus down
bindsym $mod+o focus right

# move focused window
bindsym $mod+2 move left
bindsym $mod+4 move down
bindsym $mod+1 move up
bindsym $mod+8 move right

bindsym $mod+m fullscreen toggle
bindsym $mod+g floating toggle

set $ws1 "1"
set $ws2 "2"
set $ws3 "3"
set $ws4 "4"

# switch to workspace
bindsym $mod+w workspace number $ws1
bindsym $mod+f workspace number $ws2
bindsym $mod+p workspace number $ws3
bindsym $mod+b workspace number $ws4

# move focused container to workspace
bindsym $mod+5 move container to workspace number $ws1
bindsym $mod+0 move container to workspace number $ws2
bindsym $mod+3 move container to workspace number $ws3
bindsym $mod+7 move container to workspace number $ws4

# reload the configuration file
bindsym $mod+z reload

# resize
bindsym $mod+j resize grow width 10 px or 10 ppt
bindsym $mod+l resize shrink width 10 px or 10 ppt
bindsym $mod+u resize grow height 10 px or 10 ppt
bindsym $mod+y resize shrink height 10 px or 10 ppt
