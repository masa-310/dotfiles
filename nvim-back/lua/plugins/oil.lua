return {
  "stevearc/oil.nvim",
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {"n", "<C-e>", "require('oil').open"},
  },
  config = function()
    require('oil').setup()
  end
}
