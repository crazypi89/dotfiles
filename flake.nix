{
  description = "Ma configuration NixOS Flake";

  inputs = {
    # Entrée 1 : NixOS Stable (version 25.11)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Entrée 2 : NixOS Unstable (pour les paquets très récents)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Ajout de Home-Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
    
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "x86_64-linux"; # À adapter si vous êtes sur ARM (aarch64-linux)
      
      # Configuration des paquets pour les deux branches
      pkgs = nixpkgs.legacyPackages.${system};
      unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      # Définition de votre configuration système
      nixosConfigurations.flakecrazypi = nixpkgs.lib.nixosSystem {
        inherit system;
        
        # Transmettre les entrées (inputs) aux modules pour pouvoir utiliser 'unstable'
        specialArgs = { inherit inputs unstable-pkgs; };
        
        modules = [
          # On pointe vers votre fichier de configuration habituel
          ./configuration.nix

          # Intégration de Home-Manager comme module NixOS
           home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # C'EST ICI : On transmet unstable-pkgs à home.nix
            home-manager.extraSpecialArgs = { inherit unstable-pkgs; };
            home-manager.users.crazypi = import ./home.nix; # On va créer ce fichier
          } 

          
        ];
      };
    };
}
