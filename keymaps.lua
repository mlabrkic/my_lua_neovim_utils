-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

------------------------------------------------------------
--[[
https://vim.fandom.com/wiki/Mappings
https://vim.fandom.com/wiki/Mapping_keys_in_Vim_-_Tutorial_(Part_2)

:
h keycodes
h CTRL-L

verbose nmap š
echo mapcheck(';g', 'n')

]]
------------------------------------------------------------
--[[
https://github.com/nanotee/nvim-lua-guide#vimkeymap
h vim.keymap.set()
h :map-arguments

vim.keymap.set('n', '<space>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set({mode}, {lhs}, {rhs}, {opts})

{opts} this must be a lua table.
Default options {opts}: {remap = false, silent = false, expr = false}
]]

--[[
https://github.com/nvim-lua/kickstart.nvim
LSP settings.
We'll write a basic lua function that wraps vim.keymap.set()
]]
local keymap = function(mode, key, result, desc)
  -- if desc then
  --   desc = 'LSP: ' .. desc
  -- end
  -- vim.keymap.set(mode, key, result, {remap = false, silent = true, desc = desc})
  vim.keymap.set(mode, key, result, { desc = desc, silent = true })
end

local keymapExpr = function(mode, key, result, desc)
  vim.keymap.set(mode, key, result, { desc = desc, silent = true, expr = true })
end

local keymapRemap = function(mode, key, result, desc)
  -- vim.keymap.set(mode, key, result, {remap = true, silent = true, desc = desc})
  vim.keymap.set(mode, key, result, { desc = desc, remap = true })
end
--[[
mode - the editor mode for the mapping (e.g., i for "insert" mode).
key -  (lhs) the keybinding to detect
result -  (rhs) the command to execute
]]
------------------------------------------------------------
-- keyboard with Croatian characters

-- :verbose nmap š
keymapRemap("n", "š", "[", [[ Remap: 'š' -> '[' ]])
keymapRemap("n", "đ", "]", [[ Remap: 'đ' -> ']' ]])

-- :h /
keymapRemap("n", "č", ":", [[ Remap: 'č' -> ':' -- Enter command mode ]])
keymapRemap("n", "-", "/", [[ Remap: '-' -> '/' -- Search forward ]])

keymap("n", "ć", "<C-W>W", "Edit alternate window")

-- keymapRemap("n", "ž", "\\", [[ Remap: '-' -> '\' -- backslash ]]) -- :h \

------------------------------------------------------------
-- map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- keymapRemap("n", "<BS>", "<cmd>e #<cr>", "Switch to Other Buffer")
keymap("n", "<BS>", "<cmd>e #<cr>", "Switch to Other Buffer")

-- keymap("n", "<F12>", "<cmd>BufferLinePick<cr>", "select buffer")
keymap("n", "ž", "<cmd>BufferLinePick<cr>", "select buffer")

-- Switch to previous / next buffer
-- [b ]b

------------------------------------------------------------
-- Change current working directory locally and print cwd after that,
-- see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
-- :echo(expand("%:p:h"))
keymap(
  "n",
  -- "<leader>cd",
  "<localleader>d",
  "<cmd>cd %:p:h<cr><cmd>pwd<cr>",
  "Switch to the directory of the open buffer, and print cwd after that."
)

-- My <F12> is binded to lsp rename
keymap("n", "<leader><F12>", "*:%s///g<left><left>") -- Rename current word with <leader>F2
keymap("x", "<F12>", '"hy:%s/<C-r>h//g<left><left>') -- Rename selected text in visual

--------------------
-- https://github.com/rafi/vim-config/blob/master/lua/rafi/config/keymaps.lua
-- Put vim command output into buffer
-- local map = vim.keymap.set

-- Put vim command output into buffer
-- map("n", "g1", ":put=execute('')<Left><Left>", { desc = "Paste Command" })

-- keymapExpr("n", "g1", "<cmd>put=execute('')<Left><Left>", "Paste Command")

------------------------------------------------------------
keymap("n", "<Tab>", "%", "Jump to matching pairs easily in normal mode")

-- Go to start or end of line easier (0 and $)
-- h ^   To the first non-blank character of the line.
-- h g_  To the last non-blank character of the line

-- https://github.com/rafi/vim-config/blob/master/lua/rafi/config/keymaps.lua
-- Easier line-wise movement
keymap({ "n", "x" }, "gh", "^", "Jump to first non-blank character of the line")
keymap({ "n", "x" }, "gl", "g_", "Jump to last non-blank character of the line")

-- Go to start or end of line easier
keymap({ "n", "x" }, "<Left>", "^", "first non-blank character of the line")
keymap({ "n", "x" }, "<Right>", "g_", "last non-blank character of the line")
-- keymap({ "n", "x" }, "H", "^", "first non-blank character of the line")
-- keymap({ "n", "x" }, "L", "g_", "last non-blank character of the line")

-- H: To line [count] from top (Home) of window (default: first line on the window) on the first non-blank character
-- L: To line [count] from bottom of window (default: Last line on the window) on the first non-blank character
-- M: To Middle line of window, on the first non-blank character
vim.keymap.del("n", "H")
vim.keymap.del("n", "L")

keymap("n", "<Up>", "H", "up")
keymap("n", "<Down>", "L", "down")

-- keymap("n", "<Up>", "25<C-e>", " scroll up")
-- keymap("n", "<Down>", "25<C-y>", " scroll down")

------------------------------------------------------------
-- Turn the word under cursor to UPPER case
-- inoremap <M-u> <Esc>viwUea
keymap("i", "<A-u>", "<Esc>viWU", "to UPPER case")

keymap("i", "<A-t>", "<Esc>viWUlveu", "to Title case")

------------------------------------------------------------
-- C:\UTILS\Neovim\share\nvim\runtime\mswin.vim
-- Use CTRL-Q to do what CTRL-V used to do
-- noremap <C-Q>		<C-V>

keymap("n", "<C-q>", "<C-v>", "Enter visual block mode")

--------------------
-- A) Copy to system clipboard:

-- Selection registers "* and "+
-- (Copy to system clipboard.)

-- mswin.vim
keymap("x", "<C-c>", '"+y', '  Copy selected text to clipboard - Selection registers "* and "+')

keymap(
  "n",
  "<C-y>",
  '"+yg_',
  '  Copy line (start from cursor position) to clipboard - Selection registers "* and "+'
)

-- vim.opt.iskeyword:append("-")
keymap("n", "<C-c>", '"+yiW', '  Copy WORD to clipboard - Selection registers "* and "+')
keymap("n", "<C-p>", '"+yiw', '  Copy word to clipboard - Selection registers "* and "+')

-- h CTRL-P
-- h CTRL-N

-- Paste, command (and insert) mode:  <CTRL-R>"

--------------------
-- B) Paste from system clipboard with Ctrl + v

-- vim.keymap.set({'n', 'v'}, '<C-v>', '"+p', {remap = true, desc = 'Paste from clipboard'})
keymapRemap({ "n", "v" }, "<C-v>", '"+gP', "Paste from clipboard = Insert from + register")

-- Paste, command (and insert) mode:  <CTRL-R>+
keymapRemap({ "i", "c" }, "<C-v>", "<C-R>+", "Paste from clipboard = Insert from + register")

------------------------------------------------------------
-- keymap("n", "<leader>a", "ggVGy", "Select all. Copy.")
keymap("n", "<leader>a", "ggVG", "Select all.")

keymap("n", "<leader>p<down>", "ggy17j", "Copy first 17 lines")
keymap("n", "<leader>p<up>", "Gy17k", "Copy last 17 lines")

------------------------------------------------------------
vim.keymap.set("n", "<leader>pnm", ":lua NewNote_TR_MP()<CR>", { noremap = true, silent = true }) -- MP
vim.keymap.set("n", "<leader>pna", ":lua NewNote_TR_A()<CR>", { noremap = true, silent = true }) -- Activa
vim.keymap.set("n", "<leader>pnn", ":lua NewNote_ITM_n()<CR>", { noremap = true, silent = true }) -- Note (ITM)

vim.keymap.set("n", "<leader>pnia", ":lua Insert_opc_sc_apc()<CR>", { noremap = true, silent = true }) -- Insert OPC: SC, APC

vim.keymap.set("n", "<leader>p1", ":lua Tr_svk1()<CR>", { noremap = true, silent = true }) -- SVK, OR, niti
vim.keymap.set("n", "<leader>p2", ":lua Tr_svk2()<CR>", { noremap = true, silent = true }) -- SVK, OR, niti

vim.keymap.set("n", "<leader>pl", ":lua Tr_svk_length()<CR>", { noremap = true, silent = true }) -- SVK length
vim.keymap.set("n", "<leader>ps", ":lua Tr_vlookup_1mpr_2dir()<CR>", { noremap = true, silent = true }) -- weekly reports

------------------------------------------------------------
