{ inputs, config, lib, pkgs, ... }:
{
	programs.waybar.enable = true;
	# programs.waybar.enable = true;
	# programs.waybar.systemd.target = "hyprland-session.target";

	home.file = {
		".config/waybar/config" = {
			source = ./config;
		};
		".config/waybar/style.css" = {
			source = ./style.css;
		};
		".config/waybar/scripts" = {
			source = ./scripts;
		};
	};
}
