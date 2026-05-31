local M = {}

-- Define available versions for this tool
function M.versions(ctx)
    return { "latest" }
end

-- Handle download and extraction logic
function M.install(ctx, platform, cmd)
    -- Map to Pipedream's specific URL architecture
    local url = string.format("https://cli.pipedream.com/%s/%s/latest/pd.zip", platform.os, platform.arch)
    local zip_path = ctx.install_path .. "/pd.zip"

    -- Create target directory
    cmd.exec("mkdir -p " .. ctx.install_path)

    -- Download the zip archive
    cmd.exec(string.format("curl -sL '%s' -o '%s'", url, zip_path))

    -- Extract to the installation directory
    cmd.exec(string.format("unzip -o '%s' -d '%s'", zip_path, ctx.install_path))

    -- Cleanup and ensure executable permissions
    cmd.exec("rm '" .. zip_path .. "'")
    cmd.exec("chmod +x '" .. ctx.install_path .. "/pd'")
end

-- Inject environment variables into mise context
--- @param ctx {install_path: string, tool: string, version: string} Context
--- @return {env_vars: table[]} Table containing list of environment variable definitions
function M.get_env(ctx)
    -- Basic PATH setup (most common case)
    local file = require("file")
    local bin_path = file.join_path(ctx.install_path, "bin")

    return {
        env_vars = {
            { key = "PATH", value = ctx.install_path },
        },
    }
end

return M
