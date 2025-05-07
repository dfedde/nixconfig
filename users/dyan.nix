{ pkgs, ... }:
{

  imports = [
    ./fun.nix
    ./bones.nix
  ];
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

  home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  home-manager.users.dyan =
    { pkgs, ... }:
    {
      # The state version is required and should stay at the version you
      # originally installed.
      home.stateVersion = "24.11";

      home.packages = with pkgs; [
        nerdfonts
        podman
        podman-compose
        spotify-player
        obsidian
        devenv
      ];

      programs = {
        alacritty = {
          enable = true;
          settings = {
            font = {
              normal = {
                family = "VictorMonoNerdFontMono";
                style = "normal";
              };
            };

          };
        };

        git = {
          enable = true;
          userName = "dyan Fedde";
          userEmail = "dyan@fedde.us";
        };

        zsh = {
          enable = true;
          syntaxHighlighting.enable = true;
          shellAliases = {
            gst = "git status";
          };
        };

        neovim = {
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

        starship = {
          enable = true;
          enableZshIntegration = true;
        };

        atuin = {
          enable = true;
          enableZshIntegration = true;
          settings = {
            inline_height = 10;
            enter_accept = false;
          };
        };

        ssh = {
          enable = true;
          extraConfig = ''
            IdentityAgent ~/.1password/agent.sock
          '';
        };
      };
      xdg.configFile.nvim = {
        source = ./nvim;
        recursive = true;
      };

      xdg.configFile.i3 = {
        source = ./i3;
        recursive = true;
      };
    };
}
