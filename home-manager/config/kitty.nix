{ config, pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    theme = "Dark One Nuanced";
    shellIntegration.enableZshIntegration = true;
    font = {
      name = "Jetbrains Mono";
      size = 11.5;
    };
    settings = {
      enable_audio_bell = false;
      copy_on_select = true;
      confirm_os_window_close = 0;   
    };

  };
}
