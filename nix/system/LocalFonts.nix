{ lib, stdenvNoCC, fetchurl }:
let 
  fs = lib.fileset;
in
stdenvNoCC.mkDerivation {
  pname = "LocalFonts";
  version = "1.0";

  src = fs.toSource {
    root = ./.;
    fileset = fs.fileFilter (file: lib.hasSuffix ".ttf" file.name) ./fonts;
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 ./fonts/*.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = with lib; {
    description = "Install Local Fonts";
    longDescription = ''
	  Installs Fonts in ./fonts folder
    '';
    license = licenses.ofl;
    maintainers = [ ];
    homepage = "";
  };
}


# { lib, fetchurl }:
# let
#   pname = "MesloNerdFonts";
#   version = "1.0";
# in fetchurl {
#   name = "${pname}-${version}";
#
#   url = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf";
#
#  #  postFetch = ''
# 	# tar xf $downloadedFile --strip=1
# 	# install -m444 -Dt $out/share/fonts/truetype fonts/ttf/*.ttf
#  #  '';
#
#   meta = with lib; {
# 	description = "Meslo NerdFonts";
# 	longDescription = "Install Meslo Nerdfonts";
# 	homepage = "TODO";
# 	license = licenses.ofl;
# 	platforms = platforms.all;
#   };
# }
#
#
