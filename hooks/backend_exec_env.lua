local utils = require("hooks.utils")

--- Sets up environment variables for a tool
--- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendexecenv
--- @param ctx {install_path: string, tool: string, version: string} Context
--- @return {env_vars: table[]} Table containing list of environment variable definitions
function PLUGIN:BackendExecEnv(ctx)
    local tool = utils.get_toolOrError(ctx.tool)
    if tool and tool.get_env then
        return tool.get_env(ctx)
    end
    return {}
end
