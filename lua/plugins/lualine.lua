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
            source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                    return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed,
                    }
                end
            end,
        })

        -- A separator is mandatory so we can manipulate the string later in the fmt option
        -- WARN: for some reason if the separator has whitespaces, they get duplicate when table.concat(result, sep) is called
        local sep = ">"
        local exact = true

        table.remove(opts.sections.lualine_c, #opts.sections.lualine_c)
        table.insert(opts.sections.lualine_c, {
            "aerial",
            sep = sep, -- separator between symbols
            sep_icon = "", -- separator between icon and symbol

            -- The number of symbols to render top-down. In order to render only 'N' last
            -- symbols, negative numbers may be supplied. For instance, 'depth = -1' can
            -- be used in order to render only current symbol.
            depth = 5,

            -- When 'dense' mode is on, icons are not rendered near their symbols. Only
            -- a single icon that represents the kind of current symbol is rendered at
            -- the beginning of status line.
            dense = false,

            -- The separator to be used to separate symbols in dense mode.
            dense_sep = ".",

            -- Color the symbol icons.
            colored = true,

            exact = exact,

            fmt = function (status, _)
                local aerial_ok, aerial = pcall(require, "aerial")
                if not aerial_ok then
                    return ""
                end

                local data = aerial.get_location(exact)

                if data == nil then
                    return ""
                end

                _G.aerial_line_click = function(minwid)
                    vim.cmd("normal! m'")
                    vim.api.nvim_win_set_cursor(0, {
                        data[minwid].lnum,
                        data[minwid].col
                    })
                end

                local symbols = {}
                -- Grab the string for each symbol
                for part in status:gmatch('([^'..sep:gsub("%s+", "")..']+)') do
                    table.insert(symbols, part)
                end

                -- Adds the "%" .. index .. "@v:lua.aerial_line_click@" string at the start of each symbol,
                -- which calls the function aerial_line_click passing the position of the symbol as the first parameter
                ---@param index integer position of the symbol as displayed in the lualine
                ---@param part string the symbol string
                ---@return string
                local function add_click(index, part)
                    return "%" .. index .. "@v:lua.aerial_line_click@" .. part .. "%X"
                end

                -- create a second table and iterate again using ipairs, so we can have access to the index of the symbol
                local ret = {}
                for index, value in ipairs(symbols) do
                    -- add the "[line number]" string after the first space (aka the icon) with the LineNr highlight color
                    local s = value:gsub("%s", " %%#LineNr#%[" .. data[index].lnum .. "%] ", 1)
                    table.insert(ret, add_click(index, s))
                end

                -- manually add the separator spaces back again
                return table.concat(ret, " " .. sep .. " ")
            end
        })
    end,
}

