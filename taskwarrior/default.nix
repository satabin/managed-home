{ pkgs, config, ... }:
let
  confDir = config.xdg.configHome;
in
{
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;

    colorTheme = "${confDir}/task/nord";
  };

  xdg.configFile."task/nord.theme".source = ./nord.theme;

}
