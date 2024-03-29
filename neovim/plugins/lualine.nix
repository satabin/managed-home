{pkgs, ...}: let
  fromGithub = import ../../utils/fromGithub.nix;
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      lualine-nvim
      (fromGithub {
        owner = "linrongbin16";
        repo = "lsp-progress.nvim";
        rev = "v1.0.9";
        hash = "sha256-wCVh/cZ7E60G4R+b8qzb8t7vGEMRA+469jCPsiyNlKw=";
      })
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        local lualine = require('lualine')
        local lsp_progress = require('lsp-progress')
        lsp_progress.setup {}
        lualine.setup {
          ...,
          options = {
            icons_enabled = true,
            theme = 'nord',
          },
          tabline = {
            lualine_a = { 'buffers' },
          },
          sections = {
            ...,
            lualine_c = {
              'filename',
              require('lsp-progress').progress,
            },
          },
        }
        -- listen lsp-progress event and refresh lualine
        vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
        vim.api.nvim_create_autocmd("User", {
          group = "lualine_augroup",
          pattern = "LspProgressStatusUpdated",
          callback = lualine.refresh,
        })
      '';
  };
}
