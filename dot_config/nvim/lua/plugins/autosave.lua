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

              if
                vim.api.nvim_buf_get_name(buf) ~= ""
                and vim.bo[buf].modifiable
                and vim.bo[buf].buftype == ""
                and vim.bo[buf].modified
              then
                vim.api.nvim_buf_call(buf, function() vim.cmd "silent update" end)
              end
            end,
          },
        },
      },
    },
  },
}
