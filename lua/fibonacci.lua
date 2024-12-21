local M = {}

local function half_split(vertical)
  if vertical then
    local current_win = vim.api.nvim_get_current_win()
    local current_height = vim.api.nvim_win_get_width(current_win)
    local new_height = math.floor(current_height * 0.5)

    vim.cmd(new_height .. 'vsplit')
    --local new_win = vim.api.nvim_get_current_win()
    --vim.api.nvim_win_set_width(new_win, new_width)
  else
    local current_win = vim.api.nvim_get_current_win()
    local current_width = vim.api.nvim_win_get_height(current_win)
    local new_width = math.floor(current_width * 0.5)

    vim.cmd(new_width .. 'split')
    local new_win = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_height(new_win, new_width)
  end
end

-- Get all normal windows in an ordered list.
-- (We rely on internal order from nvim_list_wins(); if you need a specific
-- layout order, you'd have to determine that separately.)
local function get_normal_windows()
  local normal_wins = {}
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    local conf = vim.api.nvim_win_get_config(win_id)
    if conf.relative == '' then
      table.insert(normal_wins, win_id)
    end
  end
  return normal_wins
end

--- Adds a new buffer (or opens a file) in the first window, shifts all buffers down,
--- and splits the last window with the last original buffer.
--- @param file_path string|nil Provide a path to open that file in the first window.
function M.add_new_and_shift(file_path)
  -- 1. Gather normal windows
  local normal_wins = get_normal_windows()
  if #normal_wins == 0 then
    vim.notify('No normal windows found!', vim.log.levels.ERROR)
    return
  end

  -- 2. Store each window's current buffer (before shifting)
  local old_bufs = {}
  for i, w in ipairs(normal_wins) do
    old_bufs[i] = vim.api.nvim_win_get_buf(w)
  end

  -- 3. In the first window, either create a new buffer or open the given file
  local new_buf
  if file_path and file_path ~= '' then
    -- Focus the first window
    vim.api.nvim_set_current_win(normal_wins[1])
    -- Edit the file in-place
    vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
    -- The opened file is now the buffer in the first window
    new_buf = vim.api.nvim_get_current_buf()
  else
    -- Create a new (unnamed) scratch buffer
    new_buf = vim.api.nvim_create_buf(false, true) -- (listed=false, scratch=true)
    if not new_buf then
      vim.notify('Failed to create new buffer!', vim.log.levels.ERROR)
      return
    end
    vim.api.nvim_win_set_buf(normal_wins[1], new_buf)
  end

  -- 4. Shift buffers down (do it backwards to avoid overwriting)
  for i = #normal_wins, 2, -1 do
    vim.api.nvim_win_set_buf(normal_wins[i], old_bufs[i - 1])
  end

  -- 5. Split the last window and assign the last original buffer
  local last_win = normal_wins[#normal_wins]
  -- Make `last_win` the current window so `:split` or `:vsplit` happens there
  vim.api.nvim_set_current_win(last_win)

  -- Decide between horizontal/vertical split based on the evenness of #normal_wins
  if #normal_wins % 2 == 0 then
    half_split(false) -- horizontal split
  else
    half_split(true) -- vertical split
  end

  local new_split_win = vim.api.nvim_get_current_win()
  -- The buffer that was originally in the last window
  local last_original_buf = old_bufs[#normal_wins]
  -- Assign that last buffer to this new window
  vim.api.nvim_win_set_buf(new_split_win, last_original_buf)

  vim.notify 'New buffer/file placed in first window, others shifted down, last window split!'
end

return M
