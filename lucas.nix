{ pkgs, config, ... }:
let
  nixvim = import (builtins.fetchGit {
    url = "https://github.com/nix-community/nixvim";
    ref = "nixos-24.05";
  });
in
{
  home.stateVersion = "22.11";
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  home.sessionVariables = {
    LC_ALL = "en_US.UTF-8";
  };

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ./secrets/tools.yaml;
  };

  imports = [
    nixvim.homeManagerModules.nixvim
    ./alacritty
    ./cli-tools
    ./dev-tools
    ./direnv
    ./educational
    ./fzf
    ./gaming
    ./gpg
    ./music
    ./obs
    ./starship
    ./tmux
    ./zoxide
    ./zsh
    ./neovim
    ./taskwarrior
  ];
}
