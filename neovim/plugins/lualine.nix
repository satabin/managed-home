{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lualine-nvim
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        require('lualine').setup {
          ...,
          options = {
            icons_enabled = true,
            theme = 'nord',
          },
          tabline = {
            lualine_a = { 'buffers' },
          },
        }
      '';
  };
}
