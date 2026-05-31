local utils = require("hooks.utils")

--- Lists available versions for a tool in this backend
--- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendlistversions
--- @param ctx {tool: string} Context (tool = the tool name requested)
--- @return {versions: string[]} Table containing list of available versions
function PLUGIN:BackendListVersions(ctx)
    local tool = utils.get_toolOrError(ctx.tool)
    if tool and tool.versions then
        return { versions = tool.versions(ctx) }
    end
    return { versions = {} }
end
