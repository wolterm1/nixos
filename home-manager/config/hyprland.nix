{ pkgs, lib, ...}:

{
  
  wayland.windowManager.hyprland.settings = {
     "$mod" = "SUPER";
     "$menu" = "wofi --show drun";
     bind = 
     [
       "$mod, R, $menu"
     ];
  };
}
