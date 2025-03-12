{pkgs, ...}: {
  programs.nixvim = {
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "rainbow-csv";
        src = pkgs.fetchFromGitHub {
          owner = "mechatroner";
          repo = "rainbow_csv";
          rev = "d97048abd7ed1228eff06b490c4138a428e174c9";
          hash = "sha256-I8hRhfhoRXlKoUP6H/oKlNmX1QUIN8x7WdfBZJg7mRk=";
        };
      })
    ];
  };
}
