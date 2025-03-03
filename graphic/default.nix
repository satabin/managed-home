{isDesktop, isWork, lib, pkgs, ...}: lib.mkIf (isDesktop && !isWork) {
  home.packages = with pkgs; [
    (gimp-with-plugins.override {
      plugins = with gimpPlugins; [
        gap
        gmic
      ];
    })
    inkscape
    krita
    pixelorama
    qgis
    rx
  ];
}
