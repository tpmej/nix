{
  config,
  pkgs,
  ...
}: {
  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  # Programs enable
  programs.firefox.enable = true;
  programs.steam.enable = true;
  services.flatpak.enable = true;

  # System packages list
  environment.systemPackages = with pkgs; [
    # Communication
    discord
    discordo

    # Media
    obs-studio
    spotify
    vlc

    # Programming
    alejandra
    gcc
    gdb
    gnumake
    go
    python3
    vscode
    nixfmt-rfc-style

    # Terminal
    btop
    fastfetch
    git
    micro
    tldr
  ];
}
