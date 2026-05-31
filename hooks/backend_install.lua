local cmd = require("cmd")
local utils = require("hooks.utils")

--- Installs a specific version of a tool
--- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendinstall
--- @param ctx {tool: string, version: string, install_path: string} Context
--- @return table Empty table on success
function PLUGIN:BackendInstall(ctx)
    -- Use the enhanced loader that handles errors gracefully
    local tool = utils.get_toolOrError(ctx.tool)
    if not tool then
        -- Stop mise execution immediately
        error("Installation aborted due to missing tool configuration.")
    end

    -- The RUNTIME object provides:
    --     RUNTIME.osType: Operating system type ("windows", "linux", "darwin")
    --     RUNTIME.archType: Architecture ("amd64", "arm64", "x86", etc.)
    --     RUNTIME.envType: libc environment type ("gnu" on glibc Linux, "musl" on musl Linux, nil on Windows/macOS and undetected systems)
    --     RUNTIME.version: vfox runtime version
    --     RUNTIME.pluginDirPath: Plugin directory path

    -- if arch_name == "x86_64" or arch_name == "amd64" then
    --     arch_name = "amd64"
    -- elseif arch_name == "aarch64" or arch_name == "arm64" then
    --     arch_name = "arm64"
    -- end

    local platform = {
        os = RUNTIME.osType,
        arch = RUNTIME.archType,
    }
    tool.install(ctx, platform, cmd)
    return {}
end
