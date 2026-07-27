return {
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<C-p>"] = {
            function() require("snacks.picker").commands() end,
            desc = "Command Palette",
          },
        },
      },
    },
  },
}
