local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- import/override with your plugins
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    install = { colorscheme = { "tokyonight", "habamax", "catppuccin" } },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

--- Creates an Ansible role with the specified name and OS type.
---@param role_name string The name of the Ansible role to create.
---@param os_type string The target operating system type ('linux', 'windows', or 'both').
---@param roles_dir? string The directory where roles are stored (optional, default: "roles").
local function create_ansible_role(role_name, os_type, roles_dir)
    -- Default value for roles_dir
    roles_dir = roles_dir or "roles"
    -- Default value for os_type
    os_type = os_type or "both"

    -- Check if the 'roles' directory is an absolute path
    -- expand to cwd if it isn't
    roles_dir = vim.fn.isabsolutepath(roles_dir) == 1 and roles_dir or vim.fn.expand(vim.uv.cwd() .. "/" .. roles_dir)

    -- Check if the 'roles' directory exists, create if it doesn't
    ---@type integer
    local roles_dir_exists = vim.fn.isdirectory(roles_dir) == 1
    if not roles_dir_exists then
        local ok, err = vim.uv.fs_mkdir(roles_dir, tonumber("755", 8))
        if not ok then
            vim.notify("Failed to create roles directory: " .. err, vim.log.ERROR)
            return
        end
    end

    -- Construct the role directory path
    local role_dir = roles_dir .. "/" .. role_name

    -- Check if the role directory already exists
    ---@type boolean
    local role_dir_exists = vim.fn.isdirectory(role_dir) == 1
    if role_dir_exists then
        vim.notify("Role directory '" .. role_dir .. "' already exists.", vim.log.ERROR)
        return
    end

    -- Create the role directory
    ---@type boolean|nil, string|nil
    local ok, err = vim.uv.fs_mkdir(role_dir, tonumber("755", 8)) -- Use 0755 for standard permissions
    if not ok then
        vim.notify("Failed to create role directory: " .. err, vim.log.ERROR)
        return
    end

    -- Create the subdirectories
    local sub_dirs = { "defaults", "vars", "tasks" }
    for _, sub_dir in ipairs(sub_dirs) do
        local sub_dir_path = role_dir .. "/" .. sub_dir
        ---@type boolean|nil, string|nil
        local ok, err = vim.uv.fs_mkdir(sub_dir_path, tonumber("755", 8))
        if not ok then
            vim.notify("Failed to create " .. sub_dir_path .. ": " .. err, vim.log.ERROR)
            return
        end

        -- Create the main.yml file
        local file_path = sub_dir_path .. "/main.yml"
        ---@type file*? , string?
        local file, err = io.open(file_path, "w")
        if not file then
            vim.notify("Failed to create file: " .. file_path .. " - " .. err, vim.log.ERROR)
            return
        end
        file:write("---\n")
        if sub_dir == "tasks" then
            file:write([[
- name: Load variables.
  ansible.builtin.include_vars: "{{ lookup('ansible.builtin.first_found', params) }}"
  vars:
    params:
      files:
        - '{{ ansible_distribution }}-{{ ansible_distribution_major_version }}.yml'
        - '{{ ansible_distribution }}.yml'
        - '{{ ansible_os_family }}.yml'
        - main.yml
      paths:
        - '{{ role_path }}/vars'

- name: Include system appropriate tasks.
  ansible.builtin.include_tasks: "{{ lookup('ansible.builtin.first_found', params) }}"
  vars:
    params:
      files:
        - 'setup-{{ ansible_distribution }}-{{ ansible_distribution_major_version }}.yml'
        - 'setup-{{ ansible_distribution }}.yml'
        - 'setup-{{ ansible_os_family }}.yml'
        - main.yml]])
        end
        file:close() -- close the file

        if os_type == "both" then
            local distros = { "Debian", "Ubuntu", "Pop!_OS", "Windows" }
            for _, distro in ipairs(distros) do
                -- Create the OS specific yml file
                local distro_path = sub_dir_path .. "/" .. (sub_dir == "tasks" and "setup-" or "") .. distro .. ".yml"
                ---@type file*? , string?
                local distro_file, err = io.open(distro_path, "w")
                if not distro_file then
                    vim.notify("Failed to create file: " .. distro_path .. " - " .. err, vim.log.levels.ERROR)
                    return
                end
                distro_file:write("---")
                distro_file:close()
            end
        end
    end

    vim.notify("Ansible role '" .. role_name .. "' created successfully.", vim.log.INFO)
end

-- Define the NeoVim command
vim.api.nvim_create_user_command("CreateAnsibleRole", function(opts)
    local args = vim.split(opts.args, "%s+")
    ---@type string
    local role_name = args[1]
    ---@type string
    local os_type = args[2]
    ---@type string
    local roles_dir = args[3]

    if not role_name then
        vim.notify("Usage: :CreateAnsibleRole <role_name> <linux|windows|both> [roles_dir]", vim.log.ERROR)
        return
    end

    os_type = (os_type or "both"):lower()
    if os_type ~= "linux" and os_type ~= "windows" and os_type ~= "both" then
        vim.notify("Invalid OS type.  Use 'linux', 'windows', or 'both'.", vim.log.ERROR)
        return
    end

    create_ansible_role(role_name, os_type, roles_dir)
end, {
    desc = "Create a new Ansible role with the specified name and OS type.",
    nargs = "*", -- Allow any number of arguments
})
