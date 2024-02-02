{
  owner,
  repo,
  hash,
  rev ? "main",
  buildScript ? ":",
}: let
  pkgs = import <nixpkgs> {};
in
  pkgs.vimUtils.buildVimPlugin {
    pname = "${pkgs.lib.strings.sanitizeDerivationName repo}";
    version = rev;
    src = pkgs.fetchFromGitHub {
      inherit owner repo rev hash;
    };
    inherit buildScript;
  }
