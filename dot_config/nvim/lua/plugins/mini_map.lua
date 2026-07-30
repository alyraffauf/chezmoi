return {
  "nvim-mini/mini.map",
  version = false,
  event = "VeryLazy",
  keys = {
    {
      "<Leader>um",
      function() require("mini.map").toggle() end,
      desc = "Toggle minimap",
    },
    {
      "<Leader>uM",
      function() require("mini.map").toggle_focus() end,
      desc = "Focus minimap",
    },
  },
  config = function(_, opts)
    local mini_map = require "mini.map"

    opts.integrations = {
      mini_map.gen_integration.builtin_search(),
      mini_map.gen_integration.diagnostic(),
      mini_map.gen_integration.gitsigns(),
    }
    opts.window = {
      focusable = true,
      side = "right",
      width = 10,
      winblend = 25,
    }

    mini_map.setup(opts)
    mini_map.open()
  end,
}
