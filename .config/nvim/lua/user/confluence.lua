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

  -- Construct the command string.
  -- Note: We are embedding page_id and email:api_token into single-quoted strings
  -- for the shell. This is generally safe if page_id is simple and api_token
  -- doesn't contain single quotes. For maximum safety, especially for the token,
  -- you might consider more complex escaping or passing them as separate arguments
  -- if the command structure allowed, but for curl's --user, this format is standard.
  local command_str = string.format(
    "curl --fail --silent --show-error --request GET " ..
    "--url 'https://wonder.atlassian.net/wiki/api/v2/pages/%s?body-format=storage' " ..
    "--user '%s:%s' " .. -- Single quotes around user:token for shell
    "--header 'Accept: application/json' " ..
    "| jq '.body.storage.value' " ..
    "| html2markdown",
    page_id, -- page_id is inserted directly into the single-quoted URL
    email,   -- email is part of the single-quoted user string
    api_token -- api_token is part of the single-quoted user string
  )

  vim.notify("Fetching Confluence page " .. page_id .. "...", vim.log.levels.INFO)

  -- Use :read ! to insert the output into the buffer
  -- vim.cmd will execute the ex command
  -- 'silent' suppresses messages from the command itself (like "N lines read")
  -- '!' indicates an external command
  vim.cmd("silent read !" .. command_str)
  vim.notify("Confluence page content inserted.", vim.log.levels.INFO)
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
    desc = "Fetch Confluence page by ID and insert its content.",
  }
)

return M
