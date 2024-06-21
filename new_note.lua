-- https://www.davekuhlman.org/nvim-lua-info-notes.html

-- https://github.com/mlabrkic/neovim-lua-example-scripts
-- opt02_nvim-opt-surv_gr.lua

------------------------------------------------------------
-- keymaps.lua
-- vim.keymap.set('n', '<leader>nn', ':lua NewNote_TR()<CR>', { noremap = true, silent = true })

function NewNote_TR()
	local A = vim.api

	local userHOME = vim.fn.getenv("userprofile")
	local filename = userHOME .. "/Documents/PREDLOSCI/TR_note_template.txt" -- my daily job
	filename = vim.fs.normalize(filename)

	-- nvim_create_buf({listed}, {scratch})
	local bufnr = A.nvim_create_buf(true, false)

	-- A.nvim_buf_set_option(bufnr, 'buftype', '')  -- deprecated, Nvim v0.10.0
	-- nvim_set_option_value({name}, {value}, {opts})
	A.nvim_set_option_value("buftype", "", { buf = bufnr }) -- set buftype="" (because I want to save the file)

	local date1 = vim.fn.strftime("%Y_%mM_%d-%Hh%M", vim.fn.localtime())

	vim.ui.input({ prompt = "Name: ", relative = "editor" }, function(name)
		-- vim.api.nvim_command(":e ~/Documents/" .. date1 .. "-" .. name .. ".txt")

		-- A.nvim_buf_set_name(bufnr, 'note1.txt')
		local bufName = date1 .. "-" .. name .. ".txt"
		A.nvim_buf_set_name(bufnr, bufName) -- Assign a name to the new buffer
	end)

	-- Start creating output lines
	-- local lines = { '---Start---' }
	-- ...
	-- table.insert(lines, '---END---')

	local date2 = os.date("date: %Y_%mM_%d %H:%M:%S", vim.fn.localtime())
	local lines = { date2 }
	--[[
h nvim_buf_set_lines
]]
	A.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
	A.nvim_set_current_buf(bufnr)

	vim.api.nvim_command(":r " .. filename) -- read my TR_note_template.txt (my daily job)
	-- (at the end are the SAP codes, ...)
	vim.api.nvim_command("normal 3j") -- move 3 lines down
end
