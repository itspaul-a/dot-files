return {
	{
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
	local dap = require("dap")
	local dapui = require("dapui")

	dap.listeners.before.attach.dapui_config = function()
	  dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
	  dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
	  dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
	  dapui.close()
	end
	dap.adapters.codelldb = {
			 name = "codelldb server",
   			 type = 'server',
   			 port = "${port}",
   			 executable = {
			 command = vim.fn.stdpath("data") .. '/mason/bin/codelldb',
   			 args = { "--port", "${port}" },
			 }
		}
	dap.configurations.cpp = {
            {
                name = "Launch",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {},
                runInTerminal = true,
            }
        }
	vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, {})
	vim.keymap.set('n', '<leader>dc', dap.continue, {})
	end,
	},
	{
		{
			"julianolf/nvim-dap-lldb",
   			dependencies = { "mfussenegger/nvim-dap" },

		}
	}
}
