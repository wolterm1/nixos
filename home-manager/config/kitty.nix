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
      background_opacity = "0.6";
      background_blur = "1";
    };
    
    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
    };
  };
}
