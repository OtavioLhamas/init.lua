local winbar_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "lazy",
    "neo-tree",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "Jaq",
    "harpoon",
    "dap-repl",
    "dap-terminal",
    "dapui_console",
    "dapui_hover",
    "lab",
    "notify",
    "noice",
    "neotest-summary",
}

local get_navic = function()
    if vim.tbl_contains(winbar_filetype_exclude or {}, vim.bo.filetype) then
        return ""
    end

    local navic_ok, navic = pcall(require, "nvim-navic")
    if not navic_ok then
        return ""
    end

    if not navic.is_available() then
        return ""
    end

    local data = navic.get_data()

    if data == nil then
        return ""
    end

    local lib = require("nvim-navic.lib")
    local plugin = require("lazy.core.config").spec.plugins["nvim-navic"]
    local navic_opts = require("lazy.core.plugin").values(plugin, "opts", false)

    local location = {}

    local function add_hl(kind, name, line)
        return "%#NavicIcons"
            .. lib.adapt_lsp_num_to_str(kind)
            .. "#"
            .. navic_opts.icons[lib.adapt_lsp_num_to_str(kind)]
            .. "%*%#LineNr#"
            .. line
            .. "%* %#NavicText#"
            .. name
            .. "%*"
    end

    if navic_opts.click then
        _G.navic_click_handler = function(minwid, cnt, _, _)
            vim.cmd("normal! m'")
            vim.api.nvim_win_set_cursor(0, {
                data[minwid].scope["start"].line,
                data[minwid].scope["start"].character,
            })
            if cnt > 1 then
                local ok, navbuddy = pcall(require, "nvim-navbuddy")
                if ok then
                    navbuddy.open(bufnr)
                else
                    vim.notify("nvim-navic: Double click requires nvim-navbuddy to be installed.", vim.log.levels.WARN)
                end
            end
        end
    end

    local function add_click(level, component)
        return "%" .. level .. "@v:lua.navic_click_handler@" .. component .. "%X"
    end

    for i, v in ipairs(data) do
        local name = ""

        if navic_opts.safe_output then
            name = string.gsub(v.name, "%%", "%%%%")
            name = string.gsub(name, "\n", " ")
        else
            name = v.name
        end

        local component

        if navic_opts.highlight then
            component = add_hl(v.kind, name, v.scope.start.line)
        else
            component = v.icon .. name
        end

        if navic_opts.click then
            component = add_click(i, component)
        end

        table.insert(location, component)
    end

    if navic_opts.depth_limit ~= 0 and #location > navic_opts.depth_limit then
        location = vim.list_slice(location, #location - navic_opts.depth_limit + 1, #location)
        if navic_opts.highlight then
            table.insert(location, 1, "%#NavicSeparator#" .. navic_opts.depth_limit_indicator .. "%*")
        else
            table.insert(location, 1, navic_opts.depth_limit_indicator)
        end
    end

    local ret = ""

    if navic_opts.highlight then
        ret = table.concat(location, "%#NavicSeparator#" .. navic_opts.separator .. "%*")
    else
        ret = table.concat(location, navic_opts.separator)
    end

    return ret
end

return {
    "lualine.nvim",
    opts = function(_, opts)
        opts.options = LazyVim.merge(opts.options, {
            component_separators = { left = "", right = "" },
            icons_enabled = true,
            section_separators = { left = "", right = "" },
        })

        local icons = LazyVim.config.icons

        -- move git diff from section x to b
        table.remove(opts.sections.lualine_x, #opts.sections.lualine_x)

        table.insert(opts.sections.lualine_b, {
            "diff",
            symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
            },
        })

        -- move navic from section c to winbar
        table.remove(opts.sections.lualine_c, #opts.sections.lualine_c)
        opts.winbar = LazyVim.merge(opts.winbar, {
            lualine_a = {
                {
                    function()
                        return get_navic()
                    end,
                    cond = function()
                        return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                    end,
                    draw_empty = true,
                },
            },
        })
    end,
}
