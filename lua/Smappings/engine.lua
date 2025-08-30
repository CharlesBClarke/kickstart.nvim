-- minimal layout switcher (no 'both'), global-only
local M = {}

local map, del = vim.keymap.set, vim.keymap.del
local OPTS = { noremap = true, silent = true }

local R = { colemak = {}, qwerty = {} } -- registries
local applied = {} -- what this module set last time

function M.add(layout, mode, lhs, rhs, opts)
  if layout ~= 'colemak' and layout ~= 'qwerty' then
    error 'layout must be colemak|qwerty'
  end
  table.insert(R[layout], { mode, lhs, rhs, opts or OPTS })
end

local function clear_layout()
  for i = #applied, 1, -1 do
    local mode, lhs = applied[i][1], applied[i][2]
    pcall(del, mode, lhs)
    applied[i] = nil
  end
end

local function apply_list(list)
  for _, m in ipairs(list or {}) do
    map(m[1], m[2], m[3], m[4])
    table.insert(applied, { m[1], m[2] })
  end
end

function M.set_layout(layout)
  if layout ~= 'colemak' and layout ~= 'qwerty' then
    vim.notify('invalid layout: ' .. tostring(layout), vim.log.levels.ERROR)
    return
  end
  clear_layout()
  apply_list(R[layout])
  M.layout = layout
  vim.notify('layout: ' .. layout)
end

function M.toggle()
  M.set_layout((M.layout == 'colemak') and 'qwerty' or 'colemak')
end

function M.setup(opts)
  opts = opts or {}
  M.layout = (vim.g.keylayout == 'qwerty' or vim.env.NVIM_QWERTY == '1') and 'qwerty' or (opts.default or 'colemak')
  vim.api.nvim_create_user_command('KeyLayout', function(a)
    M.set_layout(a.args)
  end, {
    nargs = 1,
    complete = function()
      return { 'colemak', 'qwerty' }
    end,
  })
  vim.api.nvim_create_user_command('ToggleLayout', function()
    M.toggle()
  end, {})
  M.set_layout(M.layout)
end

return M
