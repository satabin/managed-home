{ pkgs, ... }: {
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      Coqtail
    ];

    autoGroups = {
      CoqtailHighlights = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = [ "ColorScheme" ];
        pattern = [ "nord" ];
        group = "CoqtailHighlights";
        callback = /*lua*/''
          function()
            vim.api.nvim_set_hl(0, 'CoqtailSent', { bg = '#b48ead' })
            vim.api.nvim_set_hl(0, 'CoqtailChecked', { bg = '#3a5557' })
            vim.api.nvim_set_hl(0, 'CoqtailError', { bg = '#bf616a' })
          end
        '';
      }
    ];
  };
}
