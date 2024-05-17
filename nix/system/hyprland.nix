{inputs, pkgs, ...}: {

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
	xwayland.enable = true;
  };

  # Prompt Electron apps to use wayland
  environment.sessionVariables.NIXOS_DZONE_WL = "1";

  # Disable hardware mouse 
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

  environment.systemPackages = with pkgs; [
    hyprpaper
    rofi-wayland
    gnome-icon-theme

	# clipboard
	wl-clipboard
	cliphist
  ];
}

