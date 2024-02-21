{
  pkgs,
  lib,
  ...
}: let
  fromGithub = import ../../utils/fromGithub.nix;
in {
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (neorg.overrideAttrs ({postInstall ? "", ...}: {
        postInstall =
          postInstall
          + ''
            nvim --headless +"Neorg sync-parsers" +qa
          '';
      }))
      neorg-telescope
      luasnip
      (fromGithub {
        owner = "pysan3";
        repo = "neorg-templates";
        rev = "v2.0.3";
        hash = "sha256-nZOAxXSHTUDBpUBS/Esq5HHwEaTB01dI7x5CQFB3pcw=";
      })
    ];
    extraLuaConfig =
      /*
      lua
      */
      ''
        require('neorg').setup {
          load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.export"] = {},
            ["core.esupports.metagen"] = {
              config = {
                timezone = "utc",
              },
            },
            ["core.dirman"] = {
              config = {
                workspaces = {
                  notes = "~/.local/share/neorg/notes",
                  tasks = "~/.local/share/neorg/tasks",
                  work = "~/.local/share/neorg/work",
                },
              },
            },
            ["core.integrations.telescope"] = {},
            ["core.completion"] = {
              config = {
                engine = "nvim-cmp",
              },
            },
            ["external.templates"] = {
              config = {
                keywords = {
                  NOW = function()
                    return require("luasnip").text_node(os.date("!%Y-%m-%dT%H:%M:%S+0000"))
                  end,
                },
              },
            },
          },
        }
      '';
  };

  xdg.configFile."nvim/templates/norg/" = {
    source = ./neorg-templates;
    recursive = true;
  };
}
