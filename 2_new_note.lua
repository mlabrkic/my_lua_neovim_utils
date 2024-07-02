-- REF:
-- https://github.com/crivotz/nv-ide
-- https://www.davekuhlman.org/nvim-lua-info-notes.html

-- https://github.com/mlabrkic/neovim-lua-example-scripts
-- opt02_nvim-opt-surv_gr.lua

------------------------------------------------------------
-- keymaps.lua :
-- vim.keymap.set('n', '<leader>nn', ':lua NewNote_TR()<CR>', { noremap = true, silent = true })

function NewNote_TR()
  local A = vim.api

  -- nvim_create_buf({listed}, {scratch})
  local bufnr = A.nvim_create_buf(true, false)

  -- A.nvim_buf_set_option(bufnr, 'buftype', '')  -- deprecated, Nvim v0.10.0
  -- nvim_set_option_value({name}, {value}, {opts})
  A.nvim_set_option_value('buftype', '', { buf = bufnr }) -- set buftype="" (because I want to save the file)

  local date1 = vim.fn.strftime('%Y_%mM_%d-%Hh%M', vim.fn.localtime())

  vim.ui.input({ prompt = 'Name: ', relative = 'editor' }, function(name)
    -- A.nvim_buf_set_name(bufnr, 'note1.txt')
    local bufName = date1 .. '-' .. name .. '.txt'
    A.nvim_buf_set_name(bufnr, bufName) -- Assign a name to the new buffer
  end)

  -- local lines = {}
  local date2 = os.date('date: %Y_%mM_%d %H:%M:%S', vim.fn.localtime())
  local lines = { date2 }

  local lines_template_tr = {}
  table.insert(lines_template_tr, '--- TR Start ---')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '------------------------------------------------------------')
  table.insert(lines_template_tr, 'MAIL:')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '------------------------------------------------------------')
  table.insert(lines_template_tr, 'WWMS:')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '------------------------------------------------------------')
  table.insert(lines_template_tr, 'FO_TR:')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '------------------------------------------------------------')
  table.insert(lines_template_tr, 'DIS:')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '------------------------------------------------------------')
  table.insert(lines_template_tr, 'PORT:')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '------------------------------------------------------------')
  table.insert(lines_template_tr, 'WWMS ZABILJEŠKA:')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '------------------------------------------------------------')
  table.insert(lines_template_tr, '')
  table.insert(lines_template_tr, '')

  vim.list_extend(lines, lines_template_tr)

  table.insert(lines, '--- TR END ---')

  A.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
  A.nvim_set_current_buf(bufnr)

  -- vim.api.nvim_command(':r ' .. filename) -- read my TR_note_template.txt (my daily job)
  -- (at the end are the SAP codes, ...)
  vim.api.nvim_command 'normal 3j' -- move 3 lines down
end
