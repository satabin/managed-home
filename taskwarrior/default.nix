{ pkgs, config, ... }:
let
  confDir = config.xdg.configHome;
in
{
  sops = {
    secrets."tasks/sync" = {};
  };

  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;

    colorTheme = "${confDir}/task/nord";

    extraConfig = "include ${config.sops.secrets."tasks/sync".path}";
  };

  xdg.configFile."task/nord.theme".source = ./nord.theme;

}
