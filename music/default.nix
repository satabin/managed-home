{ isDesktop, isWork, lib, pkgs, ... }: lib.mkIf (isDesktop && !isWork) {
  home.packages = with pkgs; [
    ardour
    calf
    gnome-podcasts
    helm
    lmms
    lsp-plugins
    noise-repellent
    tap-plugins
    wolf-shaper
  ];
}
