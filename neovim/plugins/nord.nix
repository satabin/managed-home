{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nord-nvim
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        vim.g.nord_italic = true
        vim.g.nord_uniform_diff_background = true
        vim.g.nord_borders = true

        require('nord').set()
      '';
  };
}
