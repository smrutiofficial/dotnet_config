-- Define Mason tools to be installed
local mason_tools = {
    "luacheck",
    "shellcheck",
    "shfmt",
    "emmet-language-server",
    "tailwindcss-language-server",
    "typescript-language-server",
    "css-lsp",
    "dart-debug-adapter", -- Dart Debugger
    "jdtls", -- Java LSP Server (jdtls)
}

-- Define LSP server configurations
local lsp_servers = {
    -- CSS language server
    cssls = {},
    -- Tailwind CSS language server
    tailwindcss = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
        end,
    },
    -- TypeScript server configuration
    tsserver = {
        root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
        end,
        single_file_support = false,
        settings = {
            typescript = {
                inlayHints = {
                    includeInlayParameterNameHints = "literal",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = false,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
            javascript = {
                inlayHints = {
                    includeInlayParameterNameHints = "all",
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                },
            },
        },
    },
    -- HTML language server
    html = {},
    -- Lua language server
    lua_ls = {
        single_file_support = true,
        settings = {
            Lua = {
                workspace = {
                    checkThirdParty = false,
                },
                completion = {
                    workspaceWord = true,
                    callSnippet = "Both",
                },
                misc = {
                    parameters = {},
                },
                hint = {
                    enable = true,
                    setType = false,
                    paramType = true,
                    paramName = "Disable",
                    semicolon = "Disable",
                    arrayIndex = "Disable",
                },
                doc = {
                    privateName = { "^_" },
                },
                type = {
                    castNumberToInteger = true,
                },
                diagnostics = {
                    disable = { "incomplete-signature-doc", "trailing-space" },
                    groupSeverity = {
                        strong = "Warning",
                        strict = "Warning",
                    },
                    groupFileStatus = {
                        ["ambiguity"] = "Opened",
                        ["await"] = "Opened",
                        ["codestyle"] = "None",
                        ["duplicate"] = "Opened",
                        ["global"] = "Opened",
                        ["luadoc"] = "Opened",
                        ["redefined"] = "Opened",
                        ["strict"] = "Opened",
                        ["strong"] = "Opened",
                        ["type-check"] = "Opened",
                        ["unbalanced"] = "Opened",
                        ["unused"] = "Opened",
                    },
                    unusedLocalExclude = { "_*" },
                },
                format = {
                    enable = false,
                    defaultConfig = {
                        indent_style = "space",
                        indent_size = "2",
                        continuation_indent_size = "2",
                    },
                },
            },
        },
    },
    -- Dart language server
    dartls = {
        on_attach = function(client, bufnr)
            local bufmap = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
            bufmap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
            bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
            bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        end,
    },
    -- Java language server (jdtls)
    jdtls = {
        root_dir = require("lspconfig.util").root_pattern(".git"),
        settings = {
            java = {
                format = {
                    enable = true,
                    settings = {
                        comments = {
                            lineComment = "//",
                            blockComment = { "/*", "*/" },
                        },
                        indentation = {
                            size = 4, -- Java indentation size
                        },
                    },
                },
            },
        },
        on_attach = function(client, bufnr)
            local bufmap = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end
            bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
            bufmap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
            bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
            bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        end,
    },
}

-- Define Emmet plugin configuration
local emmet_config = function()
    vim.g.user_emmet_leader_key = "<C-Z>"
    vim.cmd([[autocmd FileType html,css,javascriptreact,typescriptreact EmmetInstall]])
    vim.g.user_emmet_settings = {
        javascript = {
            extends = "jsx",
        },
        typescript = {
            extends = "tsx",
        },
    }
end

-- /////////////////////////////////////////////////////////////
-- ////////////////////////////////////////////////////////////
return {
    -- Mason tool installer configuration
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, mason_tools)
        end,
    },

    -- LSP server configurations
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = true },
            servers = lsp_servers,
            setup = {},
        },
    },

    -- Completion plugin with emoji support
    {
        "nvim-cmp",
        dependencies = { "hrsh7th/cmp-emoji" },
        opts = function(_, opts)
            table.insert(opts.sources, { name = "emoji" })
        end,
    },

    -- Emmet-vim plugin configuration
    {
        "mattn/emmet-vim",
        config = emmet_config,
    },

    -- Flutter tools plugin configuration
    {
        "akinsho/flutter-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "stevearc/dressing.nvim" },
        config = function()
            require("flutter-tools").setup {
                lsp = {
                    on_attach = function(client, bufnr)
                        local bufmap = function(mode, lhs, rhs, desc)
                            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                        end
                        bufmap("n", "gd", vim.lsp.buf.definition, "Go to Definition")
                        bufmap("n", "K", vim.lsp.buf.hover, "Hover Documentation")
                        bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
                        bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    end,
                },
                debugger = {
                    enabled = true,
                },
            }
        end,
    },
}
