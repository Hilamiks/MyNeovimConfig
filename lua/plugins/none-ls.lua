return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "nvimtools/none-ls-extras.nvim",
    },
    config = function()
        -- get acces to the none-ls function
        local null_ls = require("null-ls")
        -- run the setup function for the none-ls to setup formatters
        null_ls.setup({
            sources = {
                -- setup lua formatter
                null_ls.builtins.formatting.stylua,
                -- setup js linter
                require("none-ls.diagnostics.eslint_d"),
                -- setup prettier to format languages that are not lua
                null_ls.builtins.formatting.prettier
            }
        })

        -- format code
        vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "[C]ode [F]ormat" })
    end
}
