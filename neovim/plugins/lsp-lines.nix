{pkgs, ...}: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lsp_lines-nvim
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        require("lsp_lines").setup()
      '';
  };
}
