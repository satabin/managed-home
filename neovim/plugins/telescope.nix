{ pkgs, ... }:
let
  options = { noremap = true; silent = true; };
in
{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      extensions = {
        ui-select.enable = true;
        fzf-native.enable = true;
      };

      keymaps = {
        "<leader>ff" = {
          mode = "n";
          action = "find_files";
          options = options;
        };
        "<C-p>" = {
          mode = "n";
          action = "find_files";
          options = options;
        };
        "<leader>fb" = {
          mode = "n";
          action = "current_buffer_fuzzy_find";
          options = options;
        };
        "<leader>fg" = {
          mode = "n";
          action = "live_grep";
          options = options;
        };
      };

      settings.defaults = {
        path_display = [ "smart" ];
      };

    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>si";
        action = "<cmd>lua require('telescope').extensions.scaladex.scaladex.search()<CR>";
        options = options;
      }
    ];

    extraPlugins = [
      pkgs.vimPlugins.telescope-dap-nvim
      (pkgs.vimUtils.buildVimPlugin {
        name = "scaladex";
        src = pkgs.fetchFromGitHub {
          owner = "softinio";
          repo = "scaladex.nvim";
          rev = "75a8157e85381eb736a7d92acae5000394f41040";
          hash = "sha256-Zy/4OI31woNnsVxc4yBYmEPooK1qJ02YrdMiM9Y+tSA=";
        };
      })
      pkgs.vimPlugins.todo-comments-nvim
    ];

    userCommands = {
      Rg.command = "lua require('telescope.builtin').live_grep()";
    };

    extraConfigLua =
      /*
      lua
      */
      ''
        local telescope = require 'telescope'
        -- Extensions
        telescope.load_extension 'dap'

        require'todo-comments'.setup()
      '';
  };
}
