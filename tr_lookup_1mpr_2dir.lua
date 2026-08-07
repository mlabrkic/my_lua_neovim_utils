-- date: 2026_08M_03 16:50:50

--------------------
-- What does this code do: <source code>
--------------------

-- This is a Neovim Lua script that reads two buffers (1mpr.txt and 2dir.txt),
-- processes their contents, and rewrites 1mpr.txt with transformed data.

-- High-level summary

-- For each line in 1mpr.txt:
-- Split the line into words.
-- Remove the last word from that line.

-- Find that last word somewhere in 2dir.txt.
-- Copy the text from the found word to the end of the matching line in 2dir.txt.

-- Combine both pieces into the output.
-- Add a blank line.
-- Replace every ", ZG" with ", Zagreb".
-- Overwrite 1mpr.txt with the result.

--------------------
function Tr_vlookup_1mpr_2dir()
  -- Get buffer numbers
  local buf1 = vim.fn.bufnr("1mpr.txt")
  local buf2 = vim.fn.bufnr("2dir.txt")

  -- Read all lines from both files
  local rep_lines = vim.api.nvim_buf_get_lines(buf1, 0, -1, false)
  local mp_lines = vim.api.nvim_buf_get_lines(buf2, 0, -1, false)

  -- Create result table
  -- This is where the new output will be stored before writing back to 1mpr.txt.
  local result = {}

  -- Loop through every line in 1mpr.txt
  -- ipairs() iterates through the table.
  -- The _ means "ignore the index".
  for _, rep_line in ipairs(rep_lines) do
    -- Split line into words
    -- vim.trim() removes leading/trailing spaces.
    -- vim.split() splits on whitespace.
    local words = vim.split(vim.trim(rep_line), "%s+")

    -- Check if line contains words
    -- #words gives the number of elements.
    if #words > 0 then
      -- Get last word
      -- #words is the last index.
      local last_word = words[#words]

      -- insert all words except the last one
      -- Copy all words except the last
      for i = 1, #words - 1 do
        table.insert(result, words[i])
      end

      -- find last_word in 2dir.txt and copy from it to end of line
      -- Build whole-word search pattern
      --
      -- Suppose:
      -- last_word = "dog"
      --
      -- Pattern becomes:
      -- %f[%w]dog%f[%W]
      --
      -- This matches:
      -- dog apple
      -- big dog

      -- vim.pesc - Escapes special pattern characters.
      -- Example:
      -- vim.pesc("a+b")
      -- returns: "a%+b"

      local pattern = "%f[%w]" .. vim.pesc(last_word) .. "%f[%W]"

      -- Search in 2dir.txt
      -- Loop through every line of 2dir.txt.
      for _, mp_line in ipairs(mp_lines) do
        -- Find word position
        local s = mp_line:find(pattern)

        if s then
          -- Copy from found word to end of line
          table.insert(result, mp_line:sub(s))
          break
        end
      end

      -- Add blank line
      table.insert(result, "")
    end
  end

  -- To replace all occurrences of ", ZG" with ", Zagreb" in 1mpr.txt's buffer:
  -- gsub() means "global substitution".
  for i, line in ipairs(result) do
    result[i] = line:gsub(", ZG", ", Zagreb")
  end

  -- Write everything back to 1mpr.txt
  -- This replaces all lines in 1mpr.txt with what's in result.
  vim.api.nvim_buf_set_lines(buf1, 0, -1, false, result)
end
