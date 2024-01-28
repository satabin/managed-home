{ pkgs, ... }: {

  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (ts-plugins:
        with ts-plugins; [
          hocon
          java
          json
          lua
          markdown
          nix
          ruby
          rust
          scala
          toml
          yaml
        ]
      ))
    ];
    extraLuaConfig = /* lua */ ''
      require('nvim-treesitter.configs').setup {
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = {
          enable = true
        }
      }

      local hocon_group = vim.api.nvim_create_augroup("hocon", { clear = true })
      vim.api.nvim_create_autocmd(
        { 'BufNewFile', 'BufRead' }, 
        { group = hocon_group, pattern = '*/*.conf', command = 'set ft=hocon' }
      )
    '';
  };

}
