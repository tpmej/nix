{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ./modules/boot.nix
    ./modules/de.nix
    ./modules/locale.nix
    ./modules/programs.nix
    ./modules/shell.nix
    ./modules/sound.nix
    ./modules/tor.nix
    ./modules/users.nix
  ];

  # Hostname
  networking.hostName = "FA617NSR";

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable graphics support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # System version
  system.stateVersion = "26.05";
}
