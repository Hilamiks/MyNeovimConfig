local function get_jdtls()
    -- get mason registory to gain access to downloaded binaries
    local mason_registry = require("mason-registry")
    -- find the JDTLS package in the Mason Registry
    local jdtls = mason_registry.get_package("jdtls")
    -- find the full path to the directory where Mason has downloaded the JDTLS binaries
    local jdtls_path = jdtls:get_install_path()
    -- Obtain the path to the jar which runs the language server
    local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
    -- declare which operating system we are using
    local SYSTEM = "linux"
    -- obtain the path to configuartion files for your specific operating system
    local config = jdtls_path .. "/config_" .. SYSTEM
    -- obtain the path to the lomboc jar
    local lombok = jdtls_path .. "/lombok.jar"
    return launcher, config, lombok
end

local function get_bundles()
    -- get the Mason Registry to gain access to downloaded binaries
    local mason_registry = require("mason-registry")
    -- find the Java Debug Adapter package in the Mason Registry
    local java_debug = mason_registry.get_package("java-debug-adapter")
    -- opbtain the full path to the directory where Mason has downloaded the Java Debug Adapter binaries
    local java_debug_path = java_debug:get_install_path()

    local bundles = {
        vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", 1)
    }

    -- find the java test package in the mason registry
    local java_test = mason_registry.get_package("java_test")
    -- obtain the full patgh to the directory where mason has downloaded th Java test binaries
    local java_test_path = java_test:get_install_path()
    -- add all of the jars for running tests in debug mode to the bundles list
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar", 1), "\n"))
    return bundles
end

local function get_workspace()
    -- get the home directory of your OS
    local home = os.getenv "HOME"
    -- declare a directory where you would like to store project information
    local workspace_path = home .. "/code/workspace"
    -- determine the project name
    local project_name = vim.fn.fnamemodify(vim.fn.getcws(), ":p:h:t")
    -- create the workspace directory by concatenatin the designated workspace path and the project name
    local workspace_dir = workspace_path .. project_name
    return workspace_dir
end

local function java_keymaps()
    -- allow yourself to call JdtCompile as a Vim command
    vim.cmd("command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)")
    -- allow yourself/register to run JdtUpdateConfig as a Vim command
    vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
    -- allow yourself to run jdt bytecode
    vim.cmd("command! -buffer JdtBytecode lua require(jdtls).javap()")
    -- allow yourself/register to run JdtShell as Vim command
    vim.cmd("command! -buffer JdtShell lua require('jdtls').jshell()")

    -- set a vim motion to <Space> + <Shift>J + o to organize imports in normal mode
    vim.keymap.set('n', '<leader>Jo', "<Cmd> lua require('jdtls').organize_imports()<CR>", { desc = "[J]ava [O]rganize Imports" })
    -- set a vim motion to <Space> + <Shift>J + v to extract code under cursor into a variable
    vim.keymap.set('n', '<leader>Jv', "<Cmd> lua require('jdtls').extract_variable()<CR>", { desc = "[J]ava Exctract [V]ariable" })
    -- set a vim motion to <Space> + <Shift>J + v to extract code under cursor into a variable in visual mode
    vim.keymap.set('v', '<leader>Jv', "<Cmd> lua require('jdtls').organize_imports(true)<CR>", { desc = "[J]ava Extract [V]ariable" })
    -- set a vim motion to <Space> + <Shift>J + <Shift>C to extract code under cursor into a static variable
    vim.keymap.set('n', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant()<CR>", { desc = "[J]ava Exctract [C]onstant" })
    -- set a vim motion to <Space> + <Shift>J + <Shift>C to extract code under cursor into a static variable
    vim.keymap.set('v', '<leader>JC', "<Cmd> lua require('jdtls').extract_constant(true)<CR>", { desc = "[J]ava Exctract [C]onstant" })
    -- set a vim motion to <Space> + <Shift>J + t to run test method under the cursor
    vim.keymap.set('n', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method()<CR>", { desc = "[J]ava [T]est Method" })
    -- set a vim motion to <Space> + <Shift>J + t to run selected test method in visual mode
    vim.keymap.set('v', '<leader>Jt', "<Cmd> lua require('jdtls').test_nearest_method(true)<CR>", { desc = "[J]ava [T]est Method" })
    -- set a vim motion to <Space> + <Shift>J + <Shift>T to run entire test suite for class
    vim.keymap.set('n', '<leader>JT', "<Cmd> lua require('jdtls').test_class()<CR>", { desc = "[J]ava [T]est Class" })
    -- set a vim motion to <Space> + <Shift>J + u to update project configuration
    vim.keymap.set('n', '<leader>Ju', "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
end

local function() setup_jdts()
    -- set acces o the jdtls plugin and all of its functionality
    local jdtls = require "jdtls"

    -- get the paths to the jdtls jar, operating specific configuaration directory and lombok jar
    local launchar, os_config, lombok = get_jdtls()

    -- get the path you specified to hold project information
    local bundles = get_bundles()

    -- get the bundles list with the jars to the debug adapeter, and testing adapters
    local bundles = get_bundles()

    -- determine the root directory of the project by looking for theses specific markers
    local root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })

    -- tell our jdtls language features it is capable of
    local capabilities = {
        workspace = {
            configuration = true
        },
        textDocument = {
            completion = {
                snippetSupport = false
            }
        }
    }

    -- get the default extended client capabilities of the jdtls language server
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    -- modify one property called resolveAdditionalTextEditsSupport and set it to true
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

    -- set the command that starts the JDTLS language server jar
    

end



