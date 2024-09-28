{ config, ... }:
let
  parsers_dir = "${config.xdg.dataHome}/treesitter/parsers";
in
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      settings = {
        ensure_installed = [
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

        parser_install_dir = "${parsers_dir}";

        indent.enable = true;
      };

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
