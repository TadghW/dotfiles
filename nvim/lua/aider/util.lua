---@class AiderUtil
local M = {}

---Minimal logger used by aider.file_watcher.
---@param message string
---@param level? string
function M.log(message, level)
  if vim.g.aider_file_watcher_debug then
    vim.notify(message, vim.log.levels[level or "INFO"] or vim.log.levels.INFO)
  end
end

return M
