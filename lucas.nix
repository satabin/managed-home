{ pkgs, config, ... }:
{
  home.stateVersion = "22.11";
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ./secrets/tools.yaml;
  };


  _module.args = {
    isDesktop = true;
    isWork = false;
  };

  imports = [
    ./alacritty
    ./cli-tools
    ./dev-tools
    ./direnv
    ./educational
    ./fzf
    ./gaming
    ./gpg
    ./graphic
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
