{ pkgs, ... }:
{

  imports = [ ./fun.nix ];
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

  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Useful other development tools
  environment.systemPackages = with pkgs; [
    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    docker-compose # start group of containers for dev
    # podman-compose # start group of containers for dev
  ];

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
      ];

      programs = {
        alacritty = {
          enable = true;
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
    };
}
