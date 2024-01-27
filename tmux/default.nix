{ pkgs, ... }: {

  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;

    terminal = "screen-256color";

    extraConfig = ''
      # Clear scroll history
      bind -n C-k clear-history

      set -ga terminal-overrides ",alacritty:Tc"

      # Enable title bar
      set -g set-titles on
      set -g set-titles-string "#T"

      # Split panes with | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
    '';

    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.nord
    ];

  };

}
