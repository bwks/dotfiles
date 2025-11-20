-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Normal mode mapping (open/close)
vim.keymap.set("n", "<C-k>", function()
  require("toggleterm").toggle(1, nil, nil, "float")
end, { desc = "Toggle floating terminal (normal mode)" })

-- Terminal mode mapping (also closes)
vim.keymap.set("t", "<C-k>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
  require("toggleterm").toggle(1, nil, nil, "float")
end, { desc = "Toggle floating terminal (terminal mode)" })
