{ pkgs, ... }:
let
  options = { noremap = true; silent = true; };
in
{
  programs.nixvim = {
    extraPlugins = [
      pkgs.vimPlugins.nvim-metals
    ];

    keymapsOnEvents = {
      LspAttach = [
        {
          mode = "v";
          key = "K";
          action = ''<cmd>lua require('metals').type_of_range()<CR>'';
          options = options // { desc = "Show type"; };
        }
      ];
    };

    userCommands = {
      OR.command = "MetalsOrganizeImports";

      Reveal.command = "lua require('metals.tvp').reveal_in_tree()";

      Treeview.command = "lua require('metals.tvp').toggle_tree_view()";
    };

    autoGroups = {
      nvim-metals = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = [ "scala" "sbt" "java" ];
        callback = {
          __raw = /*lua */''
            function()
              local opts = { noremap = true, silent = true }
              local api = vim.api
              local cmd = vim.cmd
              local metals = require("metals")
              local metals_config = metals.bare_config()

              local capabilities = vim.lsp.protocol.make_client_capabilities()
              local cmp_nvim_lsp = require("cmp_nvim_lsp")
              metals_config.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

              metals_config.on_attach = function(client, bufnr)
                metals.setup_dap()
              end

              metals_config.init_options = {
                statusBarProvider = "off",
                icons = "unicode",
                disableColorOutput = false,
              }

              metals_config.settings = {
                showImplicitArguments = true,
                showImplicitConversionsAndClasses = true,
                showInferredType = true,
              }
              require("metals").initialize_or_attach(metals_config)
            end
          '';
        };
        group = "nvim-metals";
      }
    ];
  };
}
