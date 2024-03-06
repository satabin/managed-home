{pkgs, ...}: {
  programs.gpg = {
    enable = true;
    mutableKeys = true;
    mutableTrust = true;
    settings = {
      keyserver = "hkps://keys.openpgp.org";
    };
  };

  services.gpg-agent = {
    enable = pkgs.stdenv.isLinux;
    enableScDaemon = true;
    enableSshSupport = true;
    enableZshIntegration = true;

    defaultCacheTtl = 60;
    maxCacheTtl = 120;
    pinentryFlavor = "gnome3";
  };

}
