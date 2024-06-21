-- local keymapExpr = function(mode, key, result, desc)
--   vim.keymap.set(mode, key, result, { desc = desc, silent = true, expr = true })
-- end

-- keymapExpr('n', '<C-H>', [[':%s/\<' . expand('<cword>') . '\>//g<lt>Left><lt>Left>']])
-- keymapExpr('x', '<C-H>', [['y:%s/' . escape(@", "\\/.*'$^~[]") . '//g<lt>Left><lt>Left>']])

------------------------------------------------------------
-- keymaps.lua :
-- vim.keymap.set('x', '<leader>h', ':lua MyReplace()<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>h', ':lua MyReplaceN()<CR>', { noremap = true, silent = true })

-- h eval.txt

-- Visual mode:
-- h visual-mode
function MyReplace()
  -- h getpos()
  local spos = vim.fn.getpos "'<"
  -- :lua spos = vim.fn.getpos "'<"
  -- :lua print(spos)
  -- :lua print(spos[3])

  -- Debug:
  -- print(spos)
  -- print(spos[3])

  local epos = vim.fn.getpos "'>"
  -- :print(epos)
  -- :print(epos[3])

  -- h getline()
  local line = vim.fn.getline(spos[2])
  -- :lua line = vim.fn.getline(spos[2])
  -- :lua print(line)

  -- Debug:
  -- print(line)

  -- h string.sub
  local selection = string.sub(line, spos[3], epos[3])
  -- :lua selection = string.sub(line, spos[3], epos[3])
  -- :lua print(selection)

  -- Debug:
  -- print(selection)
  -- h escape()
  selection = vim.fn.escape(selection, "\\/.*'$^~[]")

  -- h vim.ui.input
  -- h command-completion
  vim.ui.input({
    prompt = 'Name: ',
    default = selection,
    -- completion = 'buffer',
    relative = 'editor',
  }, function(name)
    -- if name then
    --   print('You entered ' .. name)
    -- else
    --   print 'You cancelled'
    -- end

    -- h nvim_command()
    -- vim.api.nvim_command(':%s/' .. 'Fun_0' .. '/' .. name .. '/g')
    vim.api.nvim_command(':%s/' .. selection .. '/' .. name .. '/g')
  end)
end

-- Normal mode:
function MyReplaceN()
  local selection = vim.fn.expand '<cword>'

  -- h command-completion
  vim.ui.input({
    prompt = 'Name: ',
    default = selection,
    -- completion = 'buffer',
    relative = 'editor',
  }, function(name)
    vim.api.nvim_command(':%s/' .. selection .. '/' .. name .. '/g')
  end)
end
