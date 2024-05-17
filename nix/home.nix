{ config, pkgs, ... }:
{

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  imports = [
	./user/rofi.nix
	./user/hyprland.nix
	./user/waybar/waybar.nix
	./user/kitty.nix
	./user/spicetify.nix
  ];

  home.username = "bhugo";
  home.homeDirectory = "/home/bhugo";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.btop = {
    enable = true;
    settings = {
      vimKeys = true;
    };
  };

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable  = true;
    userName = "Hugo Vilela";
    userEmail = "41992011+bhugoVilela@users.noreply.github.com";
    aliases = {
      co      = "checkout";
      br      = "branch";
      ci      = "commit";
      com     = "commit";
      st      = "status";
      ls      = "status";
      unstage = "reset HEAD --";
      last    = "log -1 HEAD";
    };
  };

  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    hello
    nodejs_18
    jq
    teams-for-linux
    bitwarden
    nomachine-client
    gnome.gnome-calendar

    # file de/compress KDE app
    ark

    neofetch

    
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zoxide = {
	  enable = true;
	  enableZshIntegration = true;
  };

  programs.zsh = {
	enable = true;
	shellAliases = {
	  ll   = "ls -l";
	  ".." = "cd ..";
	  "Oil" = "nvim -c Oil";
	  "oil" = "nvim -c Oil";
	};

  };

  gtk = {
	  enable = true;
  };

  programs.bash = {
	enable = true;
	shellAliases = {
	  ll   = "ls -l";
	  ".." = "cd ..";
	};

  };

    home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.gnome.adwaita-icon-theme;
	name = "Adwaita";
	size = 16;
    };

}
