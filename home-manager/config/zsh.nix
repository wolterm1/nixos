{config, pkgs} :
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      upd = "sudo nixos-rebuild switch --flake .#matthiasw";
      config = "cd ~/Repos";
      c = "clear";
  };
}
