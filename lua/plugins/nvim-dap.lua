return {
    "mfussenegger/nvim-dap",
    dependencies = {
        --ui plugins to make debugging nicer
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        -- gain access to the dap plugin
        local dap = require("dap")
        -- gain access to the dap ui pluing
        local dapui = require("dapui")

        -- setup the dap ui with default configuration
        dapui.setup()

        -- setup an event listener for when debugger is launched
        dap.listeners.before.launch.dapui_config = function()
            -- when the debugger is launched open up debug ui
            dapui.open()
        end

        -- create breakpoint
        vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
        -- resume execution
        vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
        -- close debug ui
        vim.keymap.set("n", "<leader.dc", dap.close, { desc = "[D]ebug [C]close" })
    end
}
