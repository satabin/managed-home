{ pkgs, ... }: {
  imports = [
    ./plugins/cmp.nix
    ./plugins/coqtail.nix
    ./plugins/dap.nix
    ./plugins/devicons.nix
    ./plugins/lspconfig.nix
    ./plugins/lualine.nix
    ./plugins/metals.nix
    ./plugins/neorg.nix
    ./plugins/nord.nix
    ./plugins/rust-tools.nix
    ./plugins/surround.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    # plugins which do not require any extra configuration
    # for readability reasons, the plugins with configuration
    # are in their own files
    plugins = with pkgs.vimPlugins; [
      vim-fugitive
      vim-visual-multi
      vimtex
      vim-gitgutter
      rust-vim
      vim-toml
      auto-pairs
      vifm-vim
      vim-numbertoggle
      plenary-nvim
      fzf-vim
    ];

    extraLuaPackages = luaPkgs: with luaPkgs; [
      lua-utils-nvim
      pathlib-nvim
    ];

    extraLuaConfig =
      /*
      lua
      */
      ''
        vim.opt.termguicolors = true
        vim.opt.laststatus = 2
        vim.opt.showmode = false

        vim.opt.sw = 2
        vim.opt.ts = 2
        vim.opt.expandtab = true

        vim.opt.nu = true
        vim.opt.rnu = true
        vim.opt.ai = true
        vim.opt.si = true
        vim.opt.cursorline = true
        vim.opt.mouse = 'a'
        vim.opt.wildmode = 'list:longest'
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.list = false
        vim.opt.foldenable = false

        vim.g.vimtex_fold_enabled = 0
        vim.g.vimtex_latexmk_build_dir = 'build'
        vim.g.vimtex_quickfix_mode = 2

        -- <F7> for word case toggle
        vim.api.nvim_set_keymap('n', '<F7>', 'mzg~iw`z', { noremap = true, silent = true })

        -- make search case sensitive only if search apttern contains an upper case
        -- letter
        vim.opt.ignorecase = false
        vim.opt.smartcase = true

        -- allow hidden buffer
        vim.opt.hidden = true

        vim.opt.shortmess = "atI"

        -- reload files changed outside vim
        vim.opt.autoread = true

        vim.opt.wildignore:append {
          '*/tmp/*',
          '*.so',
          '*.swp',
          '*.zip',
          '*.class',
          '*/target/*',
          '*/out/*',
          '*/node_modules/*',
          '*.aux',
          '*.fls',
          '*.log',
          '*.out',
          '*.toc',
          '*/output/*'
        }

        vim.opt.hlsearch = false

        -- use scala indentation for doc comments
        vim.g.scala_scaladoc_indent = 1

        vim.api.nvim_create_user_command('Explore', ':e %:p:h', { nargs = 0 })
        -- disable netrw
        vim.g.loaded_netrwPlugin = 1
        vim.g.loaded_netrw = 1
        -- replace netrw by vifm
        vim.g.vifm_replace_netrw = 1
        vim.g.vifm_replace_netrw_cmd = 'Vifm'

        vim.api.nvim_set_hl(0,"@text.strike",{strikethrough=true})
      '';
  };
}
