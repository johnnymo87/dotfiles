local M = {}

-- Function to fetch Confluence page content
function M.fetch_page_content(page_id)
  if not page_id or page_id == "" then
    vim.notify("Error: Page ID is required.", vim.log.levels.ERROR)
    return
  end

  local api_token = os.getenv("ATLASSIAN_API_TOKEN")
  if not api_token or api_token == "" then
    vim.notify("Error: ATLASSIAN_API_TOKEN environment variable is not set.", vim.log.levels.ERROR)
    return
  end

  -- Ensure curl, jq, and html2markdown are in PATH
  if vim.fn.executable("curl") == 0 then
    vim.notify("Error: 'curl' command not found in PATH.", vim.log.levels.ERROR)
    return
  end
  if vim.fn.executable("jq") == 0 then
    vim.notify("Error: 'jq' command not found in PATH.", vim.log.levels.ERROR)
    return
  end
  if vim.fn.executable("html2markdown") == 0 then
    vim.notify("Error: 'html2markdown' command not found in PATH.", vim.log.levels.ERROR)
    return
  end

  local email = "jmohrbacher@wonder.com" -- Consider making this configurable if needed

  -- Construct the command string to fetch JSON data (title and body)
  local fetch_json_command = string.format(
    "curl --fail --silent --show-error --request GET " ..
    "--url 'https://wonder.atlassian.net/wiki/api/v2/pages/%s?body-format=editor' " ..
    "--user '%s:%s' " ..
    "--header 'Accept: application/json' " ..
    "| jq '{ \"title\": .title, \"body\": .body.editor.value }'",
    page_id,
    email,
    api_token
  )

  vim.notify("Fetching Confluence page data for " .. page_id .. "...", vim.log.levels.INFO)

  -- Execute the command and capture its output
  local json_str_output = vim.fn.system(fetch_json_command)

  -- Check for shell errors (e.g., curl or jq command failure)
  if vim.v.shell_error ~= 0 then
    vim.notify(
      "Error fetching page data from Confluence. Shell error: " .. vim.v.shell_error ..
      ". Output: " .. json_str_output,
      vim.log.levels.ERROR
    )
    return
  end

  if json_str_output == "" or json_str_output == nil then
    vim.notify("Error: No data received from Confluence/jq.", vim.log.levels.ERROR)
    return
  end

  -- Parse the JSON response
  local ok, data = pcall(vim.json.decode, json_str_output)
  if not ok or type(data) ~= "table" then
    vim.notify("Error: Failed to parse JSON response: " .. (data or "Invalid JSON"), vim.log.levels.ERROR)
    vim.notify("Received: " .. json_str_output, vim.log.levels.DEBUG)
    return
  end

  local title = data.title
  local html_body = data.body

  -- Validate title
  if not title or type(title) ~= "string" then
    vim.notify("Error: Page title not found or invalid in response.", vim.log.levels.ERROR)
    -- Optionally, you could decide to proceed without a title or return
    title = "Title not found" -- Fallback title
  end

  -- Validate html_body
  if not html_body or type(html_body) ~= "string" then
    vim.notify("Warning: Page body not found or invalid in response. Body will be empty.", vim.log.levels.WARN)
    html_body = "" -- Treat as empty body
  end

  -- Convert HTML body to Markdown
  local markdown_body = ""
  if html_body ~= "" then
    local html2md_command_parts = {"html2markdown"}
    -- Pass html_body as stdin to html2markdown
    markdown_body = vim.fn.system(html2md_command_parts, html_body)
    if vim.v.shell_error ~= 0 then
      vim.notify(
        "Error converting HTML to Markdown. Shell error: " .. vim.v.shell_error ..
        ". Output: " .. markdown_body,
        vim.log.levels.ERROR
      )
      markdown_body = "Error converting page body to Markdown." -- Fallback body content
    end
  else
    vim.notify("Info: Confluence page body is empty.", vim.log.levels.INFO)
  end

  -- Prepare lines to insert
  local lines_to_insert = {}
  table.insert(lines_to_insert, title)
  table.insert(lines_to_insert, "") -- Blank line

  -- Split markdown_body into lines and add them
  -- vim.split with plain=true is important if markdown_body could contain regex special chars
  for _, line in ipairs(vim.split(markdown_body, "\n", {plain = true})) do
    table.insert(lines_to_insert, line)
  end
  -- If markdown_body was empty, vim.split("", "\n") yields {""}, so one empty line is added.
  -- If markdown_body was "" and you want no lines for body, adjust logic here.
  -- Current behavior: title, blank, blank (if body was empty).

  -- Get current buffer and cursor position (0-indexed for API)
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor_row = vim.api.nvim_win_get_cursor(0)[1] - 1 -- API uses 0-indexed lines

  -- Insert lines at the current cursor position, pushing existing content down
  vim.api.nvim_buf_set_lines(bufnr, cursor_row, cursor_row, false, lines_to_insert)

  vim.notify("Confluence page content (title and body) inserted.", vim.log.levels.INFO)
end

-- Create a user command :FetchConfluencePage
vim.api.nvim_create_user_command(
  "FetchConfluencePage",
  function(opts)
    -- opts.args will contain the string of arguments passed to the command
    M.fetch_page_content(opts.args)
  end,
  {
    nargs = 1, -- Expects one argument (the page ID)
    complete = function(arglead, cmdline, cursorpos)
      -- Basic completion, could be enhanced if you have a list of page IDs
      return {}
    end,
    desc = "Fetch Confluence page by ID and insert its title and content.",
  }
)

return M
