{
  description = "One flake to rule them all";

  nixConfig = {
    extra-substituters = [ "https://nix-community.cachix.org" ];
    extra-trusted-public-keys = [ "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };

  #############################
  ### External Dependencies ###
  #############################

  inputs = {
    
    #############
    ### Repos ###
    #############

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpks-25_05 = "github:NixOS/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";
    
    ###########################
    ### Manage User Configs ###
    ###########################
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    ##############
    ### Extras ###
    ##############
    
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    apollo = {
      url = "github:nil-andreas/apollo-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    eden = {
      url = "github:Grantimatter/eden-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
      
      #####################
      ### Laptop Config ###
      #####################

      "laptop" = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          
          #############
          ### Users ###
          #############

          {
            users.users.nf6 = {
              isNormalUser = true;
              extraGroups = [ "wheel" "docker" ];
              password = "";
            };
            nix.settings.trusted-users = [ "root" "nf6" ];
          }

          ################
          ### Packages ###
          ################

          ({pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              # General
              git emacs vim wget curl niri swww matugen kitty ranger tailscale
              mopidy rmpc syncthing calibre vesktop udiskie moonlight
              
              # Emacs deps
              pizauth msmtp isync cmake 
              (texlive.combine {
                inherit (texlive) scheme-small
                  collection.latexextra
                  collection.fontsrecommended
              })
            ];
          })
        ];
      };
      
      ######################
      ### Desktop Config ###
      ######################

      "desktop" = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          
          #############
          ### Users ###
          #############

          {
            users.users.nf6 = {
              isNormalUser = true;
              extraGroups = [ "wheel" "docker" ];
              password = "";
            };
            nix.settings.trusted-users = [ "root" "nf6" ];
          }

          ################
          ### Packages ###
          ################

          ({pkgs, ...}: {
            environment.systemPackages = with pkgs; [
              # General
              git emacs vim wget curl niri swww matugen kitty ranger tailscale
              mopidy rmpc syncthing calibre vesktop udiskie steam cemu 
              
              # Emacs deps
              pizauth msmtp isync cmake 
              (texlive.combine {
                inherit (texlive) scheme-small
                  collection.latexextra
                  collection.fontsrecommended
              })
            ];
          })
        ];
      };
    };
  };
}
