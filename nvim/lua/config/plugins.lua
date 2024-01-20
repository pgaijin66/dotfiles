
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- local plugins = {
--     { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
--     {'nvim-telescope/telescope.nvim', tag = '0.1.5',dependencies = { 'nvim-lua/plenary.nvim' }},
--     -- {"williamboman/mason.nvim",opts = {ensure_installed = {"gopls",},},},
-- }
-- local opts = {}

-- require("lazy").setup(plugins, opts)
-- local builtin = require("telescope.builtin")
-- vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- require("lazy").setup(plugins, opts)

require("lazy").setup({
  -- Color scheme
  { import = 'config.plugins.catppuccin' },

  -- Fuzzy finder
  { import = 'config.plugins.telescope' },

  -- nvimtree
  { import = 'config.plugins.nvimtree' },

  -- -- Language Server Protocol.
  -- { import = 'config.plugins.lsp.go.lua' },

}, {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "catppuccin", "habamax" },
  },
})