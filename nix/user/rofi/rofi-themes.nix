{ pkgs }:
let 
	instalationPath = "~/.local/share/rofi/themes";
in
pkgs.stdenv.mkDerivation rec {
	name = "rofi-themes-collection";

	src = pkgs.fetchgit {
		url = "https://github.com/lr-tech/rofi-themes-collection.git";
		# owner = "lr-tech";
		# repo = "rofi-themes-collection";
		rev = "f87e08300cb1c984994efcaf7d8ae26f705226fd";
		sha256 = "A6zIAQvjfe/XB5GZefs4TWgD+eGICQP2Abz/sQynJPo=";
	};

	# TODO copy all files to ~/.local/share/rofi/themes
	installPhase = ''
		ls -la
		cp -r $src/themes $out
		ls -la
	'';
}
