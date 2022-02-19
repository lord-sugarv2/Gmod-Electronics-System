AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/bull/gates/processor.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
	local physics = self:GetPhysicsObject()
	if (physics:IsValid()) then
		physics:Wake()
	end

	self:SetVars(true, true)
end

-- self.Data is equivilent of calling self:GetData()
function ENT:Think()
	if not self:GetActive() then return end
	if not self.Data then return end
	if not IsValid(self.Data) then return end
	if not self.Data:IsPlayer() then return end

	if IsValid(self:GetOutput()) then
		self:GetOutput():SetData(self.Data:Nick())
	end
end