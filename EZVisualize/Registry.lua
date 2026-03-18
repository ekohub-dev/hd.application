--!optimize 2
--!strict

local Registry = {}

function Registry.new()
	return {
		Sound = nil,
		Bars = {},
		Value = 0,
	}
end

return Registry
