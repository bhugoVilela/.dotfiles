# hyprland config and all its plugins
# there's a good deal of refactoring here
# from path's to images
# wallpapers folder should be moved into .dotfiles and accessible from here
{ inputs, config, lib, pkgs, unstable, ... }:
{

    home.packages = [
        pkgs.hyprpicker
        pkgs.swaynotificationcenter
        unstable.hyprlock
    ];

  home.file.".config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  home.file.".config/hypr/setWallpaperScript".source = ./setWallpaperScript;

  # service-menu for Dolphin that allows wallpaper to be changed from the context menu
  home.file.".local/share/kio/servicemenus/setWallpaper.desktop".source = ./setWallpaperScript/setWallpaper.desktop;

  #import rose-pine-hyprcursor theme
  home.file.".local/share/icons" = {
      source = (pkgs.callPackage ./rose-pine-hyprcursor.nix {});
      recursive = true;
  };

  home.file.".config/hypr/hyprlock.conf".text = ''
  general{

    }
background {
    monitor =
    path=/home/bhugo/.config/hypr/wallpapers/51202150817_b06d5ddc31_o.png
    # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
    blur_passes = 0 disables blurring
    blur_size = 2 
    new_optimizations = true
    ignore_opacity = false
}

input-field {
    monitor =
    size = 190, 30
    outline_thickness = 2
    dots_size = 0.33 # Scale of input-field height, 0.2 - 0.8
    dots_spacing = 0.15 # Scale of dots' absolute size, 0.0 - 1.0
    dots_center = true
    outer_color = rgba(40,40,40,0.0)
    inner_color = rgba(200, 200, 200, 0.8)
    font_color = rgba(10, 10, 10, 0.8)
    fade_on_empty = false
    placeholder_text = Enter Password # Text rendered in the input box when it's empty.
    hide_input = false

    position = 0, 100
    halign = center
    valign = bottom
}

label {
    monitor =
    text = cmd[update:1000] echo "<span>$(date '+%A, %d %B')</span>"
    # text = cmd[update:1000] echo "<span foreground='##eeeeee'>$(date '+%A, %d %B')</span>"
    color = rgba(250, 250, 250, 0.8)
    font_size = 12
    font_family = Inter Display

    position = 0, -100
    halign = center
    valign = top
}

label {
    monitor =
    text = cmd[update:1000] echo "<span>$(date '+%H:%M')</span>"
    color = rgba(250, 250, 250, 0.8)
    font_size = 75
    font_family = Inter Display Bold

    position = 0, -100
    halign = center
    valign = top
}

label {
    monitor =
    text =    $USER
    color = rgba(200, 200, 200, 1.0)
    font_size = 18
    font_family = Inter Display Medium

    position = 0, 150
    halign = center
    valign = bottom
}
  '';

  # hyprpicker desktop entry
  # allows it to appear in rofi
  xdg.desktopEntries.hyprpicker = {
    type="Application";
    name="Color Picker";
    exec="hyprpicker -a";
    icon=./hyprpicker_icon.png;
  };

  wayland.windowManager.hyprland = {
        # enable = true;
	settings = {};
	extraConfig = ''
      ########################################################################################
      # AUTOGENERATED HYPR CONFIG.
      # PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hypr.conf AND EDIT IT,
      # OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
      ########################################################################################
	  env = QT_QPA_PLATFORM,wayland
            env = QT_QPA_PLATFORMTHEME,qt5ct

        # set hyprcursor theme
        env = HYPRCURSOR_THEME,rose-pine-hyprcursor
      
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,preferred,auto,auto

      windowrule=opacity 0.5 0.5,class:(dolphin)
      
      #TODO install
      #rofi
      #hyprpicker
      #hyprpaper
      #hypridle - idle management daemon
      #hyprlock - lockscreen
      #hyprcursor - more efficient alternative to xcursor
      
      # enable clipboard
      exec-once = wl-paste --type text --watch cliphist store #Stores only text data
      exec-once = wl-paste --type image --watch cliphist store #Stores only image data
      
      # Autostart favorite apps
      #exec-once=[workspeace 1 silent] kitty
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      
      # Execute your favorite apps at launch
      exec-once = ln -s $XDG_RUNTIME_DIR/hypr /tmp/hypr
      exec-once = hyprpaper & exec swaync
      exec-once = waybar
      # & firefox
      
      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf
      
      # Some default env vars.
      env = XCURSOR_SIZE,24
      
      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us,pt
          kb_variant =
          kb_model = 
          kb_options = grp:alt_space_toggle
          kb_rules =
      
          follow_mouse = 1
      
          touchpad {
              natural_scroll = no
          }
      
          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }
      
      general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
      
          gaps_in = 3
          gaps_out = 20
          border_size = 2
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
      
          layout = dwindle
      
          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false
      }

	  # TODO do this to blur waybar
	  # layerrule = blur,waybar
	  layerrule = blur,rofi
	  layerrule = ignorezero,rofi
      
      decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
      
          rounding = 10
          
          blur {
              enabled = true
              size = 10
              passes = 3
			  ignore_opacity = true;
			  xray = false;
          }
      
          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }
      
      animations {
          enabled = yes
      
          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
      
          bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      
          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
      }
      
      dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
      }
      
      master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_is_master = true
      }
      
      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }
      
      misc {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          force_default_wallpaper = 0 # Set to 0 to disable the anime mascot wallpapers
      }
      
      # Example per-device config
      # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
      # device:epic-mouse-v1 {
      #     sensitivity = -0.5
      # }
      
      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      windowrule = float, ^(pavucontrol)$
      windowrule = size 636 787,^(pavucontrol)$

      windowrule = float, ^(Bitwarden)$
      windowrule = size 63j 787,^(Bitwarden)$
      
      
      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER
	  bind = $mainMod, Z, exec, ~/.local/share/rofi/powermenu/powermenu.sh
      bind = $mainMod, SPACE, exec, rofi -i -show drun -modi drun -show-icons
      bind = $mainMod, RETURN, exec, kitty
      bind = $mainMod, Q, killactive, 
      bind = $mainMod, M, exit, 
      bind = $mainMod, E, exec, dolphin

	  #makes floating and centers
      bind = $mainMod, F, togglefloating, 
      bind = $mainMod, F, centerwindow, 

      bind = $mainMod, P, pseudo, # dwindle
      bind = $mainMod SHIFT, D, togglesplit, # dwindle

	  bind = $mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      
      # Move focus with mainMod + arrow keys
      bind = $mainMod, h, movefocus, l
      bind = $mainMod, l, movefocus, r
      bind = $mainMod, k, movefocus, u
      bind = $mainMod, j, movefocus, d

      bind = $mainMod SHIFT, h, swapwindow, l
      bind = $mainMod SHIFT, l, swapwindow, r
      bind = $mainMod SHIFT, k, swapwindow, u
      bind = $mainMod SHIFT, j, swapwindow, d
      
      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      
      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10
      
      # Example special workspace (scratchpad)
      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic
      
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1
      
      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

	bind=$mainMod,R,submap,resize

	# will start a submap called "resize"
	submap=resize

	# sets repeatable binds for resizing the active window
	binde=,l,resizeactive,25 0
	binde=,h,resizeactive,-25 0
	binde=,k,resizeactive,0 -25
	binde=,j,resizeactive,0 25

	# use reset to go back to the global submap
	bind=,escape,submap,reset 

	# will reset the submap, which will return to the global submap
	submap=reset

	bindel=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
	bindel=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
	bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindl=, xF86AudioPlay, exec, wpctl

        bindl=, XF86AudioPlay, exec, playerctl play-pause
        bindl=, XF86AudioNext, exec, playerctl next 
        bindl=, XF86AudioPrev, exec, playerctl previous
	'';
  };
}
