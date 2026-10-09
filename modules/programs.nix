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
  services.flatpak.enable = true;

  # System packages list.
  environment.systemPackages = with pkgs; [
    # Communication.
    discord

    # Media.
    obs-studio
    spotify
    vlc

    # Terminal.
    btop
    fastfetch
    git
    micro
    tldr
  ];
}
