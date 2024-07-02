-- https://github.com/crivotz/nv-ide
-- keymaps.lua :
-- vim.keymap.set('n', '<leader>nn', ':lua NewNote()<CR>', { noremap = true, silent = true })

function NewNote()
  vim.ui.input({ prompt = 'Name: ', relative = 'editor' }, function(name)
    -- local date1 = strftime('date: %Y-%mM-%d %H:%M:%S', localtime())
    -- local date1 = strftime('%Y-%mM-%d_%H_%M', localtime())

    local date1 = vim.fn.strftime('%Y_%mM_%d-%Hh%M', vim.fn.localtime())
    -- vim.api.nvim_command(':e ~/Documents/Notes/' .. date1 .. '_' .. name .. '.txt')
    vim.api.nvim_command(':e ~/Documents/' .. date1 .. '-' .. name .. '.txt')

    -- https://vi.stackexchange.com/questions/21825/how-to-insert-text-from-a-variable-at-current-cursor-position
    -- execute "normal ixxx\<Esc>"
    vim.cmd [[
        normal 35o
        normal gg
        let date2 = strftime('%Y-%mM-%d %Hh%M', localtime())
        call setline(1, date2)
        call setline(2, '------------------------------------------------------------')
        normal 5j

        let line = '------------------------------------------------------------'
        let cur_line_num = line('.')
        call setline(cur_line_num, line)
        call setline(cur_line_num + 1, "WWMS:")

        call setline(cur_line_num + 5, line)
        call setline(cur_line_num + 6, "FO_TR")

        call setline(cur_line_num + 14, line)
        call setline(cur_line_num + 15, "DIS:")

        call setline(cur_line_num + 19, line)
        call setline(cur_line_num + 20, "PORT:")

        call setline(cur_line_num + 24, line)
        normal gg
        normal 2j
      ]]
  end)
end
