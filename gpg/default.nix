{ isDesktop, lib, pkgs, ... }: {
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
    pinentryPackage = pkgs.pinentry-gnome3;
    defaultCacheTtl = 60;
    maxCacheTtl = 120;
  };

} // lib.mkIf (pkgs.stdenv.isLinux && isDesktop) {
  # gnome keyring starts an agent, and HM does not override it
  # let's disable the gnome keyring agent it manually
  xdg.configFile."autostart/gnome-keyring-ssh.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Hidden=true
  '';
}
