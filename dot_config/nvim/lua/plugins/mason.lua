---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "gopls",
        "ruff",
        "ty",
        "typescript-language-server",
        "oxlint",
        "bash-language-server",

        "stylua",
        "prettier",
        "shellcheck",
        "shfmt",

        "tree-sitter-cli",
      },
    },
  },
}
