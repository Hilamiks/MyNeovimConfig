local function setup_cmake()
    require('lspconfig').cmake.setup({})
end

return {
	setup_cmake = setup_cmake,
}
