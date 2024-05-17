{ inputs, config, lib, pkgs, ... }:
{
  programs.kitty.enable = true;
  programs.kitty.font.name = "MesloLGL Nerd Font Mono";
  programs.kitty.settings.background_opacity = "0.5";
}
