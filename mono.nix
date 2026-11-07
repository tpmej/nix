{config, pkgs, inputs, lib, ...}: 

{
  # ================================================================
  # 01. BOOT, KERNEL & SYSTEM CORE
  # ================================================================
  # Boot.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true; 
  boot.loader.systemd-boot.configurationLimit = 50; # This limit is very high. Consider lowering, however unnecessary.
  boot.loader.timeout = 0; # Hold [SPACE] when booting to boot the generation menu.
  
  # Kernel zen & parameters.
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.kernelModules = [ "amdgpu" ]; # AMD driver load on boot.
  boot.kernelModules = [ "kvm-amd" ];
  
  virtualisation.libvirtd.enable = true;
  
  # System version.
  system.stateVersion = "26.05"; # Leave it alone man.
  
  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # ================================================================
  # 02. HARDWARE, AUDIO & GRAPHICS
  # ================================================================
	# Enable graphics support & 32bit libraries
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    # AMD drivers 4 acceleration.
    extraPackages = with pkgs; [
      rocmPackages.clr
    ];
  };
  
  # CPU microcode updates for AMD CPUs
  hardware.cpu.amd.updateMicrocode = true; # Js replace 'amd' w/ 'intel' if you've got Intel CPU.
  
  # Bluetooth support.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  
  # Audio w/ Pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  
  # ================================================================
  # 03. NETWORKING, LOCALE & TIMEZONE
  # ================================================================
  # Enable networking & set hostname.
  networking.networkmanager.enable = true;
  networking.hostName = "nixos";
  
  # Timezone.
  time.timeZone = "Europe/Warsaw";
  
  # Irelandic locale w/ polish keyboard layout.
  i18n.defaultLocale = "en_IE.UTF-8";
  i18n.supportedLocales = [
    "en_IE.UTF-8/UTF-8"
  ];
  # Polish keyboard.
  console.keyMap = "pl2";
  services.xserver.xkb.layout = "pl";
  
  # ================================================================
  # 04. USERS & SHELL
  # ================================================================
  # Admin user.
  users.users."admin" = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ 
      "networkmanager"
      "wheel"
      "audio"
      "video"
      "input"
      "storage"
      "kvm"
      "libvirtd"
    ];
  };
  
  # Enable ZSH shell.
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    histSize = 10000;
  };
  # Set Zsh as global default shell.
  users.defaultUserShell = pkgs.zsh;
  
  # ================================================================
  # 05. GNOME MONOLITH
  # ================================================================
  # Enable GNOME desktop enviorment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  # Everything below this line is customisation.
  # Enable dconf.
  programs.dconf.enable = true;
  
  # GNOME de settings.
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  services.printing.enable = false;
  
  # Packages to exclude, aka 'bloat list'.
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour 
    gnome-user-docs 
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
        # Mouse acceleration profile set 2 flat.
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
  
  # ================================================================
  # 06. PACKAGES.
  # ================================================================
  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

  # Programs enable.
  programs.firefox.enable = true;
  programs.steam.enable = true;

  # System packages list.
  environment.systemPackages = with pkgs; [
  		# GNOME packages.
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
  
  		# System packages list.
  		# Coding.
  		code-cursor
  
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
    wget
    
    # Games.
    bottles
    gamescope
    
    # Update script:
	(writeShellScriptBin "update" ''
  #!/usr/bin/env bash
  set -euo pipefail
  flatpak update -y
  cd /etc/nixos
  nix flake update
  sudo git add -A
  sudo git diff --cached --quiet || sudo git commit -m "update"
  sudo nixos-rebuild switch --flake .#nixos
	'')
  ];
  
  # Flatpak packages list. 
	services.flatpak.enable = true;
  services.flatpak.packages = [
  		"org.vinegarhq.Sober"
  		"org.jdownloader.JDownloader"
  ];

  # Auto removing !listed Flatpak packages.
  services.flatpak.uninstallUnmanaged = true;
}
