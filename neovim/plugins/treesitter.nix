{ config, ... }:
let
  parsers_dir = "${config.xdg.dataHome}/treesitter/parsers";
in
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      ensureInstalled = [
        "hocon"
        "java"
        "json"
        "lua"
        "markdown"
        "markdown_inline"
        "nix"
        "ruby"
        "rust"
        "scala"
        "toml"
        "yaml"
      ];

      parserInstallDir = "${parsers_dir}";

      indent = true;

    };

    autoGroups = {
      hocon = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = [ "BufNewFile" "BufRead" ];
        pattern = [ "*/*.conf" ];
        group = "hocon";
        command = "set ft=hocon";
      }
    ];
  };
}
