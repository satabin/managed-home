{ isDesktop, lib, pkgs, ... }: lib.mkIf isDesktop {
  home.packages = with pkgs; [
    klavaro
    zotero
  ];
}
