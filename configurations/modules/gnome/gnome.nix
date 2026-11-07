{
  config,
  pkgs,
  lib,
  ...
}: {
  # Enable GNOME de.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  
  # Enable dconf.
  programs.dconf.enable = true;
  
  # GNOME de settings.
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.printing.enable = false;
  
  # Packages to exclude, aka "bloat list".
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour 
    gnome-user-docs 
  ];
  
# Gnome packages to install.
  environment.systemPackages = with pkgs; [
    baobab
    blanket
    collision
    dconf-editor
    dialect
    fragments
    gnome-boxes
    gnome-calculator
    gnome-calendar
    gnome-clocks
    gnome-connections
    gnome-console
    gnome-disk-utility
    gnome-logs
    gnome-text-editor
    keypunch
    nautilus
    resources
    snapshot
  ];
  
  # Dconf settings.
  programs.dconf.profiles.user.databases = [
    {
      settings = {
      		# Interface configuration.
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          accent-color = "yellow";
        };
        # Mouse acceleration profile set to flat.
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };
        # Gnome-text-editor settings.
        "org/gnome/text-editor" = {
          show-line-numbers = true;
          highlight-current-line = true;
          show-map = true;
          tab-width = lib.gvariant.mkInt32 2;
        };
      };
    }
  ];
}


