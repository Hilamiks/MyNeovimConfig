vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'config.jdtls'.setup_jdtls()
    augroup end
]]

vim.cmd [[
    augroup clangd_cpp_lsp
        autocmd!
        autocmd FileType cpp lua require'config.clangd'.setup_clangd({})
    augroup end
]]

vim.cmd [[
    augroup clangd_c_lsp
        autocmd!
        autocmd FileType c lua require'config.clangd'.setup_clangd()
    augroup end
]]
