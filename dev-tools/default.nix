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

  programs.git = {
    enable = true;
    userName = "Lucas Satabin";
    userEmail = "lucas.satabin@gnieh.org";
  };

}
