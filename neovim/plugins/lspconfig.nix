let
  options = { noremap = true; silent = true; };
in
{
  programs.nixvim = {

    diagnostic.settings = {
      virtual_text = true;
      signs = {
        text = {
          "__rawKey__vim.diagnostic.severity.ERROR" = "";
          "__rawKey__vim.diagnostic.severity.WARN" = "";
          "__rawKey__vim.diagnostic.severity.HINT" = "";
          "__rawKey__vim.diagnostic.severity.INFO" = "";
        };
      };
      update_in_insert = true;
      underline = false;
      severity_sort = true;
      float = {
        focusable = false;
        style = "minimal";
        border = "rounded";
        source = "always";
        header = "";
        prefix = "";
      };
    };

    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;

        servers = {
          taplo.enable = true;
          texlab.enable = true;
          nixd = {
            enable = true;
            settings.formatting.command = [ "nixpkgs-fmt" ];
          };
          dhall_lsp_server.enable = true;
          tailwindcss.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          bashls.enable = true;
          html.enable = true;
          ts_ls.enable = true;
          cssls.enable = true;
        };
      };

      lspsaga = {
        enable = true;
        settings.lightbulb.enable = false;
      };
    };

    extraConfigLuaPre = /*lua*/''
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })
    '';


    keymaps = [
      {
        mode = [ "n" "t" ];
        key = "<space>t";
        action = "<cmd>Lspsaga term_toggle<CR>";
        options = options // { desc = "Toggle floating terminal"; };
      }
    ];

    keymapsOnEvents = {
      LspAttach = [
        {
          mode = "n";
          key = "<space>j";
          action = ''<cmd>lua vim.diagnostic.goto_prev { wrap = true }<CR>'';
          options = options // { desc = "Goto previous diagnostic"; };
        }
        {
          mode = "n";
          key = "<space>k";
          action = ''<cmd>lua vim.diagnostic.goto_next { wrap = true }<CR>'';
          options = options // { desc = "Goto next diagnostic"; };
        }
        {
          mode = "n";
          key = "<leader>e";
          action = ''<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>'';
          options = options // { desc = "Open diagnostic in floating window"; };
        }
        {
          mode = "n";
          key = "gd";
          action = ''<cmd>lua require("telescope.builtin").lsp_definitions({initial_mode='normal'})<CR>'';
          options = options // { desc = "Goto definition"; };
        }
        {
          mode = "n";
          key = "gy";
          action = ''<cmd>lua require("telescope.builtin").lsp_type_definitions({initial_mode='normal'})<CR>'';
          options = options // { desc = "Goto type definition"; };
        }
        {
          mode = "n";
          key = "vgd";
          action = ''<cmd>lua require("telescope.builtin").lsp_definitions({initial_mode='normal', jump_type='vsplit'})<CR>'';
          options = options // { desc = "Goto definition (vertical split)"; };
        }
        {
          mode = "n";
          key = "sgd";
          action = ''<cmd>lua require("telescope.builtin").lsp_definitions({initial_mode='normal', jump_type='split'})<CR>'';
          options = options // { desc = "Goto definition (split)"; };
        }
        {
          mode = "n";
          key = "K";
          action = ''<cmd>lua vim.lsp.buf.hover()<CR>'';
          options = options // { desc = "Show hover information"; };
        }
        {
          mode = "n";
          key = "gi";
          action = ''<cmd>lua require("telescope.builtin").lsp_implementations({initial_mode='normal'})<CR>'';
          options = options // { desc = "Find implementations"; };
        }
        {
          mode = "n";
          key = "gr";
          action = ''<cmd>lua require('telescope.builtin').lsp_references({initial_mode='normal'})<CR>'';
          options = options // { desc = "Find references"; };
        }
        {
          mode = "n";
          key = "<space>o";
          action = ''<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>'';
          options = options // { desc = "Show document symbols"; };
        }
        {
          mode = "n";
          key = "<space>s";
          action = ''<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>'';
          options = options // { desc = "Show workspace symbols"; };
        }
        {
          mode = "n";
          key = "gs";
          action = ''<cmd>lua vim.lsp.codelens.run()<CR>'';
          options = options // { desc = "Run"; };
        }
        {
          mode = "n";
          key = "<leader>sh";
          action = ''<cmd>lua vim.lsp.buf.signature_help()<CR>'';
          options = options // { desc = "Signature help"; };
        }
        {
          mode = "n";
          key = "<leader>rn";
          action = ''<cmd>Lspsaga rename<CR>'';
          options = options // { desc = "Rename symbol"; };
        }
        {
          mode = "n";
          key = "<leader>f";
          action = ''<cmd>lua vim.lsp.buf.format { async = true }<CR>'';
          options = options // { desc = "Reformat"; };
        }
        {
          mode = "n";
          key = "<leader>ca";
          action = ''<cmd>lua vim.lsp.buf.code_action()<CR>'';
          options = options // { desc = "Code action"; };
        }
        {
          mode = "n";
          key = "<space>a";
          action = ''<cmd>lua require("telescope.builtin").diagnostics({layout_strategy='vertical', initial_mode='normal', sort_by='severity'})<CR>'';
          options = options // { desc = "Show workspace diagnostics"; };
        }
        {
          mode = "n";
          key = "<space>d";
          action = ''<cmd>lua require("telescope.builtin").diagnostics({layout_strategy='vertical', bufnr=0, initial_mode='normal'})<CR>'';
          options = options // { desc = "Show buffer diagnostics"; };
        }
      ];
    };

    userCommands = {
      Actions.command = "lua vim.lsp.buf.code_action()";

      Outline.command = "Lspsaga outline";

      Reformat.command = "lua vim.lsp.buf.format { async = true }";

      Terminal.command = "Lspsaga term_toggle";

    };

  };

}
