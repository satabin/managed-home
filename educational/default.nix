{pkgs, ...}: {
  home.packages = with pkgs; [
    klavaro
    zotero
  ];
}
