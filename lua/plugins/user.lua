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
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
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
        acp = {
          gemini_cli = function()
            return require("codecompanion.adapters").extend("gemini_cli", {
              commands = {
                default = {
                  "gemini",
                  "--experimental-acp",
                },
              },
              defaults = {
                auth_method = "gemini-api-key",
                timeout = 20000, -- 20 seconds
              },
              env = {
                GEMINI_API_KEY = "GEMINI_API_KEY",
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = "gemini_cli" },
        inline = { adapter = "gemini" },
        agent = { adapter = "gemini_cli" },
      },
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.4,
          },
          show_settings = true,
          show_token_count = true,
        },
      },
    },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
      { "<leader>ac", ":<C-u>CodeCompanion", mode = { "v" }, desc = "CodeCompanion" },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown", "codecompanion" },
    opts = {
      render_modes = { "n", "c", "t" },
      file_types = { "markdown", "codecompanion" },
    },
  },
}
