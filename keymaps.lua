--[[
init.lua
Basic Keymaps

help mapleader
The default leader key is backslash( \ ).
Set "space" as the leader key

------------------------------
https://vim.fandom.com/wiki/Mappings
https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2)

:
h keycodes
verbose nmap š
h CTRL-L

echo mapcheck(';g', 'n')

------------------------------------------------------------
https://github.com/nanotee/nvim-lua-guide#vimkeymap
h vim.keymap.set()
h :map-arguments

vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set({mode}, {lhs}, {rhs}, {opts})

{opts} this must be a lua table.
Default options {opts}: {remap = false, silent = false, expr = false}
]]

------------------------------------------------------------
vim.keymap.set("n", "<leader>nn", ":lua NewNote_TR()<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>h", ":lua MyReplaceN()<CR>", { noremap = true, silent = true })
vim.keymap.set("x", "<leader>h", ":lua MyReplace()<CR>", { noremap = true, silent = true })

------------------------------------------------------------
