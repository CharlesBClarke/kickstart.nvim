return function(mm)
  -- Colemak movement
  mm.add('colemak', '', 'n', 'j')
  mm.add('colemak', '', 'e', 'k')
  mm.add('colemak', '', 'i', 'l')
  mm.add('colemak', '', 'M', 'H')

  -- QWERTY restore
  mm.add('qwerty', '', 'h', 'h')
  mm.add('qwerty', '', 'j', 'j')
  mm.add('qwerty', '', 'k', 'k')
  mm.add('qwerty', '', 'l', 'l')
end
