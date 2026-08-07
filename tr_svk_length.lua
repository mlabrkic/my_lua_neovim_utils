-- date: 2026_06M_09 20:30:52

-- SVK length
function Tr_svk_length()
  -- local A = vim.api

  -- ("listed", "") -- Create a new buffer
  -- local bufnr = A.nvim_create_buf(true, false) -- Create a new buffer

  -- A.nvim_buf_set_name(bufnr, "tr_svk_1_" .. t.hour .. "H_" .. t.min .."M_" .. t.sec .. "S.txt") -- Assign a name to the new buffer

  local t = os.date("*t")
  -- print("Hour:", t.hour)
  -- print("Minute:", t.min)
  -- print("Second:", t.sec)

  -- vim.cmd("e temp")
  -- Simple: edit new file "notes.txt"
  -- vim.cmd.edit("notes.txt")
  BName = "tr_svk_length_" .. t.hour .. "H_" .. t.min .. "M_" .. t.sec .. "S.txt"
  vim.cmd.edit(BName)

  -- SVK Aplikacija: copy rows of SVK segments
  vim.cmd([[ normal "+gP ]]) -- "Paste from clipboard = Insert from + register"

  --------------------
  -- vim.cmd("TrailspaceTrim")
  -- vim.cmd([[ normal ggVG ]]) -- Select all
  -- vim.cmd("w")
  --
  -- vim.cmd([[ normal pbj ]]) -- paste, 1 words backward, 1 lines downward
  -- :h b

  vim.cmd([[
    TrailspaceTrim
    QcsvKeepLastColumn
    normal ggVGy
    QsumInColum
    w
    bd
  ]])

  --------------------
  -- vim.api.nvim_buf_set_text()

  local bufnr = 0 -- current buffer
  local row = vim.api.nvim_win_get_cursor(0)[1] -- 1-based row

  vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, {
    -- "new line content",
    "svkApp:",
  })

  --------------------
  vim.cmd([[
    normal jpbj
  ]])
end
