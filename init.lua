-- Declare the path where lazy will clone plugin code
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Check to see if lazy itself has been cloned, if not clone it into the lazy.nvim directory
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath
    })
end

-- add the path to the lazy plugin repositories to the vim runtime path
vim.opt.rtp:prepend(lazypath)

-- Declare a few options for lazy
local opts = {
    change_detection = {
        -- don't notify us every time a change is made to the config
        notify = false
    },
    checker = {
        -- automatically check for package updates
        enabled = true,
        -- don't spam us with notification severy time there is an update available
        notify = false
    }
}


-- Load the options (visual mostly)
require("config.options")
-- Load keymaps
require("config.keymaps")

-- setup lazy, this should always be last
-- tell lazy that all plugin specs are found in the plugins directory
-- pass it the options we specified above
require("lazy").setup("plugins", opts)
