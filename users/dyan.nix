{ pkgs, ... }:
{

  programs = {
    zsh.enable = true;
    _1password.enable = true;
    _1password-gui.enable = true;
  };

  users.users.dyan = {
    isNormalUser = true;
    description = "it's me";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

  home-manager.users.dyan =
    { pkgs, ... }:
    {
      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.11";

      home.packages = with pkgs; [
        nerdfonts
      ];

      programs.alacritty = {
        enable = true;
      };

      programs.git = {
        enable = true;
        userName = "dyan Fedde";
        userEmail = "dyan@fedde.us";
      };

      programs.zsh = {
        enable = true;
        shellAliases = {
          gst = "git status";
        };
      };

      programs.neovim = {
        enable = true;
        defaultEditor = true;
        vimAlias = true;
        withNodeJs = true;
        extraPackages = with pkgs; [
          gcc
          lua-language-server
          nil
          #formatters
          nixfmt-rfc-style
          stylua
        ];
        plugins =
          with pkgs;
          with vimPlugins;
          [
            nvim-treesitter-parsers.nix
          ];
      };

      programs.starship = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          inline_height = 10;
          enter_accept = false;
        };
      };

      programs.ssh = {
        enable = true;
        extraConfig = ''
          Host *
            IdentityAgent ~/.1password/agent.sock
        '';
      };

      xdg.configFile.nvim = {
        source = ./nvim;
        recursive = true;
      };
    };
}
