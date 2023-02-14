local commands = {
    {
        name = "BufferKill",
        fn = function()
            require('otaviolhamas.global').buf_kill('bd')
        end,
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

