{config, pkgs, ...}:
{
  programs.kitty = {
    enable = true;
    theme = "Desert";
    shellIntegration.enableZshIntegration = true; 
    font  = {
      name  = "JetBrains Mono";
      size = 14.0;
    };
    settings = {
      enable_audio_bell = false;
      copy_on_select = true;
      confirm_os_window_close = 0;
    };


  };
}
