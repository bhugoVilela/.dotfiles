{
  description = "NIXOS config flake";

  inputs = {
    unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    nixpkgs.url = "nixpkgs/nixos-23.11";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    spicetify-nix.url = "github:the-argus/spicetify-nix";

    home-manager = {
       url = "github:nix-community/home-manager/release-23.11";
       inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {self, nixpkgs, home-manager, hyprland, unstable, spicetify-nix, ...} @ inputs: 
  let
	system = "x86_64-linux";
	lib = nixpkgs.lib;
	pkgs = nixpkgs.legacyPackages.${system};
	unstablepkgs = unstable.legacyPackages.${system};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
	  inherit system;
      modules = [
		./configuration.nix
      ];
    };
	homeConfigurations = {
	  bhugo = home-manager.lib.homeManagerConfiguration {
		inherit pkgs;
		modules = [ 
		  ./home.nix 
		  hyprland.homeManagerModules.default
		  { wayland.windowManager.hyprland.enable = true; }
		];
		extraSpecialArgs = {
		  inherit inputs;
		  unstable = inputs.unstable.legacyPackages.${system};
		  inherit spicetify-nix;
		};
	  };
	};
  };

}

