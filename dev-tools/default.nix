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
      nixpkgs-fmt
      rustup
      sbt
      scala-cli
      taplo
      texlab
      texliveFull
      tree-sitter
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
