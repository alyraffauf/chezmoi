return {
  {
    "AstroNvim/astrocore",
    opts = {
      options = {
        opt = {
          updatetime = 1000,
        },
      },

      autocmds = {
        autosave = {
          {
            event = { "InsertLeave", "CursorHold", "CursorHoldI" },
            callback = function(args)
              local buf = args.buf

              if vim.bo[buf].modifiable and vim.bo[buf].buftype == "" and vim.bo[buf].modified then
                vim.cmd "silent update"
              end
            end,
          },
        },
      },
    },
  },
}
