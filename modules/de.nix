{
  config,
  pkgs,
  ...
}: {
  # Enable Gnome Desktop Environment
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Bloat list
  environment.gnome.excludePackages = [
    pkgs.gnome-tour
  ];
}
