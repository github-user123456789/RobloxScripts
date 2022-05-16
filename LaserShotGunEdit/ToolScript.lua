-----------------
--| Constants |--
-----------------

local SHOT_SPEED =250
local SHOT_TIME = 1

local NOZZLE_OFFSET = Vector3.new(0, 0.4, -1.1)

-----------------
--| Variables |--
-----------------

local PlayersService = Game:GetService('Players')
local DebrisService = Game:GetService('Debris')

local Tool = script.Parent
local Handle = Tool:WaitForChild('Handle')

local FireSound = Handle:WaitForChild('Fire')
local ReloadSound = Handle:WaitForChild('Reload')
local HitFadeSound = script:WaitForChild('HitFade')

local PointLight = Handle:WaitForChild('PointLight')

local Character = nil
local Humanoid = nil
local Player = nil

local BaseShot = nil

local function OnEquipped()
	Character = Tool.Parent
	Humanoid = Character:WaitForChild('Humanoid')
	Player = PlayersService:GetPlayerFromCharacter(Character)
end

local function OnActivated()
	if Tool.Enabled and Humanoid.Health > 0 then
		Tool.Enabled = false
		
		script:WaitForChild'RemoteEvent':FireServer(SHOT_SPEED, SHOT_TIME, Player:GetMouse().Hit.p)
		wait(1.25)

		Tool.Enabled = true
	end
end

local function OnUnequipped()
	
end

--------------------
--| Script Logic |--
--------------------

Tool.Equipped:connect(OnEquipped)
Tool.Unequipped:connect(OnUnequipped)
Tool.Activated:connect(OnActivated)
