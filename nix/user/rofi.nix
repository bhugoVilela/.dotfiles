{ inputs, config, lib, pkgs, ... }:
{
	# installs a list of rofi themes
	home.file.".local/share/rofi/themes" = {
		source = pkgs.callPackage ./rofi/rofi-themes.nix { };
		recursive = true;
	};
	# installs my theme
	home.file.".local/share/rofi/themes/bhugo.rasi".source = ./rofi/bhugo.rasi;

	# ooops paths are hardcoded
	home.file.".config/rofi/config.rasi".text = ''
	@theme "/home/bhugo/.local/share/rofi/themes/bhugo.rasi"

	configuration {
		kb-mode-complete: "";
		kb-row-up: "Up,Control+k,Shift+Tab,Shift+ISO_Left_Tab";
		kb-row-down: "Down,Control+j";
		kb-accept-entry: "Control+l,Return,KP_Enter";
		terminal: "mate-terminal";
		kb-remove-to-eol: "Control+Shift+e";
		kb-mode-previous: "Shift+Left,Control+Shift+Tab,Control+h";
		kb-remove-char-back: "BackSpace";
	}
	'';

	# install powermenu
	home.file.".local/share/rofi/powermenu" = {
		source = ./rofi/powermenu;
		recursive = true;
	};
}
