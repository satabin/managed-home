{ isDesktop, isWork, lib, pkgs, ... }: lib.mkIf (isDesktop && !isWork) {
  home.packages = with pkgs; [
    ardour
    calf
    helm
    lmms
    lsp-plugins
    mixxx
    musescore
    noise-repellent
    sonic-pi
    tap-plugins
    wolf-shaper
  ];
}
