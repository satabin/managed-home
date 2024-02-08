{pkgs, callPackage, ...}: let
  waveform = ./waveform.nix;
in {
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
      obs-studio-plugins.obs-transition-table
      obs-studio-plugins.obs-freeze-filter
      obs-studio-plugins.obs-gradient-source
      obs-studio-plugins.wlrobs
      (obs-studio-plugins.waveform.overrideAttrs (attrs: {
        postFixup = ''
          mkdir -p $out/lib $out/share/obs/obs-plugins
          mv $out/waveform/bin/64bit $out/lib/obs-plugins
          mv $out/waveform/data $out/share/obs/obs-plugins/waveform
          rm -rf $out/waveform
        '';
      }))
    ];
  };
}
