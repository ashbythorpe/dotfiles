return {
	{
		"nvim-mini/mini.pairs",
		event = "VeryLazy",
		opts = {},
	},
	{
		"nvim-mini/mini.statusline",
		event = "VeryLazy",
		opts = {
			use_icon = true,
		},
	},
	{
		"nvim-mini/mini.icons",
		event = "VeryLazy",
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"nvim-mini/mini.surround",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
		keys = {
			{ "gsa", desc = "Add surrounding", mode = { "n", "v" } },
			{ "gsd", desc = "Delete Surrounding" },
			{ "gsf", desc = "Find Right Surrounding" },
			{ "gsF", desc = "Find Left Surrounding" },
			{ "gsh", desc = "Highlight Surrounding" },
			{ "gsr", desc = "Replace Surrounding" },
			{ "gsn", desc = "Update `MiniSurround.config.n_lines`" },
		},
	},
	{
		"nvim-mini/mini.diff",
		event = "VeryLazy",
		keys = {
			{
				"<leader>go",
				function()
					require("mini.diff").toggle_overlay(0)
				end,
				desc = "Toggle mini.diff overlay",
			},
		},
		opts = {
			view = {
				style = "sign",
			},
		},
	},
	{
		"nvim-mini/mini.ai",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
					d = { "%f[%d]%d+" }, -- digits
					e = { -- Word with case
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					u = ai.gen_spec.function_call(), -- u for "Usage"
					U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
				},
			}
		end,
	},
	{
		"nvim-mini/mini.files",
		opts = {
			mappings = {
				go_in_plus = "<CR>",
				go_in = "",
				go_out = "-",
				go_out_plus = "",
			},
		},
		init = function()
			local show_dotfiles = true

			local filter_show = function(_)
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				MiniFiles.refresh({ content = { filter = new_filter } })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					-- Tweak left-hand side of mapping to your liking
					vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id })
				end,
			})
		end,
		keys = {
			{
				"-",
				function()
					MiniFiles.open(vim.api.nvim_buf_get_name(0))
				end,
				desc = "Open mini.files",
			},
		},
	},
}
