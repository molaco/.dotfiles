{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    helix.url = "github:SoraTenshi/helix/experimental-22.12";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
		};

    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
    };
  };
  
  outputs = { 
    self,
    nixpkgs,
    home-manager,
    vscode-server,
    ... 
    } @ inputs: let

    inherit (self) outputs;

    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./configuration.nix

	        ## vscode (change later)
	        vscode-server.nixosModule
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
	          services.vscode-server.nodejsPackage = pkgs.nodejs-16_x;
            })
	  
	      home-manager.nixosModules.home-manager {
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.nixos = {
	        imports = [(import ./home.nix)];
	          };
	        }

          # add things here
        ];
      }; 
    };
}
