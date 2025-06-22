#
# Merges multiple single-server MCP JSON files into a single valid MCP config.
# Server names are derived from the input filenames.
#
# Usage:
#   mcp-merge server1.json server2.json ...
#   mcp-merge *.json
#
mcp-merge() {
  if [ "$#" -eq 0 ]; then
    echo "Usage: mcp-merge <file1.json> [file2.json]..." >&2
    return 1
  fi
  jq -n '{mcpServers: ([inputs | {key: (input_filename | split("/")[-1] | rtrimstr(".json") | gsub("_"; "-")), value: .}] | from_entries)}' "$@"
}
