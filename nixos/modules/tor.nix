{
  config,
  pkgs,
  ...
}: {
  # Tor service
  services.tor = {
    enable = true;
    settings = {
      ControlPort = 9051;
      ExitNodes = "{ch}";
      StrictNodes = true;
    };
  };

  # Tor packets
  environment.systemPackages = with pkgs; [
    tor-browser
  ];
}
