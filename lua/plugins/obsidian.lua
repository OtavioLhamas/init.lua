-- TODO: setup linux path
local vault_path = ""

if LazyVim.is_win() then
    vault_path = "G:\\Obsidian"
end

return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", --   "obsidian-nvim/obsidian.nvim",recommended, use latest release instead of latest commit
    lazy = true,
    -- Load on all markdown files
    -- ft = "markdown",
    -- Replace the above line with this event if you only want to load obsidian.nvim for markdown files in your vault:
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
        -- refer to `:h file-pattern` for more examples
        "BufReadPre "
            .. vault_path
            .. "\\*.md",
        "BufNewFile " .. vault_path .. "\\*.md",
    },
    keys = {
        { "<leader>o", "", desc = "Obsidian" },
        { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Search Backlinks" },
        { "<leader>oc", "<cmd>Obsidian toc<cr>", desc = "Jump Table of Contents" },
        { "<leader>oh", "<cmd>Obsidian helpgrep<cr>", desc = "Grep Help Wiki" },
        { "<leader>oH", "<cmd>Obsidian help<cr>", desc = "Search Help Wiki" },
        { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Search Links" },
        { "<leader>op", "<cmd>Obsidian paste_img<cr>", desc = "Paste Image" },
        { "<leader>oq", "<cmd>Obsidian quick_switch<cr>", desc = "Search Notes by Name" },
        { "<leader>or", "<cmd>Obsidian rename<cr>", desc = "Rename" },
        { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search Notes (cwd)" },
        { "<leader>oS", "<cmd>Obsidian workspace<cr>", desc = "Search Workspaces" },
        { "<leader>ot", "<cmd>Obsidian template<cr>", desc = "Template" },
        { "<leader>so", "<cmd>Obsidian search<cr>", desc = "Obsidian (cwd)" },
        { "<leader>sO", "<cmd>Obsidian workspace<cr>", desc = "Obsidian Workspaces" },
    },
    opts = {

        ---@class obsidian.config.AttachmentsOpts
        ---
        ---Default folder to save images to, relative to the vault root (/) or current dir (.), see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images#change-image-save-location
        ---@field folder? string
        ---
        ---Default name for pasted images
        ---@field img_name_func? fun(): string
        ---
        ---Default text to insert for pasted images
        ---@field img_text_func? fun(path: obsidian.Path): string
        ---
        ---Whether to confirm the paste or not. Defaults to true.
        ---@field confirm_img_paste? boolean
        attachments = {
            folder = ".",
            img_name_func = function()
                return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
            end,
            confirm_img_paste = true,
        },

        callbacks = {
            enter_note = function(note)
                vim.keymap.set("n", "<leader>ch", "<cmd>Obsidian toggle_checkbox<cr>", {
                    buffer = true,
                    desc = "Toggle checkbox",
                })
            end,
        },

        ---@class obsidian.config.CompletionOpts
        ---
        ---@field nvim_cmp? boolean
        ---@field blink? boolean
        ---@field min_chars? integer
        ---@field match_case? boolean
        ---@field create_new? boolean
        completion = (function()
            local has_nvim_cmp, _ = pcall(require, "cmp")
            local has_blink = pcall(require, "blink.cmp")
            return {
                nvim_cmp = has_nvim_cmp and not has_blink,
                blink = has_blink,
                min_chars = 2,
                match_case = true,
                create_new = true,
            }
        end)(),

        legacy_commands = false,

        -- Where to put new notes. Valid options are
        --  * "current_dir" - put new notes in same directory as the current buffer.
        --  * "notes_subdir" - put new notes in the default notes subdirectory.
        new_notes_location = "current_dir",

        ---@class obsidian.config.OpenOpts
        ---
        ---Opens the file with current line number
        ---@field use_advanced_uri? boolean
        ---
        ---Function to do the opening, default to vim.ui.open
        ---@field func? fun(uri: string)
        open = {
            use_advanced_uri = false,
            func = vim.ui.open,
        },

        ---@class obsidian.config.PickerNoteMappingOpts
        ---
        ---@field new? string
        ---@field insert_link? string

        ---@class obsidian.config.PickerTagMappingOpts
        ---
        ---@field tag_note? string
        ---@field insert_tag? string

        ---@class obsidian.config.PickerOpts
        ---
        ---@field name obsidian.config.Picker|?
        ---@field note_mappings? obsidian.config.PickerNoteMappingOpts
        ---@field tag_mappings? obsidian.config.PickerTagMappingOpts
        picker = {
            -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
            name = "snacks.pick",
            -- Optional, configure key mappings for the picker.
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

        preferred_link_style = "markdown",

        ---@class obsidian.config.TemplateOpts
        ---
        ---@field folder string|obsidian.Path|?
        ---@field date_format string|?
        ---@field time_format string|?
        --- A map for custom variables, the key should be the variable and the value a function.
        --- Functions are called with obsidian.TemplateContext objects as their sole parameter.
        --- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
        ---@field substitutions table<string, (fun(ctx: obsidian.TemplateContext):string)|(fun(): string)|string>|?
        ---@field customizations table<string, obsidian.config.CustomTemplateOpts>|?
        templates = {
            folder = nil,
            date_format = nil,
            time_format = nil,
            substitutions = {},

            ---@class obsidian.config.CustomTemplateOpts
            ---
            ---@field notes_subdir? string
            ---@field note_id_func? (fun(title: string|?, path: obsidian.Path|?): string)
            customizations = {},
        },

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

        workspaces = {
            {
                name = "personal",
                path = vault_path .. "/Personal",
            },
            {
                name = "rpg",
                path = vault_path .. "/RPG",
            },
        },

    },
}
