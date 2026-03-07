---@class AiderFileWatcher
local M = {}
local DEBOUNCE_MS = 3000
local util = require("aider.util")

local handles = {}
local processing_files = {}

local function watch_file()
  local uv = vim.uv
  local fullpath = vim.fn.expand("%:p")
  local relate_path = vim.fn.fnamemodify(fullpath, ":.")

  if not fullpath or fullpath == "" then
    return
  end

  -- Skip non-normal buffers.
  local bufnr = vim.fn.bufnr(fullpath)
  if bufnr == -1 or vim.bo[bufnr].buftype ~= "" then
    util.log("skip non-normal buffer: " .. fullpath, "DEBUG")
    return
  end

  util.log("start watching file: " .. relate_path)

  if handles[fullpath] then
    handles[fullpath]:close()
    util.log("stop watching file: " .. relate_path)
  end

  local handle = uv.new_fs_event()
  handle:start(fullpath, {
    recursive = false,
    stat = true,
    watch_entry = true,
  }, function(err, _, events)
    if err then
      vim.notify("Error watching file: " .. err, vim.log.levels.ERROR)
      handle:close()
      handles[fullpath] = nil
      return
    end

    util.log("File event detected for: " .. fullpath)

    local current_stat = vim.loop.fs_stat(fullpath)
    if not current_stat then
      util.log("Failed to get file stat for: " .. fullpath, "ERROR")
      return
    end

    if events.rename then
      util.log("File renamed or deleted: " .. fullpath)
      handle:close()
      handles[fullpath] = nil
      processing_files[fullpath] = nil
      return
    end

    vim.schedule(function()
      util.log("Change detected in file: " .. relate_path)

      local current_time = vim.loop.now()
      if processing_files[fullpath] and (current_time - processing_files[fullpath]) < DEBOUNCE_MS then
        util.log("Skipping due to debounce for: " .. relate_path, "DEBUG")
        return
      end

      processing_files[fullpath] = current_time

      local watched_bufnr = vim.fn.bufnr(fullpath)
      if watched_bufnr > 0 then
        vim.cmd(":e!")
        vim.notify(relate_path .. " changed from external", vim.log.levels.INFO)
      else
        util.log("Buffer not found for: " .. fullpath, "WARN")
      end
    end)
  end)

  handles[fullpath] = handle
  util.log("Watch handle created for: " .. relate_path)
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = watch_file,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*",
  callback = function()
    vim.defer_fn(function()
      watch_file()
    end, 100)
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  pattern = "*",
  callback = function()
    local filename = vim.fn.expand("<afile>:p")
    if handles[filename] then
      handles[filename]:close()
      handles[filename] = nil
      util.log("stop watching file: " .. filename)
    end
    processing_files[filename] = nil
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    local fullpath = vim.fn.expand("%:p")
    processing_files[fullpath] = nil
    watch_file()
  end,
})

return M
