{ pkgs, ... }: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];
    extraConfigLua =
      /*
      lua
      */
      ''
        require('nvim-web-devicons').setup {
          color_icons = false;
        }
      '';
  };
}
