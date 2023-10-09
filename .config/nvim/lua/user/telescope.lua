-- Configuration for the nvim-treesitter plugin, used by telescope.nvim.
require("nvim-treesitter.configs").setup(
  {
    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
    auto_install = true,
    -- Consistent syntax highlighting.
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    -- Incremental selection based on the named nodes from the grammar.
    incremental_selection = {
      enable = true,
    },
    -- Indentation based on treesitter for the = operator.
    indent = {
      enable = true
    },
  }
)

-- Configuration for the telescope plugin.
require("telescope").setup(
  {
    defaults = {
      mappings = {
        i = {
          ["<C-n>"] = "cycle_history_next",
          ["<C-p>"] = "cycle_history_prev",
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        }
      }
    },
  }
)

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function() builtin.find_files({ hidden = true }) end, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fG", builtin.grep_string, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Configuration for the telescope-fzy-native.nvim.
require("telescope").load_extension("fzy_native")
