# My Mise Backend Plugin for Custom Tools

## Implementation

### Implement the backend hooks

Backend plugins require three main hooks:

#### `hooks/backend_list_versions.lua`
Lists available versions for a tool in your backend.

```lua
function PLUGIN:BackendListVersions(ctx)
    local tool = ctx.tool
    -- Your logic to fetch versions for the tool
    -- Return: {versions = {"1.0.0", "1.1.0", "2.0.0"}}
end
```

#### `hooks/backend_install.lua` 
Installs a specific version of a tool.

```lua
function PLUGIN:BackendInstall(ctx)
    local tool = ctx.tool
    local version = ctx.version  
    local install_path = ctx.install_path
    -- Your logic to install the tool
    -- Return: {}
end
```

#### `hooks/backend_exec_env.lua`
Sets up environment variables for a tool.

```lua
function PLUGIN:BackendExecEnv(ctx)
    local install_path = ctx.install_path
    -- Your logic to set up environment
    -- Return: {env_vars = {{key = "PATH", value = install_path .. "/bin"}}}
end
```

## Development Workflow

### Setting up development environment

1. Install pre-commit hooks (optional but recommended):
```bash
hk install
```

This sets up automatic linting and formatting on git commits.

### Local Testing

1. Link your plugin for development:
```bash
mise plugin link --force arsenal .
```

2. Test version listing:
```bash
mise ls-remote arsenal:<some-tool>
```

3. Test installation:
```bash
mise install arsenal:<some-tool>@latest
```

4. Test execution:
```bash
mise exec arsenal:<some-tool>@latest -- <some-tool> --version
```

5. Run tests:
```bash
mise run test
```

6. Run linting:
```bash
mise run lint
```

7. Run full CI suite:
```bash
mise run ci
```

### Code Quality

This template uses [hk](https://hk.jdx.dev) for modern linting and pre-commit hooks:

- **Automatic formatting**: `stylua` formats Lua code
- **Static analysis**: `luacheck` catches Lua issues  
- **GitHub Actions linting**: `actionlint` validates workflows
- **Pre-commit hooks**: Runs all checks automatically on git commit

Manual commands:
```bash
hk check      # Run all linters (same as mise run lint)
hk fix        # Run linters and auto-fix issues
```

### Debugging

Enable debug output:
```bash
mise --debug install arsenal:<tool>@<version>
```

## Files

- `metadata.lua` – Backend plugin metadata and configuration
- `hooks/backend_list_versions.lua` – Lists available versions for tools
- `hooks/backend_install.lua` – Installs specific versions of tools
- `hooks/backend_exec_env.lua` – Sets up environment variables for tools
- `.github/workflows/ci.yml` – GitHub Actions CI/CD pipeline
- `mise.toml` – Development tools and configuration
- `mise-tasks/` – Task scripts for testing
- `hk.pkl` – Modern linting and pre-commit hook configuration
- `.luacheckrc` – Lua linting configuration
- `stylua.toml` – Lua formatting configuration

## Context Variables Reference

### BackendListVersions Context
| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| `ctx.tool` | string | Tool name | `"prettier"` |

### BackendInstall and BackendExecEnv Context  
| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| `ctx.tool` | string | Tool name | `"prettier"` |
| `ctx.version` | string | Tool version | `"3.0.0"` |
| `ctx.install_path` | string | Installation directory | `"/home/user/.local/share/mise/installs/npm/prettier/3.0.0"` |

### Available Lua Modules

Backend plugins have access to these built-in modules:

- `cmd` - Execute shell commands
- `http` - HTTP client for downloads and API calls  
- `json` - JSON parsing and encoding
- `file` - File system operations

## Publishing

1. Ensure all tests pass: `mise run ci`
2. Create a GitHub repository for your plugin
3. Push your code
4. Test with: `mise plugin install mybackend https://github.com/user/mise-mybackend`
5. (Optional) Request to transfer to [mise-plugins](https://github.com/mise-plugins) organization
6. Add to the [mise registry](https://github.com/jdx/mise/blob/main/registry.toml) via PR

## Documentation

- [Backend Plugin Development](https://mise.jdx.dev/backend-plugin-development.html) - Complete guide
- [Backend Architecture](https://mise.jdx.dev/dev-tools/backend_architecture.html) - How backends work
- [Backend Plugin Template](https://github.com/jdx/mise-backend-plugin-template)
- [Lua modules reference](https://mise.jdx.dev/plugin-lua-modules.html) - Available modules
- [mise-plugins organization](https://github.com/mise-plugins) - Community plugins

## License

MIT
