# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, unstable, ... }:

let 
  localFonts = import ./system/LocalFonts.nix {
	inherit (pkgs) lib stdenvNoCC fetchurl;
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./system/hyprland.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot = {
  	loader.grub.enable = true;
  	loader.grub.device = "/dev/sdb";
  	loader.grub.useOSProber = true;
	loader.grub.enableCryptodisk=true;
	loader.grub.configurationLimit = 10;
	loader.timeout = 5;
	initrd.luks.devices."luks-4df7e6aa-6e70-40aa-a3ce-d11fae68063d".device = "/dev/disk/by-uuid/4df7e6aa-6e70-40aa-a3ce-d11fae68063d";
	# Setup keyfile
	initrd.secrets = {
	  "/crypto_keyfile.bin" = null;
	};
	initrd.luks.devices."luks-bcb58a6b-2a13-4024-b796-5485b474f9a1".keyFile = "/crypto_keyfile.bin";
	initrd.luks.devices."luks-4df7e6aa-6e70-40aa-a3ce-d11fae68063d".keyFile = "/crypto_keyfile.bin";
	initrd.kernelModules = [ "nvidia" ];
	# extraModulesPackages = [ config.boot.kernelPackages.nvidia_x11 ];

	kernelPackages = pkgs.linuxPackages_latest;
  };

  xdg = {
	# autostart.enable = true;
	portal = {
	  enable = true;
	  extraPortals = [
		# pkgs.xdg-desktop-portal
		pkgs.xdg-desktop-portal-gtk
	  ];
	};

  };

  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa = {
	enable = true;
	support32Bit = true;
      };
      jack.enable = true;

      wireplumber.enable = true;
    };
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware.opengl = {
	enable = true;
	driSupport = true;
	driSupport32Bit = true;
  };

   hardware.nvidia = {
	 modesetting.enable = true;
	# open source drivers are broken, so we use the proprietary
	 # open = true;
	 nvidiaSettings = true;
	 package = config.boot.kernelPackages.nvidiaPackages.stable;
   };

  services.xserver.videoDrivers = ["nvidia"];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
	localFonts
	noto-fonts
	noto-fonts-cjk
	noto-fonts-emoji
	(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bhugo = {
    isNormalUser = true;
    description = "Hugo Vilela";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "networkmanager" "lp" "scanner" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	# libva-utils
	# gnome.adwaita-icon-theme
	# gnome.gnome-themes-extra
	# xdg-desktop-portal-hyprland
	# xdg-utils
	# xdg-desktop-portal
	# xdg-desktop-portal-gtk
	breeze-icons
	libsForQt5.qt5ct
	libsForQt5.qtstyleplugin-kvantum
	qt5.qtwayland
	qt5.qmake
	qt6.qtwayland
	qt6.qmake
	adwaita-qt
	adwaita-qt6
	fluent-gtk-theme
	whitesur-gtk-theme
	whitesur-icon-theme

	# file-manager
	dolphin
	# file-manager plugins
	ffmpegthumbs
	libsForQt5.kio-extras

	pavucontrol
	playerctl


    neovim
    google-chrome
    feh
    gcc
    ripgrep
  ];

  environment.shells = with pkgs; [ zsh bash ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  environment.sessionVariables = {
	  SUDO_EDITOR = "nvim";
	  # XDG_SESSION_TYPE = "wayland";
	  # LIBVA_DRIVER_NAME = "nvidia";
	  # WLR_RENDERER = "vulkan";
	  # XDG_CURRENT_DESKTOP = "Hyprland";
	  # XDG_SESSION_DESKTOP = "Hyprland";
	  # GTK_USE_PORTAL = "1";
	  # NIXOS_XDG_OPEN_USE_PORTAL = "1";
	  # GTK_THEME = "libadwaita"

  };

  environment.variables = {
	  QT_QPA_PLATFORMTHEME = "qt5ct";
	  QT_QPA_PLATFORM = "wayland";
  };

 #  nixpkgs.config.qt5 = {
	#   enable = true;
	#   platformTheme = "qt5ct"; 
	# 	# style = {
	# 	#   package = pkgs.utterly-nord-plasma;
	# 	#   name = "Utterly Nord Plasma";
	# 	# };
	# };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
