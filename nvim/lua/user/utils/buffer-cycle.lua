local buffer_cycle_state = {
  buffer_list = {},
  current_index = nil,
  cycle_state_valid = false,
}

vim.api.nvim_create_autocmd("TextChanged", {
  callback = function()
    buffer_cycle_state.cycle_state_valid = false
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    buffer_cycle_state.cycle_state_valid = false
  end,
})

-- Save the state of non-terminal buffers sorted by last used time
function SaveBufferCycleState()
  if buffer_cycle_state.cycle_state_valid then
    return
  end

  local buffers = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) and vim.bo[bufnr].buflisted and vim.bo[bufnr].buftype ~= "terminal" and vim.bo[bufnr].filetype ~= "NvimTree" then
      table.insert(buffers, bufnr)
    end
  end

  table.sort(buffers, function(a, b)
    return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
  end)

  buffer_cycle_state.buffer_list = buffers
  buffer_cycle_state.current_index = 1
  buffer_cycle_state.cycle_state_valid = true
end

-- Cycle through the saved buffer state in the given direction
function CycleTextBuffers(direction)
  if #buffer_cycle_state.buffer_list == 0 then
    return
  end

  local new_index = buffer_cycle_state.current_index + direction
  if new_index < 1 or new_index > #buffer_cycle_state.buffer_list then
    return
  end

  buffer_cycle_state.current_index = new_index

  local next_bufnr = buffer_cycle_state.buffer_list[buffer_cycle_state.current_index]
  if vim.api.nvim_buf_is_valid(next_bufnr) then
    vim.api.nvim_set_current_buf(next_bufnr)
  else
    print("Invalid buffer.")
  end
end
