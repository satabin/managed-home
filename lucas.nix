{ pkgs, ... }: {
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

  imports = [
    ./alacritty
    ./dev-tools
    ./educational
    ./fzf
    ./gaming
    ./obs
    ./starship
    ./tmux
    ./zoxide
    ./zsh
    ./neovim
  ];

}
