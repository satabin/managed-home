{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
    ];
    extraLuaConfig =
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
