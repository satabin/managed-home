{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    bottom
    xh
    tig
    ripgrep
  ];
}
