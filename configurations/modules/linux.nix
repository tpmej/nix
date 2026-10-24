{
  config,
  pkgs,
  ... 
}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
    # Limit system bootloader configuration entries to 50, to avoid filling up the ESP partition.
  boot.loader.systemd-boot.configurationLimit = 50;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_zen;

	# Configure console keymap
  console.keyMap = "pl";
  
  # Enable graphics support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  # Virt.
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
	virtualisation.libvirtd.enable = true;
}
