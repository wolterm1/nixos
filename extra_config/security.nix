{ inputs, pkgs, config, flake-self, ... }:
{
  security = {
    polkit.enable = true;
  };

}

