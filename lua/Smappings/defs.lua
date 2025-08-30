return function(mm)
  -- Colemak (mode = '')
  mm.add('colemak', '', 'n', 'j')
  mm.add('colemak', '', 'N', 'J')
  mm.add('colemak', '', 'e', 'k')
  mm.add('colemak', '', 'E', 'K')
  mm.add('colemak', '', 'i', 'l')
  mm.add('colemak', '', 'I', 'L')
  mm.add('colemak', '', 'm', 'h')
  mm.add('colemak', '', 'M', 'H')

  mm.add('colemak', '', 'j', 'm')
  mm.add('colemak', '', 'J', 'M')
  mm.add('colemak', '', 'k', 'n')
  mm.add('colemak', '', 'K', 'N')
  mm.add('colemak', '', 't', 'i')
  mm.add('colemak', '', 'T', 'I')
  mm.add('colemak', '', 'h', 'e')
  mm.add('colemak', '', 'H', 'E')
  mm.add('colemak', '', 'l', 't')
  mm.add('colemak', '', 'L', 'T')

  -- windows
  mm.add('colemak', '', '<C-w>n', '<C-w>j')
  mm.add('colemak', '', '<C-w>e', '<C-w>k')
  mm.add('colemak', '', '<C-w>i', '<C-w>l')
  mm.add('colemak', '', '<C-w>m', '<C-w>h')

  -- resize
  mm.add('colemak', '', '<C-w>J', '<C-w>-')
  mm.add('colemak', '', '<C-w>E', '<C-w>+')
  mm.add('colemak', '', '<C-w>I', '<C-w>>')
  mm.add('colemak', '', '<C-w>M', '<C-w><')

  -- swap
  mm.add('colemak', '', '<C-w><C-n>', '<C-w>K')
  mm.add('colemak', '', '<C-w><C-e>', '<C-w>J')
  mm.add('colemak', '', '<C-w><C-i>', '<C-w>L')
  mm.add('colemak', '', '<C-w><C-m>', '<C-w>H')

  -- QWERTY: keep empty; switching clears these.
end
