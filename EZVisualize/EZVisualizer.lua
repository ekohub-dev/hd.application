--!optimize 2
--!nonstrict

local RunService = game:GetService("RunService")

local Vars = require(script.Vars)
local Registry = require(script.Registry)

local EZ = {}

local Items = {}

local function map(v: number)
	return math.clamp((v / 1000) * Vars.Sensitivity, 0, 1)
end

local function resize(bar: BasePart, height: number)
	local y = bar.Size.Y
	bar.Size = Vector3.new(bar.Size.X, height, bar.Size.Z)
	bar.CFrame *= CFrame.new(0, (height - y) * 0.5, 0)
end

function EZ.Register(model: Model, sound: Sound)
	if not model or not sound then return end

	local data = Registry.new()
	data.Sound = sound

	for _, v in model:GetChildren() do
		if v:IsA("BasePart") then
			data.Bars[#data.Bars + 1] = v
		end
	end

	if #data.Bars == 0 then return end

	Items[model] = data
end

function EZ.Unregister(model: Model)
	Items[model] = nil
end

local running = false

function EZ.Start()
	if running then return end
	running = true

	RunService.Heartbeat:Connect(function()
		for _, data in Items do
			local s = data.Sound
			if not s or not s.IsPlaying then continue end

			local target = map(s.PlaybackLoudness)
			data.Value += (target - data.Value) * Vars.Smoothing

			local h = Vars.MinHeight + Vars.MaxHeight * data.Value

			for _, bar in data.Bars do
				resize(bar, h)
			end
		end
	end)
end

return EZ
