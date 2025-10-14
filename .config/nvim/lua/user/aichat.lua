local M = {}

-- Helper function to find the next file block and its contents
local function find_next_file_block()
  -- Search for the 'File: ' pattern starting from the line after the cursor.
  -- The 'W' flag prevents wrap-around search.
  local start_line = vim.fn.search('^File: ', 'W')
  if start_line == 0 then
    print("No more 'File:' blocks found.")
    return nil
  end

  -- Move cursor to the found line
  vim.api.nvim_win_set_cursor(0, { start_line, 0 })

  local file_path_line = vim.api.nvim_get_current_line()
  local file_path = file_path_line:match('^File: `(.*)`$')

  if not file_path then
    return nil
  end

  -- Find the start of the code block
  local block_start_line_num = vim.fn.search('^```', 'W')
  if block_start_line_num == 0 or block_start_line_num < start_line then
    return file_path, start_line, -1, -1, {}
  end

  -- Find the end of the code block
  local block_end_line_num = vim.fn.search('^```', 'W', block_start_line_num + 1)
  if block_end_line_num == 0 then
    print("Error: Found start of code block but no end.")
    return nil
  end

  -- Get the content of the code block
  local content = vim.api.nvim_buf_get_lines(0, block_start_line_num, block_end_line_num - 1, false)

  return file_path, start_line, block_start_line_num, block_end_line_num, content
end

-- Corresponds to your '@a' macro
function M.apply_file()
  local file_path, start_line, block_start, block_end, content = find_next_file_block()
  if not file_path then
    return
  end

  if block_start == -1 then
    print("Error: No code block found for " .. file_path)
    return
  end

  -- Ensure directory exists
  local dir = vim.fn.fnamemodify(file_path, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
    print("Created directory: " .. dir)
  end

  -- Write the file
  local ok, file = pcall(io.open, file_path, "w")
  if not ok or not file then
    print("Error opening file for writing: " .. file_path)
    return
  end

  file:write(table.concat(content, "\n") .. "\n")
  file:close()
  print("Applied change to " .. file_path)
end

-- Corresponds to your '@r' macro
function M.read_file()
  local file_path_line_num = vim.fn.search('^File: ', 'W')
  if file_path_line_num == 0 then
    print("No more 'File:' lines found.")
    return
  end

  vim.api.nvim_win_set_cursor(0, { file_path_line_num, 0 })
  local file_path_line = vim.api.nvim_get_current_line()
  local file_path = file_path_line:match('^File: `(.*)`$')

  if not file_path then
    return
  end

  local ok, file = pcall(io.open, file_path, "r")
  if not ok or not file then
    print("Error opening file for reading: " .. file_path)
    return
  end

  local content = file:read("*a")
  file:close()

  local lines = vim.split(content, "\n", { trimempty = false })
  -- Remove trailing newline if it exists, as nvim adds one
  if lines[#lines] == "" then
    table.remove(lines)
  end

  local new_block = { "```" }
  for _, line in ipairs(lines) do
    table.insert(new_block, line)
  end
  table.insert(new_block, "```")

  vim.api.nvim_buf_set_lines(0, file_path_line_num, file_path_line_num, false, new_block)
  print("Read content from " .. file_path)
end

-- Corresponds to your '@c' macro
function M.clean_azure_files()
  -- Search from current position
  local start_line = vim.fn.search('^File: .*\\.azure', 'W')

  if start_line == 0 then
    print("No more '.azure' files found.")
    return
  end

  -- We found the line. Now find its associated block.
  -- Move cursor to the found line to provide context for the next search.
  vim.api.nvim_win_set_cursor(0, { start_line, 0 })

  -- Find the start of the code block, it must be after our File: line
  local block_start_line_num = vim.fn.search('^```', 'W')
  if block_start_line_num == 0 or block_start_line_num < start_line then
    -- No code block associated, just delete the File: line
    vim.api.nvim_buf_set_lines(0, start_line - 1, start_line, false, {})
    print("Cleaned Azure file line.")
    return
  end

  -- Find the end of the code block
  local block_end_line_num = vim.fn.search('^```', 'W', block_start_line_num + 1)
  if block_end_line_num == 0 then
    -- Malformed block, just delete the File: line and the start of the block
    vim.api.nvim_buf_set_lines(0, start_line - 1, block_start_line_num, false, {})
    print("Cleaned Azure file line and malformed block start.")
    return
  end

  -- Determine range to delete
  local delete_start = start_line - 1
  local delete_end = block_end_line_num

  vim.api.nvim_buf_set_lines(0, delete_start, delete_end, false, {})
  print("Cleaned Azure file block.")
end

return M
