{ config, pkgs, ... }:
let
  parsers_dir = "${config.xdg.dataHome}/treesitter/parsers";
in
{
  programs.nixvim = {
    plugins.treesitter = {
      enable = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        hocon
        hurl
        java
        json
        lua
        markdown
        markdown_inline
        nix
        ruby
        rust
        scala
        toml
        yaml
      ];

      settings = {
        parser_install_dir = "${parsers_dir}";

        highlight.enable = true;
        indent.enable = true;
      };

    };

    filetype.pattern.".*/resources/.*%.conf" = "hocon";
  };
}
