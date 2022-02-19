AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/bull/various/subwoofer.mdl")
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

function ENT:Think()
	if not self:GetActive() then return end
	if CurTime() > self.Timer then
		self:EmitSound("buttons/button17.wav")
		self.Timer = CurTime() + 2
	end
end