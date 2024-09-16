return {
    -- Shorteneed Github Url
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "dracula"
    end
}
