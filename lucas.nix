{ pkgs, ... }: {
  imports = [
    ./dev-tools
    ./alacritty
    ./fzf
    ./obs
    ./starship
    ./tmux
    ./zoxide
    ./zsh
    ./neovim
  ];
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    dosbox
    klavaro
    minetest
    openttd
    (nerdfonts.override { fonts = [ "SourceCodePro" ]; })
  ];

}
