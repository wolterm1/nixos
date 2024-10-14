{ inputs, pkgs, config, flake-self, ... } :
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
      config = "cd ~/Repos";
      project = "cd ~/Coding_Projects";
      nf = "fastfetch";
      cnf = "clear; fastfetch";
      chrome = "nohup chromium >/dev/null 2>&1 & disown";
      kit = "nohup kitty >/dev/null 2>&1 &disown";
      vpnUp = "nmcli connection up openvpn_wolterm1_tcp";
      vpnDown = "nmcli connection down openvpn_wolterm1_tcp";
      eduroamcs = "nmcli connection up eduroam-cs";
      eduroam = "nmcli connection up eduroam";
      nigger = "~/Coding_Projects/scripts/ascii_bobo.sh";
    };
    #shellInit = "fastfetch";

    ohMyZsh = {
      enable = true;
      theme = "eastwood";
      plugins = [ "git" "dircycle" ];
    };
  };
  users.defaultUserShell = pkgs.zsh;
}
