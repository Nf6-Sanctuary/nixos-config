{ config, pkgs, ... }:

{ 
  # Enable flakes and the acompanying new nix cli.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.systemPackages = with pkgs; [
    # Flakes clones its dependencies through the git command,
    # so git must be installed first.
    git
    vim
    vimPlugins.vim-nix
    vimPlugins.nerdtree
    vimPlugins.vim-airline
    wget
  ];

  # Set default editor to use vim.
  environment.variables.EDITOR = "vim";

  # Set user, groups, and password.
  users.users.nf6 = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # sudo access
    password = "";
  };
  
  # Set trust (for extra substituters & public keys to work properly)
  nix.settings.trusted-users = [ "root" "nf6" ];
}
