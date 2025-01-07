{ isDesktop
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
      gh
      jdk21
      lua-language-server
      nixd
      nixfmt-rfc-style
      rustup
      sbt
      scala-cli
      taplo
      texlab
      texliveFull
      tree-sitter
      vifm
    ]
    ++ lib.lists.optionals (pkgs.stdenv.isLinux && isDesktop) [
      meld
    ];

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
