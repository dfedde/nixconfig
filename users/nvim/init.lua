require("config.lazy")
require("config.niceities") -- My hot keys
require("neodev").setup {}  -- Visuals
--    _        , __     ___               _
-- \_|_)    ()/|/  \   / (_)             | | o
--   |      /\ |___/  |      __   _  _   | |     __,
--  _|     /  \|      |     /  \_/ |/ |  |/  |  /  |
-- (/\___//(__/|       \___/\__/   |  |_/|__/|_/\_/|/
--                                       |\       /|
--                                       |/       \|
-- LSP installer
-- require("mason").setup{}
-- require("mason-lspconfig").setup{
-- 	ensure_installed = {"lua_ls", "nil_ls"},
-- }
--
--
-- local navic = require("nvim-navic")

-- lspconfig.clangd.setup {
--     on_attach = function(client, bufnr)
--         navic.attach(client, bufnr)
--     end
-- }
--
local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

lspconfig.nil_ls.setup({
  settings = {
    ['nil'] = {
      formatting = {
        command = { "nixfmt" },
      },
    },
  },
})

require("conform").setup({
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  nix = { "nixfmt" },
  lua = { "stylua" },

  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
    -- Add other filetypes as needed
  },
})
--
-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'sh',
--   callback = function()
--     vim.lsp.start({
--       name = 'bash-language-server',
--       cmd = { 'bash-language-server', 'start' },
--     })
--   end,
-- })
--
-- -- GDscript
-- lspconfig.gdscript.setup{}
-- lspconfig.bacon_ls.setup{}
--
-- -- typescript
lspconfig.ts_ls.setup {}


vim.wo.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = 'tab:>-'


if (vim.g.vscode) then
  -- VSCode extension
else
  -- Lazy package manager

  --  _                            _
  -- (_|   |_/o                   | |
  --   |   |      ,          __,  | |  ,
  --   |   |  |  / \_|   |  /  |  |/  / \_
  --    \_/   |_/ \/  \_/|_/\_/|_/|__/ \/
  --
  -- require("config.statusline") -- statusline


  --  ,__ __
  -- /|  |  |
  --  |  |  |   __        _   _  _  _    _   _  _  _|_  ,
  --  |  |  |  /  \_|  |_|/  / |/ |/ |  |/  / |/ |  |  / \_
  --  |  |  |_/\__/  \/  |__/  |  |  |_/|__/  |  |_/|_/ \/
  --
  -- netrw replacement
  vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  require("oil").setup {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true
    }
  }
  require("config.telescope")
end
