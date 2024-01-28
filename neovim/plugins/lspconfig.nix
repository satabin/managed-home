{ pkgs, ... }: {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      neodev-nvim
      lsp-inlayhints-nvim
    ];
    extraLuaConfig = /* lua */ ''
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }

      local handlers = require("lsp.handlers")
      handlers.setup()
      require("lsp.autocmds")
      require("lsp-inlayhints").setup({})

      -- global
      vim.opt_global.completeopt = { "menu", "noinsert", "noselect" }

      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, args.buf, false)
        end,
      })


      require('lspconfig')['lua_ls'].setup {
        server = {
          capabilities = handlers.capabilities,
          on_attach = function(client, bufnr)
            handlers.on_attach(client, bufnr)
          end
        },
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        }
      }

      -- toml
      require 'lspconfig'.taplo.setup {
        server = {
          capabilities = handlers.capabilities,
          on_attach = function(client, bufnr)
            handlers.on_attach(client, bufnr)
          end
        },
      }

      -- tex
      require('lspconfig')['texlab'].setup {
        server = {
          capabilities = handlers.capabilities,
          on_attach = function(client, bufnr)
            handlers.on_attach(client, bufnr)
          end
        }
      }

      -- nix
      require('lspconfig')['nil_ls'].setup {
        server = {
          capabilities = handlers.capabilities,
          on_attach = function(client, bufnr)
            handlers.on_attach(client, bufnr)
          end
        }
      }

      -- dhall
      require('lspconfig')['dhall_lsp_server'].setup {
        server = {
          capabilities = handlers.capabilities,
          on_attach = function(client, bufnr)
            handlers.on_attach(client, bufnr)
          end
        }
      }

    '';

  };

  xdg.configFile."nvim/lua/lsp/handlers.lua".source = ./lua/handlers.lua;
  xdg.configFile."nvim/lua/lsp/autocmds.lua".source = ./lua/autocmds.lua;

}

