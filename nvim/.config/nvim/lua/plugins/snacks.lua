return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false,
      animate = {
        duration = { step = 1, total = 10 },
        easing = "linear",
        fps = 60,
      },
      -- faster animation when repeating scroll after delay
      animate_repeat = {
        delay = 50, -- delay in ms before using the repeat animation
        duration = { step = 3, total = 20 },
        easing = "linear",
      },
    },
  },
}
