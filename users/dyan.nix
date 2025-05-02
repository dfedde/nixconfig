
{ config, pkgs, ... }: {


	programs = {
		zsh.enable = true;
		_1password.enable = true;
		_1password-gui.enable = true;
	};

	users.users.dyan = {
		isNormalUser = true;
		description = "it's me";
		extraGroups = [ "networkmanager" "wheel" ];
		shell = pkgs.zsh;
	};

	home-manager.users.dyan = { pkgs, ... }: {
# The state version is required and should stay at the version you
# originally installed.
		home.stateVersion = "24.11";

		programs.git = {
			enable = true;
			userName = "dyan Fedde";
			userEmail = "dyan@fedde.us";
		};

		programs.zsh = {
			enable = true;
			zplug = {
				enable = true;
				plugins = [
				];
			};
			shellAliases = {
			};

		};

		programs.neovim = {
			enable = true;
			defaultEditor = true;
			vimAlias = true;
			extraPackages = [
			pkgs.gcc
			pkgs.nodejs_23
			pkgs.lua-language-server
			]; # this is a hack so lazy can do some compiling
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
