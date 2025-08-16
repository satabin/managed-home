{ pkgs, config, ... }:
{
  home.stateVersion = "22.11";
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  home.packages = with pkgs; [
    nerd-fonts.sauce-code-pro
  ];

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ./secrets/tools.yaml;
  };

  home.sessionVariables = {
    LD_LIBRARY_PATH = "$LD_LIBRARY_PATH:${pkgs.stdenv.cc.cc.lib}/lib/";
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
