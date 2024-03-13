{pkgs, ...}: {
  home.stateVersion = "22.11";
  home.username = "lucas";
  home.homeDirectory = "/home/lucas";

  home.packages = with pkgs; [
    (nerdfonts.override {fonts = ["SourceCodePro"];})
  ];

  home.sessionVariables = {
    LC_ALL = "en_US.UTF-8";
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
    ./music
    ./obs
    ./starship
    ./tmux
    ./zoxide
    ./zsh
    ./neovim
  ];
}
