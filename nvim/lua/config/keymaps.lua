--- keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = ' '

-- Quickly clear search highlighting.
vim.keymap.set('n', '<leader>k', ':nohlsearch<CR>')

-- Allow gf to open non-existent files
vim.cmd("map gf :edit <cfile><cr>")

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set('v', 'y', 'myy`y')
vim.keymap.set('v', 'Y', 'myY`y')

-- disable netrw at the very start of your init.lua ( for NVIM tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1