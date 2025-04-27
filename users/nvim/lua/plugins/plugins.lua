return {
	--  ,__ __                   , __  _                             
	-- /|  |  |                 /|/  \| |             o              
	--  |  |  |   _ _|_  __,     |___/| |         __,     _  _    ,  
	--  |  |  |  |/  |  /  |     |    |/  |   |  /  | |  / |/ |  / \_
	--  |  |  |_/|__/|_/\_/|_/   |    |__/ \_/|_/\_/|/|_/  |  |_/ \/ 
	--                                             /|                
	-- Plugins for writing plugins                 \|                
	"folke/neodev.nvim",
	"folke/which-key.nvim",

	--                                                   
	--   ()                     |                 |      
	--   /\_|_  __,   _  _    __|   __,   ,_    __|   ,  
	--  /  \|  /  |  / |/ |  /  |  /  |  /  |  /  |  / \_
	-- /(__/|_/\_/|_/  |  |_/\_/|_/\_/|_/   |_/\_/|_/ \/ 
	-- 
	-- Things my fingers just do...
	"tpope/vim-surround",
	"tpope/vim-fugitive",
	"tomtom/tcomment_vim",
	{
		'stevearc/oil.nvim',
		opts = {
		},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	"Pocco81/auto-save.nvim",

	--  _                            _        
	-- (_|   |_/o                   | |       
	--   |   |      ,          __,  | |  ,    
	--   |   |  |  / \_|   |  /  |  |/  / \_  
	--    \_/   |_/ \/  \_/|_/\_/|_/|__/ \/   
	--    
	-- Vanity and eye candy
	{
		'yamatsum/nvim-nonicons',
		requires = {'kyazdani42/nvim-web-devicons'}
	},
	{
		"nvimdev/galaxyline.nvim",
		-- your statusline
		config = function()
		end,
		-- some optional icons
		dependencies = { "nvim-tree/nvim-web-devicons" }
	},
	-- show current code context
	{
		"SmiteshP/nvim-navic",
		dependencies = {"neovim/nvim-lspconfig"}
	},
	"folke/tokyonight.nvim",

	-- LSP
	"williamboman/mason.nvim",

	--                                  
	--   ()                             
	--   /\        _  _  _|_  __,       
	--  /  \|   | / |/ |  |  /  |  /\/  
	-- /(__/ \_/|/  |  |_/|_/\_/|_/ /\_/
	--         /|                       
	--         \|                       
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release is way too old and doesn't work on Windows
		build = ":TSUpdate",
		event = { "VeryLazy" },
		lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
		init = function(plugin)
			-- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
			-- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
			-- no longer trigger the **nvim-treesitter** module to be loaded in time.
			-- Luckily, the only things that those plugins need are the custom queries, which we make available
			-- during startup.
			require("lazy.core.loader").add_to_rtp(plugin)
			require("nvim-treesitter.query_predicates")
		end,
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		opts_extend = { "ensure_installed" },
		---@type TSConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
				"gdscript",
				"terraform",
				"ruby",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
					goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
				},
			},
		},
		---@param opts TSConfig
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
	--   ___                       _                             
	--  / (_)                     | |        o                   
	-- |      __   _  _  _     _  | |  _ _|_     __   _  _    ,  
	-- |     /  \_/ |/ |/ |  |/ \_|/  |/  |  |  /  \_/ |/ |  / \_
	--  \___/\__/   |  |  |_/|__/ |__/|__/|_/|_/\__/   |  |_/ \/ 
	--                      /|                                   
	--                      \|                                   
	{"neoclide/coc.nvim", branch="release"},
	{
		"neovim/nvim-lspconfig", -- REQUIRED: for native Neovim LSP integration
		lazy = false, -- REQUIRED: tell lazy.nvim to start this plugin at startup
		dependencies = {
			-- main one
			{ "ms-jpq/coq_nvim", branch = "coq" },
			-- 9000+ Snippets
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },

			-- lua & third party sources -- See https://github.com/ms-jpq/coq.thirdparty
			-- Need to **configure separately**
			{ 'ms-jpq/coq.thirdparty', branch = "3p" }
			-- - shell repl
			-- - nvim lua api
			-- - scientific calculator
			-- - comment banner
			-- - etc
		},
		init = function()
			vim.g.coq_settings = {
				auto_start = true, -- if you want to start COQ at startup
				-- Your COQ settings here
			}
		end,
		config = function()
			require("coq_3p") {
				{ src = "nvimlua", short_name = "nLUA" },
				-- { src = "vimtex",  short_name = "vTEX" },
				-- { src = "codeium", short_name = "COD" },
				{ src = "bc", trigger = "=", short_name = "MATH", precision = 6 },
				{
					src = "figlet",
					short_name = "BIG" },
					fonts = {
						"/usr/share/figlet/fonts/script.flf",
						"/usr/share/figlet/fonts/standard.flf",
						"/usr/share/figlet/fonts/slant.flf"
					}
				}
				-- Your LSP settings here
			end,
	},
	-- rust
	{
	  'mrcjkb/rustaceanvim',
	  version = '^5', -- Recommended
	  lazy = false, -- This plugin is already lazy
	},

	-- Ruby
	"vim-ruby/vim-ruby",

	-- to work better with tmux
	"sjl/vitality.vim",

	--  for terraform 
	"hashivim/vim-terraform",
	"juliosueiras/vim-terraform-completion",

	--  for bash
	"vim-scripts/bats.vim",
	"bash-lsp/bash-language-server",

	--  for love2d
	"davisdude/vim-love-docs",

	--  for godot
	"habamax/vim-godot",

	--  for kitty
	"fladson/vim-kitty",
	--   ____    ___,  , __ 
	--  (|   \  /   | /|/  \
	--   |    ||    |  |___/
	--  _|    ||    |  |    
	-- (/\___/  \__/\_/|    
	"mfussenegger/nvim-dap"
	}
