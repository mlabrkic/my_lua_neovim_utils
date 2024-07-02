-- date: 2024-07M-02 17:36:19
------------------------------------------------------------
-- init.lua :

-- require 'custom.util.new_note_tr_mp'
-- require 'custom.util.new_note_tr_a'

-- require 'custom.util.insert_opc_sc_apc' -- mlabrkic

------------------------------------------------------------
-- keymaps.lua :
-- vim.keymap.set('n', '<leader>nnm', ':lua NewNote_TR_MP()<CR>', { noremap = true, silent = true }) -- MP
-- vim.keymap.set('n', '<leader>nna', ':lua NewNote_TR_A()<CR>', { noremap = true, silent = true }) -- Activa

-- vim.keymap.set('n', '<leader>nnia', ':lua Insert_opc_sc_apc()<CR>', { noremap = true, silent = true }) -- Insert OPC: SC, APC

------------------------------------------------------------

function Insert_opc_sc_apc()
  -- local A = vim.api

  local userHOME = vim.fn.getenv 'userprofile'
  local filename = userHOME .. '/Documents/PREDLOSCI/TR_note_template/OPC_SC_APC.txt' -- OPC: SC, APC
  filename = vim.fs.normalize(filename)

  vim.api.nvim_command(':r ' .. filename) -- read my TR_note_template.txt (my daily job)
  -- (at the end are the SAP codes, ...)
  -- vim.api.nvim_command 'normal 3j' -- move 3 lines down
end
