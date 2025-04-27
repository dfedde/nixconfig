vim.keymap.set("v", "\\b", ":.!figlet<CR>", { desc = "make it big and pretty" })
vim.keymap.set("n", "\\sv", ":source $MYVIMRC<CR>", { desc = "Reload Neovim config" })

--  __  __       _   _                 
-- |  \/  | ___ | |_(_) ___  _ __  ___ 
-- | |\/| |/ _ \| __| |/ _ \| '_ \/ __|
-- | |  | | (_) | |_| | (_) | | | \__ \
-- |_|  |_|\___/ \__|_|\___/|_| |_|___/
--
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition of symbol under cursor" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true, desc = "Find all references of symbol under cursor" })

vim.cmd 'colorscheme tokyonight-moon'
