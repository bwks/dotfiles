return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false, -- <--- This forces it to load at startup!
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- Or your preferred flavor
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
