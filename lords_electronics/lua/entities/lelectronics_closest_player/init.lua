AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/jaanus/wiretool/wiretool_siren.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
	local physics = self:GetPhysicsObject()
	if (physics:IsValid()) then
		physics:Wake()
	end

	self.Timer = 0

	self:SetVars(true, true)
end

-- i aint calling player.GetAll every tick cuz i dont want lag
function ENT:Think()
	if not self:GetActive() then return end
	if CurTime() > self.Timer then
		self.Timer = CurTime() + 2 -- Update every 2 seconds

		local entpos = self:GetPos()
		local ply = {false, math.huge}
		for k, v in ipairs(player.GetAll()) do
			local dist = v:GetPos():Distance(entpos)
			if dist < ply[2] then ply = {v, dist} end
		end

		if not ply then return end
		self:SetClosestPlayer(ply[1])
		if IsValid(self:GetOutput()) then
			self:GetOutput():SetData(ply[1])
		end
	end
end

function ENT:OnDeactivate()
	if IsValid(self:GetOutput()) then
		self:GetOutput():SetData(nil)
	end
end