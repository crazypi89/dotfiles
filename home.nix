{ config, pkgs, ... }:

{
  # Informations sur l'utilisateur et le répertoire personnel
  home.username = "crazypi";
  home.homeDirectory = "/home/crazypi";

  # État de la version de Home Manager (à ne pas changer après l'installation)
  home.stateVersion = "25.11"; 

  # Paquets spécifiques à l'utilisateur (déplace-les ici depuis configuration.nix)
  home.packages = with pkgs; [
    firefox
    htop
    # Ajoute tes logiciels ici
  ];

  # Gestion des fichiers de configuration (Dotfiles)
  home.file = {
    # Exemple : créer un fichier .bash_aliases
    # ".bash_aliases".text = "alias ll='ls -la'";
  };

  # Configuration de programmes spécifiques via HM
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch --flake ~/dotfiles#flakecrazypi";
    };
  };

  # Laisse Home Manager gérer lui-même
  programs.home-manager.enable = true;
}
