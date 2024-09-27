-- local on_attach = function(client, bufnr)
-- 	vim.g.completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']"
--
-- 	local function buf_set_option(...)
-- 		vim.api.nvim_buf_set_option(bufnr, ...)
-- 	end
--
-- 	-- Enable completion triggered by <c-x><c-o>
-- 	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
--
-- end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").clangd.setup({
	capabilities = capabilities,
	-- on_attach = on_attach,
})
local function setup_clangd()
	require("lspconfig").clangd.setup({
		capabilities = capabilities,
		-- on_attach = on_attach,
	})
end

return {
	setup_clangd = setup_clangd,
}
