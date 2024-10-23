{ inputs, pkgs, config, flake-self, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      spotify = "nohup spotify >/dev/null 2>&1 & disown";
      ll = "ls -l";
      upd = "sudo nixos-rebuild switch --flake .#matthiasw";
      c = "clear";
      cdnix = "cd ~/system_config/nixos";
      project = "cd ~/Coding_Projects";
      nf = "fastfetch";
      cnf = "clear; fastfetch";
      chrome = "nohup chromium >/dev/null 2>&1 & disown";
      kit = "nohup kitty >/dev/null 2>&1 & disown";
      vpnUp = "nmcli connection up openvpn_wolterm1_tcp --ask";
      vpnDown = "nmcli connection down openvpn_wolterm1_tcp";
      eduroamcs = "nmcli connection up eduroam-cs";
      eduroam = "nmcli connection up eduroam";
    };
    #shellInit = "agnoster";

    ohMyZsh = {
      enable = true;
      theme = "tonotdo";
      plugins = [ "git" "dircycle" ];
    };
  };
  users.defaultUserShell = pkgs.zsh;
}
