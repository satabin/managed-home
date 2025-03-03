{ config
, isDesktop
, isWork
, lib
, pkgs
, ...
}: {
  home.packages = with pkgs;
    [
      alejandra
      async-profiler
      coq
      coursier
      dhall-lsp-server
      (fenix.stable.withComponents [
        "cargo"
        "clippy"
        "rustc"
        "rustfmt"
      ])
      gh
      jdk21
      lua-language-server
      nixd
      nixfmt-rfc-style
      pkg-config
      sbt
      scala-cli
      taplo
      texlab
      texliveMedium
      tree-sitter
      vifm
    ]
    ++ lib.lists.optionals (pkgs.stdenv.isLinux && isDesktop) [
      bitwarden-desktop
      meld
      rmview
    ] ++ lib.lists.optionals (!isWork) [
      bitwarden-cli
    ];

  xdg.configFile."rmview.json".text = builtins.toJSON {
    ssh = {
      address = [
        "remarkable"
      ];
      auth_metod = "key";
      key = "${config.home.homeDirectory}/.ssh/id_rsa";
    };
    orientation = "auto";
    pen_size = 15;
    pen_color = "red";
    pen_trail = 200;
  };

  programs.git = {
    enable = true;
    userName = "Lucas Satabin";
    userEmail = "lucas.satabin@gnieh.org";
    aliases = {
      purge-gone = "!git branch -vv | rg '\\[origin/.*: gone\\]' | awk '{print $1}' | xargs -r git branch -d";
      purge-force-gone = "!git branch -vv | rg '\\[origin/.*: gone\\]' | awk '{print $1}' | xargs -r git branch -D";
      ls-gone = "!git branch -vv | rg '\\[origin/.*: gone\\]' | awk '{print $1}'";
    };
    delta = {
      enable = true;
      options = {
        syntax-theme = "Nord";
        theme = "Nord";
        side-by-side = true;
      };
    };
  };
}
