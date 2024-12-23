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
      rx
    ];

  programs.git = {
    enable = true;
    userName = "Lucas Satabin";
    userEmail = "lucas.satabin@gnieh.org";
  };
}
