return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
    opts = {
      opts = {
        log_level = "DEBUG", -- oder "TRACE"
      },
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_tools = true,
            show_server_tools_in_chat = true,
            add_mcp_prefix_to_tool_names = false,
            show_result_in_chat = true,
            make_vars = true,
            make_slash_commands = true,
          },
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      require("mcphub").setup({
        use_bundled_binary = true, -- Use local `mcp-hub` binary
        extensions = {
          copilotchat = {
            enabled = true,
            convert_tools_to_functions = true, -- Convert MCP tools to CopilotChat functions
            convert_resources_to_functions = true, -- Convert MCP resources to CopilotChat functions
            add_mcp_prefix = false, -- Add "mcp_" prefix to function names
          },
          codecompanion = {
            enabled = true,
          },
        },
      })
    end,
  },
}
