{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda"; # Vérifie avec lsblk si c'est /dev/sda ou /dev/vda
}