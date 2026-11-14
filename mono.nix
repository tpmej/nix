{config, pkgs, inputs, lib, ...}: 

{
  # Enable flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];  
  # Allow unfree.
  nixpkgs.config.allowUnfree = true;

# Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 50; # This limit is very high. Consider lowering, however unnecessary.
    };
    efi.canTouchEfiVariables = true;
    timeout = 0; # Hold [SPACE] when booting to boot the generation menu.
  };
  
  # Kernel.	   
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernelModules = [ "kvm-amd" ]; # Replace 'amd' w/ 'intel' if you've got Intel CPU.
  };
  
  # Hardware.
  hardware = {
  		cpu.amd.updateMicrocode = true; # Replace 'amd' w/ 'intel' if you've got Intel CPU.
  		graphics = {
    		enable = true;
    		enable32Bit = true;
    		extraPackages = with pkgs; [
      		rocmPackages.clr
    		];
  		};
  	};
  
  # Networking.
  networking = {
  		networkmanager.enable = true;
 		hostName = "nixos"; # Hostname.
  };
  
  # Audio.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
  
  # Virtualisation.
  virtualisation.libvirtd.enable = true;
  
  # Bluetooth.
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };
  
  # Timezone.
  time.timeZone = "Europe/Warsaw";
  
  # Locale.
  i18n = {
  		defaultLocale = "en_IE.UTF-8";
  		supportedLocales = [
    		"en_IE.UTF-8/UTF-8"
  		];
  	};
  
  # Keyboard layout.
  console.keyMap = "pl2";
  services.xserver.xkb.layout = "pl";
  
  # User.
  users.users."admin" = {
    isNormalUser = true;
    description = "Admin";
    shell = pkgs.zsh;
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
  
  # Zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    histSize = 10000;
  };
  
  # GNOME DE.
  services= { 
  		displayManager.gdm.enable = true;
  		desktopManager.gnome.enable = true;	
  		printing.enable = false;
  		gnome = {
  			core-apps.enable = false;
  			core-developer-tools.enable = false;
  			games.enable = false;
  		};
  	};
  	
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour 
    gnome-user-docs 
  ];
  
	# Dconf.
  programs.dconf = {
  enable = true;
		profiles.user.databases = [
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
		      # Wallpaper.
		      "org/gnome/desktop/background" = {
		        picture-uri = "file://${./wallpaper.jpg}";
		        picture-uri-dark = "file://${./wallpaper.jpg}";
		      };
		    };
		  }
		];
	};

  # Programs enable.
  programs = {
  		firefox.enable = true;
  		steam.enable = true;
  	};

  # Packages.
  environment.systemPackages = with pkgs; [
  		# GNOME packages list:
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
  
  		# System packages list:
  		# Coding.
  		vscode
  		go
  
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
    php
    sqlite
    tldr
    tree
    wget
    
    # Games.
    (bottles.override { removeWarningPopup = true; })
    gamescope
    
		# Update script:
    (writeShellScriptBin "update" ''
    #!/usr/bin/env bash
    set -euo pipefail
        
    flatpak update -y
        
    cd /etc/nixos
        
    # Flake update i git jako root, ale z zachowaniem sensu
    sudo nix flake update
        
    # Używamy zwykłego gita bez sudo, albo dbamy o ownera
    sudo git add -A
    sudo git diff --cached --quiet || sudo git commit -m "update"
        
    sudo nixos-rebuild switch --flake .#nixos
    '')
    ];
  
  # Flatpak. 
	services.flatpak = {
		enable = true;
		uninstallUnmanaged = true;
		packages = [
				"org.vinegarhq.Sober"
				"org.jdownloader.JDownloader"
		];
	};

  # System state version.
  system.stateVersion = "26.05";
}
