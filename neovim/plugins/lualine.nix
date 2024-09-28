{ pkgs, ... }: {
  programs.nixvim = {
    plugins.lualine = {
      enable = true;

      settings = {
        options = {
          icons_enabled = true;
          theme = "nord";
        };
        sections.lualine_c = [
          "filename"
          {
            __raw = /*lua*/''
              function()
                return require('lsp-progress').progress()
              end
            '';
          }
        ];
      };

    };

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "lsp-progress";
        src = pkgs.fetchFromGitHub {
          owner = "linrongbin16";
          repo = "lsp-progress.nvim";
          rev = "v1.0.12";
          hash = "sha256-FmVGiaN5Rzvidt2HYe8uZTaShBWab/YPZuGAQHdMwLk=";
        };
      })
    ];

    extraConfigLua = /*lua*/ ''
      require('lsp-progress').setup {}
    '';

    autoGroups = {
      lualine_augroup = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = "User";
        pattern = "LspProgressStatusUpdated";
        callback = { __raw = "require('lualine').refresh"; };
        group = "lualine_augroup";
      }
    ];

  };
}
