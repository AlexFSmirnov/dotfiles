require("user.utils.buffer-cycle")
require("user.utils.terminal-cycle")

function CycleBuffers(direction)
  local current_bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[current_bufnr].buftype == "terminal" then
    CycleTerminals(direction)
  else
    SaveBufferCycleState()
    CycleTextBuffers(direction)
  end
end
