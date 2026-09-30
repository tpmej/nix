{
  config,
  pkgs,
  ... 
}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Limit system bootloader configuration entries to 50, to avoid filling up the ESP partition.
  boot.loader.systemd-boot.configurationLimit = 50;
}
