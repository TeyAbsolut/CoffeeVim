return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", "nvim-neotest/nvim-nio" },
        config = function()
            local dap = require("dap")
            dap.configurations.java = {
                {
                    type = "java",
                    request = "attach",
                    name = "Attach to Server",
                    hostName = "127.0.0.1",
                    port = 5005,
                },
            }

            local dap_python = require('dap-python')

            dap_python.setup("python")

            dap.configurations.python = {
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch file',
                    program = '${file}',
                    pythonPath = function()
                        -- Try to detect virtual environment
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                            return cwd .. '/venv/bin/python'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return '/usr/bin/python'
                        end
                    end,
                },
                {
                    type = 'python',
                    request = 'launch',
                    name = 'Launch file with arguments',
                    program = '${file}',
                    args = function()
                        local args_string = vim.fn.input('Arguments: ')
                        return vim.split(args_string, ' ')
                    end,
                    pythonPath = function()
                        local cwd = vim.fn.getcwd()
                        if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
                            return cwd .. '/venv/bin/python'
                        elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
                            return cwd .. '/.venv/bin/python'
                        else
                            return '/usr/bin/python'
                        end
                    end,
                },
            }

            -- DAP UI setup
            local dapui = require("dapui")
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
}
