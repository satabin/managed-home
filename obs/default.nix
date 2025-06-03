{isDesktop, isWork, lib, pkgs, ...}: lib.mkIf (isDesktop && !isWork) {
  programs.obs-studio = {
    enable = true;

    plugins = with pkgs; [
      obs-studio-plugins.obs-vkcapture
      obs-studio-plugins.obs-gstreamer
      obs-studio-plugins.input-overlay
      obs-studio-plugins.obs-source-record
      obs-studio-plugins.obs-pipewire-audio-capture
      obs-studio-plugins.obs-backgroundremoval
      obs-studio-plugins.obs-tuna
      obs-studio-plugins.obs-text-pthread
      obs-studio-plugins.obs-move-transition
      obs-studio-plugins.advanced-scene-switcher
      #obs-studio-plugins.obs-transition-table
      obs-studio-plugins.obs-freeze-filter
      obs-studio-plugins.obs-gradient-source
      obs-studio-plugins.wlrobs
      obs-studio-plugins.waveform
      obs-studio-plugins.obs-webkitgtk
    ];
  };
}
