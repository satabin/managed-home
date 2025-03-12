{ isDesktop, isWork, lib, pkgs, ... }: lib.mkIf (isDesktop && !isWork) {
  home.packages = with pkgs; [
    dosbox
    luanti
    openttd
  ];
}
