{ pkgs, ... }: {
  imports = [
    ./alacritty
    ./fzf
    ./neovim
    ./obs
    ./starship
    ./tmux
    ./zoxide
    ./zsh
  ];
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    dosbox
    klavaro
    minetest
    openttd
    nerdfonts
  ];

  programs.git = {
    enable = true;
    userName = "Lucas Satabin";
    userEmail = "lucas.satabin@gnieh.org";
  };

}
