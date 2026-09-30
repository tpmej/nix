{
  config,
  pkgs,
  ...
}: {
  # Enable Zsh
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    histSize = 10000;
  };

  # Set Zsh as default shell for user admin
  users.users.admin = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };
}
