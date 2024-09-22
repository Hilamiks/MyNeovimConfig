return {
    {
        "williamboman/mason.nvim",
        config = function()
            --setup mason with defautl properties
            require("mason").setup({
                ui = {
                    border = "rounded"
                }
            })
        end
    },
    -- mason lsp config utilizes mason to automaticallly
    -- ensure lsp servers youw ant installed
    -- are installed
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            --ensure that we have lua, ts, java
            --and java test server
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "ts_ls",
                    "jdtls",
                    "cssls",
                    "clangd"
                }
            })
        end
    },
    -- utility plugin for configuring the java language
    -- server
    {
        "mfussenegger/nvim-jdtls",
        dependencies = {
            "mfussenegger/nvim-dap",
            "ray-x/lsp_signature.nvim"
        }
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require "lsp_signature".setup()
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- get acccess to lspconfig
            -- pugins functions
            local lspconfig = require("lspconfig")

            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- setup lua language server
            lspconfig.lua_ls.setup({
                capabilities = capabilities
            })

            -- setup ts language server
            lspconfig.ts_ls.setup({
                capabilities = capabilities
            })

            vim.keymap.set("n", "<leader>ch", vim.lsp.buf.hover, { desc = "[C]ode [H]over Documentation" })
            vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode Goto [D]efinition" })
            vim.keymap.set({"n","v"}, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
            vim.keymap.set("n", "<leader>cr", require("telescope.builtin").lsp_references, { desc = "[C]ode Goto [R]eferences" })
            vim.keymap.set("n", "<leader>ci", require("telescope.builtin").lsp_implementations, { desc = "[C]ode Goto [I]mplementations" })
            vim.keymap.set("n", "<leader>cR", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
            vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode Goto [D]eclaration" })
        end
    }
}
