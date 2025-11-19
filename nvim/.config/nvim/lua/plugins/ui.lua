return {
  {
    "nvim-mini/mini.animate",
    opts = {
      scroll = { enabled = false },
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        float_opts = {
          border = "curved",
        },
      })
    end,
  },
}
