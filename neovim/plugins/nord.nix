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

        local links = {
          ['@lsp.type.namespace'] = '@namespace',
          ['@lsp.type.type'] = '@type',
          ['@lsp.type.class'] = '@type',
          ['@lsp.type.enum'] = '@type',
          ['@lsp.type.interface'] = '@type',
          ['@lsp.type.struct'] = '@structure',
          ['@lsp.type.parameter'] = '@parameter',
          ['@lsp.type.variable'] = '@variable',
          ['@lsp.type.property'] = '@property',
          ['@lsp.type.enumMember'] = '@constant',
          ['@lsp.type.function'] = '@function',
          ['@lsp.type.method'] = '@method',
          ['@lsp.type.macro'] = '@macro',
          ['@lsp.type.decorator'] = '@function',
        }
        for newgroup, oldgroup in pairs(links) do
          vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
        end
      '';
  };
}
