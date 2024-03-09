{lib, ...}: {
  programs.starship = {
    enable = true;

    settings = {
      format = lib.concatStrings [
        "$shell"
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$nix_shell"
        "$kubernetes"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];

      shell.disabled = false;

      username = {
        show_always = false;
        style_root = "red";
        style_user = "green";
      };

      directory = {
        style = "blue";
        read_only = " ";
      };

      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };

      git_branch.symbol = " ";

      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
        min_time = 0;
      };

      kubernetes.disabled = false;
    };
  };
}
