return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", --   "obsidian-nvim/obsidian.nvim",recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        -- refer to `:h file-pattern` for more examples
        "BufReadPre "
            .. vim.fn.expand("~")
            .. "\\Documents\\Obsidian\\*.md",
        "BufNewFile " .. vim.fn.expand("~") .. "\\Documents\\Obsidian\\*.md",
    },
    keys = {
        { "<leader>so", "<cmd>ObsidianSearch<cr>", desc = "Obsidian (cwd)" },
        { "<leader>sO", "<cmd>ObsidianWorkspace<cr>", desc = "Obsidian Workspaces" },
        { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Notes (cwd)" },
        { "<leader>oS", "<cmd>ObsidianWorkspace<cr>", desc = "Search Workspaces" },
        { "<leader>ot", "<cmd>ObsidianTemplate<cr>", desc = "Template" },
        { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste Image" },
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
    },
    opts = {
        workspaces = {
            {
                name = "personal",
                path = "~/Documents/Obsidian/Personal",
            },
            {
                name = "rpg",
                path = "~/Documents/Obsidian/RPG",
            },
        },

        completion = {
            blink = true,
            min_chars = 1,
        },

        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
            -- Toggle check-boxes.
            ["<leader>ch"] = {
                action = function()
                    return require("obsidian").util.toggle_checkbox()
                end,
                opts = { buffer = true },
            },
            -- Smart action depending on context: follow link, show notes with tag, or toggle checkbox.
            ["<cr>"] = {
                action = function()
                    return require("obsidian").util.smart_action()
                end,
                opts = { buffer = true, expr = true },
            },
        },

        -- Where to put new notes. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "notes_subdir",

        -- Optional, customize how wiki links are formatted. You can set this to one of:
        --  * "use_alias_only", e.g. '[[Foo Bar]]'
        --  * "prepend_note_id", e.g. '[[foo-bar|Foo Bar]]'
        --  * "prepend_note_path", e.g. '[[foo-bar.md|Foo Bar]]'
        --  * "use_path_only", e.g. '[[foo-bar.md]]'
        -- Or you can set it to a function that takes a table of options and returns a string, like this:
        -- wiki_link_func = function(opts)
        --     return require("obsidian.util").wiki_link_id_prefix(opts)
        -- end,
        wiki_link_func = "prepend_note_path",

        preferred_link_style = "markdown",

        templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {},
        },

        -- TODO: Dynamically detect the version/os in the two functions below

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
        -- URL it will be ignored but you can customize this behavior here.
        ---@param url string
        follow_url_func = function(url)
            -- Open the URL in the default web browser.
            -- vim.fn.jobstart({ "open", url }) -- Mac OS
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
            -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
            vim.ui.open(url) -- need Neovim 0.10.0+
        end,

        -- Optional, by default when you use `:ObsidianFollowLink` on a link to an image
        -- file it will be ignored but you can customize this behavior here.
        ---@param img string
        follow_img_func = function(img)
            -- vim.fn.jobstart({ "qlmanage", "-p", img }) -- Mac OS quick look preview
            -- vim.fn.jobstart({"xdg-open", url})  -- linux
            vim.cmd(':silent exec "!start ' .. img .. '"') -- Windows
        end,

        -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
        open_app_foreground = true,

        picker = {
            -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
            name = "snacks.pick",
            -- Optional, configure key mappings for the picker. These are the defaults.
            -- Not all pickers support all mappings.
            note_mappings = {
                -- Create a new note from your query.
                new = "<C-x>",
                -- Insert a link to the selected note.
                insert_link = "<C-l>",
            },
            tag_mappings = {
                -- Add tag(s) to current note.
                tag_note = "<C-x>",
                -- Insert a tag at the current location.
                insert_tag = "<C-l>",
            },
        },

        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
        sort_by = "modified",
        sort_reversed = true,
    },
}
