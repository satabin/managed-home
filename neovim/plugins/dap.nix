let
  options = {
    noremap = true;
    silent = true;
  };
in
{
  programs.nixvim = {
    plugins.dap = {
      enable = true;
      extensions.dap-ui.enable = true;
      extensions.dap-virtual-text.enable = true;

      signs = {
        dapBreakpoint.text = "󰉀";
        dapBreakpointCondition.text = "󰈼";
        dapBreakpointRejected.text = "";
        dapLogPoint.text = "";
        dapStopped.text = "";
      };

      configurations = {
        scala = [
          {
            type = "scala";
            request = "launch";
            name = "Run Or Test";
            metals = {
              runType = "runOrTestFile";
            };
          }
          {
            type = "scala";
            request = "launch";
            name = "Test Target";
            metals = {
              runType = "testTarget";
            };
          }
        ];
      };
    };

    plugins.cmp-dap.enable = true;
    plugins.baleia.enable = true; # colorize terminal output

    keymaps = [
      {
        mode = "n";
        key = "<leader>dc";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap").continue()
            end
          '';
        options = options // { desc = "Start or continue debugger"; };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap").repl.toggle()
            end
          '';
        options = options // { desc = "Toggle debugger REPL"; };
      }
      {
        mode = "n";
        key = "<leader>dK";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap.ui.widgets").hover()
            end
          '';
        options = options // { desc = "Show debugger hover"; };
      }
      {
        mode = "n";
        key = "<leader>dt";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap").toggle_breakpoint()
            end
          '';
        options = options // { desc = "Toggle breakpoint"; };
      }
      {
        mode = "n";
        key = "<leader>dlp";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end
          '';
        options = options // { desc = "Set log point"; };
      }
      {
        mode = "n";
        key = "<leader>dso";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap").step_over()
            end
          '';
        options = options // { desc = "Step over"; };
      }
      {
        mode = "n";
        key = "<leader>dsi";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap").step_into()
            end
          '';
        options = options // { desc = "Step into"; };
      }
      {
        mode = "n";
        key = "<leader>dl";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dap").run_last()
            end
          '';
        options = options // { desc = "Rerun last"; };
      }
      {
        mode = "v";
        key = "<leader>dw";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dapui").elements.watches.add()
            end
          '';
        options = options // { desc = "Watch selected expression"; };
      }
      {
        mode = "n";
        key = "<leader>dw";
        action.__raw =
          /*
          lua
          */
          ''
            function()
              require("dapui").elements.watches.add()
            end
          '';
        options = options // { desc = "Watch variable"; };
      }
    ];

    userCommands = {
      DebugToggle = {
        command = "lua require('dapui').toggle()";
      };
    };

    extraConfigLua =
      /*
      lua
      */
      ''
        local dap = require('dap')
        local dapui = require('dapui')
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open('sidebar')
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close('sidebar')
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close('sidebar')
        end
      '';

    autoGroups = {
      dap-colorize = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = [ "dap-repl" ];
        callback = {
          __raw =
            /*
            lua
            */
            ''
              function()
                local baleia = require('baleia').setup()
                baleia.automatically(vim.fn.bufnr('%'))
              end
            '';
        };
        group = "dap-colorize";
      }
    ];
  };
}
