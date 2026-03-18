local EZ = require(game.ReplicatedStorage.EZVisualize.EZVisualizer)

task.wait(5)

local model = workspace.VModel
local sound = workspace.SpawnLocation["Empty Heartbeat"]

EZ.Register(model, sound)
EZ.Start()
