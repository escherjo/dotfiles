return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot", "codecompanion" },
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    },
  },
}
