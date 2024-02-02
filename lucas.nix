{pkgs, ...}: {
  home.stateVersion = "22.11";
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["SourceCodePro"];})
  ];

  imports = [
    ./alacritty
    ./dev-tools
    ./educational
    ./fzf
    ./gaming
    ./gpg
    ./obs
    ./starship
    ./tmux
    ./zoxide
    ./zsh
    ./neovim
  ];
}
