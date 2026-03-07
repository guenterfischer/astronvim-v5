---@type LazySpec
return {
  {
    "svrana/neosolarized.nvim",
    dependencies = { "tjdevries/colorbuddy.nvim" },
    opts = {
      comment_italics = true,
      background_set = true,
    },
  },
  {
    -- See https://codecompanion.olimorris.dev/ for details
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = os.getenv "GEMINI_API_KEY",
            },
            schema = {
              model = {
                default = (os.getenv "GEMINI_MODEL" or "gemini-2.5-flash"),
              },
            },
          })
        end,
      },
      interactions = {
        chat = {
          adapter = "gemini",
          model = os.getenv "GEMINI_MODEL" or "gemini-2.5-flash",
        },
        inline = {
          adapter = "gemini",
          model = os.getenv "GEMINI_MODEL" or "gemini-2.5-flash",
        },
        cmd = {
          adapter = "gemini",
          model = os.getenv "GEMINI_MODEL" or "gemini-2.5-flash",
        },
        -- background = {
        --   adapter = "gemini",
        --   model = os.getenv "GEMINI_MODEL" or "gemini-2.5-flash",
        -- },
      },
    },
    keys = {
      -- Open a chat window
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>", desc = "CodeCompanion Chat" },
      -- Show actions
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
      -- Apply inline fix/generation (visual mode)
      { "<leader>ac", ":<C-u>CodeCompanion", mode = { "v" }, desc = "CodeCompanion" },
    },
  },
}
