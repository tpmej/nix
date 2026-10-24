{
  config,
  pkgs,
  ...
}: {
  # Admin user
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
}
