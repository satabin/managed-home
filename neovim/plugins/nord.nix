{
  programs.nixvim = {
    colorschemes.nord = {
      enable = true;
      settings = {
        italic = true;
        uniform_diff_background = true;
        borders = true;
      };
    };

    extraConfigLua =
      /*
      lua
      */
      ''
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
          ['LspCodeLens'] = '@comment',
          ['LspInlayHint'] = '@comment',
        }
        for newgroup, oldgroup in pairs(links) do
          vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
        end
      '';
  };
}
