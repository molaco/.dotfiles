{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # helix.url = "github:SoraTenshi/helix/experimental-22.12";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server = { url = "github:msteen/nixos-vscode-server"; };

    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs =
    { self, nixpkgs, home-manager, vscode-server, rust-overlay, ... }@inputs:
    let

      inherit (self) outputs;

    in {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./configuration.nix

          ## vscode (change later)
          vscode-server.nixosModule
          ({ config, pkgs, ... }: {
            services.vscode-server.enable = true;
            services.vscode-server.nodejsPackage = pkgs.nodejs-18_x;
          })

          ## home-manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nixos = { imports = [ (import ./home.nix) ]; };
          }

          ## rust-nigthly
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ rust-overlay.overlays.default ];
            environment.systemPackages =
              [ pkgs.rust-bin.stable.latest.default ];
            # environment.systemPackages = [ pkgs.rust-bin.nightly."2023-07-12".default ];
          })

          # add things here
        ];
      };
    };
}
