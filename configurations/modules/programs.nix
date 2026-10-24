{
  config,
  pkgs,
  ...
}: {
  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

  # Programs enable.
  programs.firefox.enable = true;
  programs.steam.enable = true;

  # System packages list.
  environment.systemPackages = with pkgs; [
    # Communication.
    discord

    # Media.
    obs-studio
    spotify
    vlc
    
    # Networking.
    proton-vpn

    # Terminal.
    btop
    fastfetch
    git
    micro
    tldr
    wget
    
    # Games.
    bottles
    gamescope
  ];
  
  # Flatpak
	services.flatpak.enable = true;
  
  # Flatpak packages list.
  services.flatpak.packages = [
  		"org.vinegarhq.Sober"
  		"org.jdownloader.JDownloader"
  ];

  # Auto removing not listed packages.
  services.flatpak.uninstallUnmanaged = true;
}
