{ pkgs, ... }: {

  home.packages = with pkgs; [
    coursier
    dhall-lsp-server
    jdk21
    lua-language-server
    nixd
    rustup
    sbt
    scala-cli
    taplo
    texlab
  ];

}
