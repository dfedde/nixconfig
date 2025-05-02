require("config.lazy")
require("config.niceities") -- My hot keys
require("neodev").setup{} -- Visuals
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
-- local lspconfig = require('lspconfig')
-- local navic = require("nvim-navic")

-- lspconfig.clangd.setup {
--     on_attach = function(client, bufnr)
--         navic.attach(client, bufnr)
--     end
-- }
--
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})
lspconfig.nil_ls.setup()
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
-- lspconfig.ts_ls.setup{}


vim.wo.number = true

vim.opt.tabstop = 2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.expandtab = True
vim.opt.list = True
vim.opt.listchars= 'tab:>-'


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
require("config.statusline") -- statusline


--  ,__ __                                               
-- /|  |  |                                              
--  |  |  |   __        _   _  _  _    _   _  _  _|_  ,  
--  |  |  |  /  \_|  |_|/  / |/ |/ |  |/  / |/ |  |  / \_
--  |  |  |_/\__/  \/  |__/  |  |  |_/|__/  |  |_/|_/ \/ 
--
-- netrw replacement
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
require("oil").setup{
	view_options = {
		-- Show files and directories that start with "."
		show_hidden = true
	}
}
require("config.telescope")
end
