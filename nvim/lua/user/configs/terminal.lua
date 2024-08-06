function OpenOrCreateTerm()
	local terminal_buffers = {}

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[bufnr].buftype == "terminal" then
			table.insert(terminal_buffers, bufnr)
		end
	end

	if #terminal_buffers > 0 then
		-- Sort the terminal buffers by their last used time
		table.sort(terminal_buffers, function(a, b)
			return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
		end)
		vim.api.nvim_set_current_buf(terminal_buffers[1])
	else
		vim.cmd("term")
		vim.cmd("startinsert")
	end
end

function CycleTerminals(direction)
	local terminal_buffers = {}
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[bufnr].buftype == "terminal" then
			table.insert(terminal_buffers, bufnr)
		end
	end

	if #terminal_buffers == 0 then
		vim.cmd("term")

		return
	end

	local current_bufnr = vim.api.nvim_get_current_buf()
	local current_index = nil

	for i, bufnr in ipairs(terminal_buffers) do
		if bufnr == current_bufnr then
			current_index = i
			break
		end
	end

	local next_index
	if current_index then
		next_index = (current_index + direction - 1) % #terminal_buffers + 1
	else
		next_index = 1
	end

	vim.api.nvim_set_current_buf(terminal_buffers[next_index])
end
