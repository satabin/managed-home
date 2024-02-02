{pkgs, ...}: {
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
            }
          },
        }
      '';
  };
}
