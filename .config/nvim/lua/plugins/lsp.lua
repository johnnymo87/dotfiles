-- LSP configuration with mason.nvim for automatic language server installation
return {
  -- Mason for installing and managing LSP servers
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("mason").setup()
    end,
  },

  -- LSP configuration (needed as dependency)
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },

  -- Bridge between mason and lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason-lspconfig").setup({
        -- Automatically install these language servers
        -- Based on 2025 recommendations from StackOverflow
        ensure_installed = {
          "lua_ls",        -- Lua (nvim config)
          "pyright",       -- Python (type checking)
          "ruff",          -- Python (linting/formatting)
          "ruby_lsp",      -- Ruby (Shopify, Rails-aware)
          "vtsls",         -- TypeScript/JavaScript (VS Code parity)
          "rust_analyzer", -- Rust
          "elixirls",      -- Elixir
          "jdtls",         -- Java
          "yamlls",        -- YAML (Kubernetes, CI/CD)
          "bashls",        -- Bash/Shell scripts
        },
      })

      -- Set up keymaps when LSP attaches to a buffer
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
        end

        -- Navigation
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "gr", vim.lsp.buf.references, "Go to references")
        map("n", "<leader>td", vim.lsp.buf.type_definition, "Go to type definition")

        -- Documentation
        map("n", "K", vim.lsp.buf.hover, "Show hover documentation")

        -- Code actions
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

        -- Diagnostics
        map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "<leader>e", vim.diagnostic.open_float, "Show diagnostic")
      end

      -- Get default capabilities with completion support
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure each language server using new vim.lsp.config API (Neovim 0.11+)
      -- ALL SERVERS DEFAULT TO OFF (autostart = false)
      -- Use :LspStart <server> to start on-demand

      -- Lua (with vim globals for nvim config)
      vim.lsp.config('lua_ls', {
        autostart = false,
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- Python
      vim.lsp.config('pyright', { autostart = false, on_attach = on_attach, capabilities = capabilities })
      vim.lsp.config('ruff', { autostart = false, on_attach = on_attach, capabilities = capabilities })

      -- Ruby (Shopify ruby-lsp with Rails support)
      vim.lsp.config('ruby_lsp', { autostart = false, on_attach = on_attach, capabilities = capabilities })

      -- TypeScript/JavaScript (vtsls for VS Code parity)
      vim.lsp.config('vtsls', { autostart = false, on_attach = on_attach, capabilities = capabilities })

      -- Rust
      vim.lsp.config('rust_analyzer', { autostart = false, on_attach = on_attach, capabilities = capabilities })

      -- Elixir
      vim.lsp.config('elixirls', { autostart = false, on_attach = on_attach, capabilities = capabilities })

      -- Java
      vim.lsp.config('jdtls', { autostart = false, on_attach = on_attach, capabilities = capabilities })

      -- YAML (Kubernetes, CI/CD configs)
      vim.lsp.config('yamlls', { autostart = false, on_attach = on_attach, capabilities = capabilities })

      -- Bash/Shell
      vim.lsp.config('bashls', { autostart = false, on_attach = on_attach, capabilities = capabilities })
    end,
  },

  -- Completion plugin (required by LSP)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP completion source
      "hrsh7th/cmp-buffer",    -- Buffer completion source
      "hrsh7th/cmp-path",      -- Path completion source
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
