local M = {}

-- Safely load a tool module and handle typos gracefully
function M.get_toolOrError(tool_name)
    local success, tool = pcall(require, "tools." .. tool_name)

    if not success then
        -- Print a clear, actionable error message to stderr
        io.stderr:write(string.format("\n\27[31m[Error]\27[0m Custom tool '%s' is not supported.\n", tool_name))
        io.stderr:write("Please check if the Lua configuration exists in your 'tools/' directory.\n\n")
        return nil
    end

    return tool
end

return M
