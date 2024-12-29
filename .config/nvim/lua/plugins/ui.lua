return {
    -- Dashboard plugin, disabled by default
    {
      "nvimdev/dashboard-nvim",
      enabled = false,  -- Dashboard plugin is disabled
    },
    
    -- Lualine configuration for status line
    {
      "nvim-lualine/lualine.nvim",
      enabled = true,  -- Lualine is enabled
    },
  
    -- Noice plugin configuration for enhanced message, cmdline, and popup menu
    {
      "folke/noice.nvim",
      opts = function(_, opts)
        -- Add a custom route to skip notifications with the message "No information available"
        table.insert(opts.routes, {
          filter = {
            event = "notify",
            find = "No information available",  -- Message to skip
          },
          opts = { skip = true },
        })
  
        -- Focus event handling to manage 'focused' state
        local focused = true
        vim.api.nvim_create_autocmd("FocusGained", {
          callback = function()
            focused = true
          end,
        })
        vim.api.nvim_create_autocmd("FocusLost", {
          callback = function()
            focused = false
          end,
        })
  
        -- Add a route that shows notifications only when the window is not focused
        table.insert(opts.routes, 1, {
          filter = {
            cond = function()
              return not focused
            end,
          },
          view = "notify_send",  -- Notification view when not focused
          opts = { stop = false },
        })
  
        -- Customize command behavior for message history when using `:Noice`
        opts.commands = {
          all = {
            view = "split",  -- Open message history in a split view
            opts = { enter = true, format = "details" },  -- Show details in the split view
            filter = {},  -- No additional filters for this command
          },
        }
  
        -- Enable LSP document border in the preset
        opts.presets.lsp_doc_border = true
      end,
    },
  
    -- nvim-notify configuration for notifications
    {
      "rcarriga/nvim-notify",
      opts = {
        timeout = 5000,  -- Timeout for notifications in milliseconds
        background_colour = "#000000",  -- Background color of notifications
        render = "wrapped-compact",  -- Rendering style for notifications
      },
    },
  
    -- Bufferline plugin configuration for managing buffers
    {
      "akinsho/bufferline.nvim",
      event = "VeryLazy",  -- Load the plugin lazily
      keys = {
        { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
        { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
      },
      opts = {
        options = {
          mode = "tabs",  -- Display buffers as tabs
          show_buffer_close_icons = false,  -- Don't show close icons on buffers
          show_close_icon = false,  -- Don't show the close icon on the bufferline
        },
      },
    },
  
    -- Incline plugin configuration for filename display
    {
      "b0o/incline.nvim",
      event = "BufReadPre",  -- Trigger this on buffer read
      priority = 1200,  -- Set priority for this plugin
      config = function()
        local helpers = require("incline.helpers")
        require("incline").setup({
          window = {
            padding = 0,  -- No padding in the window
            margin = { horizontal = 0 },  -- No horizontal margin
          },
          render = function(props)
            -- Render the filename with appropriate icons and colors
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
            local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
            local modified = vim.bo[props.buf].modified
            local buffer = {
              ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) }
                or "",
              " ",
              { filename, gui = modified and "bold,italic" or "bold" },
              " ",
              guibg = "#363944",  -- Background color of the buffer line
            }
            return buffer
          end,
        })
      end,
    },
  
    -- LazyGit plugin integration with Telescope
    {
      "kdheepak/lazygit.nvim",
      keys = {
        {
          ";c",
          ":LazyGit<Return>",  -- Keybinding to open LazyGit
          silent = true,
          noremap = true,
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",  -- Required dependency for LazyGit
      },
    },
  
    -- Database UI configuration with vim-dadbod
    {
      "kristijanhusak/vim-dadbod-ui",
      dependencies = {
        { "tpope/vim-dadbod", lazy = true },
        { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
      },
      cmd = {
        "DBUI",  -- Command to open the database UI
        "DBUIToggle",  -- Command to toggle the database UI
        "DBUIAddConnection",  -- Command to add a new database connection
        "DBUIFindBuffer",  -- Command to find a buffer in the database UI
      },
      init = function()
        -- Set configuration for database UI
        vim.g.db_ui_use_nerd_fonts = 1  -- Use nerd fonts in the UI
      end,
      keys = {
        {
          "<leader>d",
          "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",  -- Keybinding to open DBUI
        },
      },
    },
  
    -- Nvim Tree configuration for file exploration
    {
      "nvim-tree/nvim-tree.lua",
      config = function()
        require("nvim-tree").setup({
          on_attach = function(bufnr)
            local api = require("nvim-tree.api")
  
            local function opts(desc)
              return {
                desc = "nvim-tree: " .. desc,
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
              }
            end
  
            -- Default mappings for nvim-tree
            api.config.mappings.default_on_attach(bufnr)
  
            -- Custom mapping to open a file in a new tab
            vim.keymap.set("n", "t", api.node.open.tab, opts("Tab"))
          end,
          actions = {
            open_file = {
              quit_on_open = true,  -- Close NvimTree when opening a file
            },
          },
          sort = {
            sorter = "case_sensitive",  -- Sort files case-sensitively
          },
          view = {
            width = 30,  -- Set the width of the NvimTree panel
            relativenumber = true,  -- Enable relative numbers
          },
          renderer = {
            group_empty = true,  -- Group empty directories together
          },
          filters = {
            dotfiles = false,  -- Don't filter dotfiles
            custom = {
              "node_modules/.*",  -- Exclude node_modules from the file tree
            },
          },
          log = {
            enable = true,  -- Enable logging
            truncate = true,  -- Truncate logs if they get too large
            types = {
              diagnostics = true,  -- Enable logging for diagnostics
              git = true,  -- Enable logging for git events
              profile = true,  -- Enable profiling
              watcher = true,  -- Enable file watcher logging
            },
          },
        })
  
        -- If no arguments are passed to Neovim, focus on NvimTree
        if vim.fn.argc(-1) == 0 then
          vim.cmd("NvimTreeFocus")
        end
      end,
    },
  }
  