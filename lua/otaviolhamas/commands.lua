local commands = {
    {
        name = "BufferKill",
        fn = function(opts)
            local kill_command = opts.fargs[1]
            local bufnr = tonumber(opts.fargs[2])
            local force = opts.fargs[3] == "true"

            require('otaviolhamas.global').buf_kill(kill_command, bufnr, force)
        end,
        opts = {
            nargs = '*',
        }
    },
}

local function load(collection)
    local common_opts = { force = true }
    for _, cmd in pairs(collection) do
        local opts = vim.tbl_deep_extend("force", common_opts, cmd.opts or {})
        vim.api.nvim_create_user_command(cmd.name, cmd.fn, opts)
    end
end

load(commands)
