require('config.lazy')

local function load(name)
	local Util = require('lazy.core.util')
	Util.try(function()
		require(name)
	end, {
		msg = 'Failed loading ' .. name,
		on_error = function(msg)
			local info = require('lazy.core.cache')
			if info == nil or (type(info) == 'table' and #info == 0) then
				return
			end
			Util.error(msg)
		end,
	})

end

load('config.keymaps')
load('config.options')
load('config.autocommands')
