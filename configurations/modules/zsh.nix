{
  config,
  pkgs,
  ...
}: {
  # Enable Zsh.
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    histSize = 10000;
  };

  # Set Zsh as global default shell.
  users.defaultUserShell = pkgs.zsh;
}
