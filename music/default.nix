{pkgs, ...}: {
  home.packages = with pkgs; [
    ardour
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
