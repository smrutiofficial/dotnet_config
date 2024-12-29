return {
    -- Treesitter configuration plugin
    {
      -- Plugin repository
      "nvim-treesitter/nvim-treesitter",
      -- Specific version to ensure stability
      tag = "v0.9.1",
      opts = {
        -- Define a list of languages for Treesitter to install and use
        ensure_installed = {
          "javascript",    -- JavaScript support
          "typescript",    -- TypeScript support
          "css",           -- CSS support
          "gitignore",     -- Gitignore syntax highlighting
          "graphql",       -- GraphQL support
          "http",          -- HTTP configuration files support
          "json",          -- JSON syntax highlighting
          "scss",          -- SCSS (Sass) support
          "sql",           -- SQL support
          "vim",           -- Vim configuration support
          "lua",           -- Lua support
          "dart",          -- Dart support (added for Flutter development)
          "java",          -- Java support (added for Java development)
        },
        -- Configuration for query linter (syntax checker)
        query_linter = {
          enable = true,             -- Enable query linter
          use_virtual_text = true,   -- Use virtual text for displaying errors
          lint_events = {            -- Specify events for linting
            "BufWrite",              -- Trigger linting on buffer write
            "CursorHold",            -- Trigger linting when cursor is idle
          },
        },
      },
    },
  }
  