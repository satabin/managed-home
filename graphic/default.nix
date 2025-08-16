{isDesktop, isWork, lib, pkgs, ...}: lib.mkIf (isDesktop && !isWork) {
  home.packages = with pkgs; [
    ffmpeg
    (gimp-with-plugins.override {
      plugins = with gimpPlugins; [
        gap
        gmic
      ];
    })
    inkscape
    kdePackages.kdenlive
    krita
    libreoffice
    pixelorama
    qgis
    rx
  ];
}
