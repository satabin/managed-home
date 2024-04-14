{pkgs, ...}: let
  fromGithub = import ../../utils/fromGithub.nix;
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      nvim-dap
      nvim-dap-ui
      (fromGithub {
        owner = "m00qek";
        repo = "baleia.nvim";
        rev = "main";
        hash = "sha256-0NmiGzMFvL1awYOVtiaSd+O4sAR524x68xwWLgArlqs=";
      })
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        local map = vim.keymap.set

        local dap = require('dap')

        local dapui = require("dapui")

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open('sidebar')
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close('sidebar')
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close('sidebar')
        end

        map("n", "<leader>dc", function()
          require("dap").continue()
        end)

        map("n", "<leader>dr", function()
          require("dap").repl.toggle()
        end)

        map("n", "<leader>dK", function()
          require("dap.ui.widgets").hover()
        end)

        map("n", "<leader>dt", function()
          require("dap").toggle_breakpoint()
        end)

        map("n", "<leader>dso", function()
          require("dap").step_over()
        end)

        map("n", "<leader>dsi", function()
          require("dap").step_into()
        end)

        map("n", "<leader>dl", function()
          require("dap").run_last()
        end)


        dap.configurations.scala = {
          {
            type = "scala",
            request = "launch",
            name = "RunOrTest",
            metals = {
              runType = "runOrTestFile",
            },
          },
          {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
              runType = "testTarget",
            },
          },
        }

        vim.api.nvim_create_autocmd("FileType", {
          desc = "Force colorize on dap-repl",
          pattern = "dap-repl",
          group = vim.api.nvim_create_augroup("auto_colorize", { clear = true }),
          callback = function()
            local baleia = require('baleia').setup()
            baleia.automatically(vim.fn.bufnr('%'))
          end,
        })
      '';
  };
}
