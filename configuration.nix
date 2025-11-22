{ config, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
  ];
  # Enable flakes and the acompanying new nix cli.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.access-tokens = "";

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
  nix.settings.trusted-users = [ "nf6" ];

  # VM resource configuration
  virtualisation.memorySize = 8192;   # 8 GB RAM
  virtualisation.diskSize   = 102400;  # 100 GB disk (sizes are in MB)
}
