{ config, pkgs, ... }:
{
  programs.fastfetch = {
    enable = true;


    settings = {
      logo = {
        padding = {
          left = 2;
        };
        type = "auto";
      };
      display = {
        color = {
          keys = "cyan";
          title = "blue";
          output = "cyan";
          separator = "magenta";
        };

        percent = {
          type = 9;
        };
        separator = " ";
      };
      modules =
        [
          # {
          #   type = "title";
          # }
          # {
          #   type = "custom";
          #   format = ''──────────────────'';
          # }
          # {
          #   type = "os";
          # }
          # {
          #   type = "host";
          # }
          # {
          #   type = "kernel";
          # }
          # {
          #   type = "cpu";
          # }
          # {
          #   type = "gpu";
          # }
          # {
          #   type = "display"; 
          # }
          # {
          #   type = "de";
          # }
          # {
          #   type = "wmtheme";
          # }
          # {
          #   type = "terminal";
          # }
          # {
          #   type = "memory";
          # }
          # {
          #   type = "disk";
          # }
          # {
          #   type = "battery";
          # }

          {
            key = "               ";
            type = "battery";
          }
          {
            type = "custom";
            outputColor = "cyan";
            format = ''┌──────────────────────────────────────────────┐'';
          }
          {
            type = "title";
            key = " ╭─";
            keyColor = "blue";
          }

          {
            type = "os";
            key = " ├─";
            keyColor = "blue";
          }
          {
            type = "kernel";
            key = " ├─";
            keyColor = "blue";
          }
          {
            type = "packages";
            key = " ├─";
            keyColor = "blue";
          }
        ]
        ++ [
          {
            type = "shell";
            key = " ╰─";
            keyColor = "blue";
          }
          {
            type = "custom";
            outputColor = "cyan";
            format = ''├──────────────────────────────────────────────┤'';
          }
          {
            type = "display";
            key = " ╭─";
            keyColor = "blue";
            compactType = "original-with-refresh-rate";
          }
          {
            type = "cpu";
            key = " ├─";
            keyColor = "blue";
          }
          {
            type = "gpu";
            key = " ├─";
            keyColor = "blue";
          }
          {
            type = "disk";
            key = " ├─";
            keyColor = "blue";
          }
          {
            type = "memory";
            key = " ╰─";
            keyColor = "blue";
          }
          {
            type = "custom";
            outputColor = "cyan";
            format = ''├──────────────────────────────────────────────┤'';
          }
          {
            type = "de";
            key = " ╭─";
            keyColor = "blue";
          }
          {
            type = "wm";
            key = " ├─";
            keyColor = "blue";
          }
          {
            type = "wmtheme";
            key = " ├─";
            keyColor = "blue";
          }
          {
            type = "terminal";
            key = " ╰─";
            keyColor = "blue";
          }
          {
            type = "custom";
            outputColor = "cyan";
            format = ''└──────────────────────────────────────────────┘'';
          }
          "break"
        ];
    };
  };
} 
