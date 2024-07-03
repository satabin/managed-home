{pkgs, ...}: {
  imports = [
    ./plugins/cmp.nix
    ./plugins/coqtail.nix
    ./plugins/dap.nix
    ./plugins/devicons.nix
    ./plugins/lspconfig.nix
    ./plugins/lualine.nix
    ./plugins/metals.nix
    ./plugins/nord.nix
    ./plugins/rust-tools.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # plugins which do not require any extra configuration
    # for readability reasons, the plugins with configuration
    # are in their own files
    plugins = {
      fugitive.enable = true;
      vimtex.enable = true;
      gitgutter.enable = true;
      surround.enable = true;
      neogit.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-visual-multi
      rust-vim
      vim-toml
      auto-pairs
      vifm-vim
      vim-numbertoggle
      plenary-nvim
      fzf-vim
    ];

    opts = {
      termguicolors = true;
      laststatus = 2;
      showmode = false;
      sw = 2;
      ts = 2;
      expandtab = true;
      nu = true;
      rnu = true;
      ai = true;
      si = true;
      cursorline = true;
      mouse = "a";
      wildmode = "list:longest";
      wrap = true;
      linebreak = true;
      list = false;
      foldenable = false;
      ignorecase = false;
      smartcase = true;
      # allow hidden buffer
      hidden = true;
      shortmess = "atI";
      # reload files changed outside vim
      autoread = true;
      wildignore = [
        "*/tmp/*"
        "*.so"
        "*.swp"
        "*.zip"
        "*.class"
        "*/target/*"
        "*/out/*"
        "*/node_modules/*"
        "*.aux"
        "*.fls"
        "*.log"
        "*.out"
        "*.toc"
        "*/output/*"
      ];
      hlsearch = false;
    };

    globals = {
      vimtex_fold_enabled = 0;
      vimtex_latexmk_build_dir = "build";
      vimtex_quickfix_mode = 2;
      scala_scaladoc_indent = 1;
      # disable netrw
      loaded_netrwPlugin = 1;
      loaded_netrw = 1;
      # replace netrw by vifm
      vifm_replace_netrw = 1;
      vifm_replace_netrw_cmd = "Vifm";
    };

    globalOpts = {
      completeopt = ["menu" "noinsert" "noselect"];
    };

    keymaps = [
      {
        mode = "n";
        action = "mzg~iw`z";
        key = "<F7>";
        options = {
          noremap = true;
          silent = true;
        };
      }
    ];

    userCommands = {
      Explore = {
        command = ":e %:p:h";
        nargs = 0;
      };
    };

  };
}
