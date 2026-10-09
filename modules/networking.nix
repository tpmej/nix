{
  config,
  pkgs,
  ... 
}: {
	# Networking hostname.
  networking.hostName = "I_use_nixos_btw";
  
  # Enable networking
  networking.networkmanager.enable = true;
}
