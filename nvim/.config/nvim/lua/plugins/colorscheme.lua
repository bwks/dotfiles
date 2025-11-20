return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- ensures theme loads first
  },
  {
    "shaunsingh/nord.nvim",
    priority = 1000,
  },
  -- Rose Pine
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
  },
  -- Nightfox
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
  },
  -- One Dark
  {
    "navarasu/onedark.nvim",
    priority = 1000,
  },
  -- Solarized
  {
    "ishan9299/nvim-solarized-lua",
    priority = 1000,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    -- lazy = false, -- <--- This forces it to load at startup!
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Or your preferred flavor
      })
      -- vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local scheme = vim.env.NVIM_COLOURSCHEME or "catppuccin"
        -- fallback/default is gruvbox
        vim.cmd.colorscheme(scheme)
      end,
    },
    priority = 1001,
  },
}
