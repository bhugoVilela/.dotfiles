{ pkgs, lib, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  # allow spotify to be installed if you don't have unfree enabled already
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "spotify"
  ];

  # import the flake's module for your system
  imports = [ spicetify-nix.homeManagerModule ];

  # configure spicetify :)
  programs.spicetify =
    {
      enable = true;

      # theme = spicePkgs.themes.Dribbblish;
      # theme = rec {
      #     name = "Hazy";
      #     src = ./spicetify/Themes;
      #     requiredExtensions = [
      #         { 
      #             filename = "hazy.js"; 
      #             src = "${src}/Hazy";
      #         }
      #     ];
      #     appendName = true;
      #     injectCss       = true;
      #     replaceColors   = true;
      #     overwriteAssets = true;
      #     sidebarConfig   = true;
      # };

      theme = rec {
          name = "SpotifySpice";
          src = ./spicetify/Themes;
          requiredExtensions = [
              { 
                  filename = "spotifySpice.js"; 
                  src = "${src}/SpotifySpice";
              }
          ];
          appendName = true;
          injectCss       = true;
          replaceColors   = true;
          overwriteAssets = true;
          sidebarConfig   = true;
      };

      # colorScheme = "base";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle # shuffle+ (special characters are sanitized out of ext names)
        hidePodcasts
      ];
    };
}
