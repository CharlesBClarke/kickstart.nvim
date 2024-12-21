local M = {}

local function safe_split(vertical)
  if vertical then
    -- Vertical split
    vim.api.nvim_set_option_value('winfixwidth', true, { scope = 'local', win = 0 })
    vim.cmd 'vsplit'
    vim.api.nvim_set_option_value('winfixwidth', false, { scope = 'local', win = 0 })
  else
    -- Horizontal split
    vim.api.nvim_set_option_value('winfixheight', true, { scope = 'local', win = 0 })
    vim.cmd 'split'
    vim.api.nvim_set_option_value('winfixheight', false, { scope = 'local', win = 0 })
  end
end

--- Get all normal windows in an ordered list.
--- By default, `nvim_list_wins()` returns windows in an internal order,
--- which may or may not match physical layout order. But we’ll just rely
--- on the returned order here.
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

--- Adds a new buffer to the first window, shifts all buffers down,
--- and splits the last window with the last original buffer.
function M.add_new_and_shift()
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

  -- 3. Create a new (unnamed) buffer
  local new_buf = vim.api.nvim_create_buf(false, true) -- (listed=false, scratch=true)
  if not new_buf then
    vim.notify('Failed to create new buffer!', vim.log.levels.ERROR)
    return
  end

  -- 4. Put the new buffer in the first window
  vim.api.nvim_win_set_buf(normal_wins[1], new_buf)

  -- 5. Shift buffers down (do it backwards to avoid overwriting)
  for i = #normal_wins, 2, -1 do
    vim.api.nvim_win_set_buf(normal_wins[i], old_bufs[i - 1])
  end

  -- 6. Split the last window and assign the last original buffer
  local last_win = normal_wins[#normal_wins]
  -- Make `last_win` the current window so `:split` happens there
  vim.api.nvim_set_current_win(last_win)

  if #normal_wins % 2 == 0 then
    safe_split(false) -- creates a new window above/below (depends on 'splitbelow')
  else
    safe_split(true) -- creates a new window above/below (depends on 'splitbelow')
  end
  local new_split_win = vim.api.nvim_get_current_win()

  -- The buffer that was originally in the last window
  local last_original_buf = old_bufs[#normal_wins]

  -- Assign that last buffer to this new window
  vim.api.nvim_win_set_buf(new_split_win, last_original_buf)

  vim.notify 'New buffer placed in first window, others shifted down, last window split!'
end

return M
