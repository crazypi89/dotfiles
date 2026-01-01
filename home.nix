{ config, pkgs, unstable-pkgs, ... }:

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
    #
    
 ## cli
    helix
    inxi
    fastfetch
    #stacer????    


    ## gui
    vivaldi
    libreoffice-fresh
    onlyoffice-desktopeditors
    vscodium    

    gnome-tweaks

    


    #gnome extention
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
        #
    # Gimp avec plugins depuis la branche UNSTABLE
    unstable-pkgs.gimp-with-plugins

    
  ];



  # --- Tes réglages Dash to Dock récupérés ---
  dconf.settings = {
    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.06;
      custom-theme-shrink = true;
      dash-max-icon-size = 31;
      dock-position = "BOTTOM";
      height-fraction = 0.90;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      transparency-mode = "FIXED";
    };
  };

  

  # Gestion des fichiers de configuration (Dotfiles)
  home.file = {
    # Exemple : créer un fichier .bash_aliases
    # ".bash_aliases".text = "alias ll='ls -la'";
  };

  # Configuration de programmes spécifiques via HM
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake /home/crazypi/dotfiles#flakecrazypi";
    };
  };

  # Laisse Home Manager gérer lui-même
  programs.home-manager.enable = true;
}
