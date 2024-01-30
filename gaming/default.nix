{ pkgs, ... }: {

  home.packages = with pkgs; [
    dosbox
    minetest
    openttd
  ];

}
