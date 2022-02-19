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

function ENT:Think()
	if not self:GetActive() then return end
	local val = false
	local tbl = {}
	if CurTime() > self.Timer then
		for k, v in ipairs(ents.FindInSphere(self:GetPos(), self.WithinRange)) do
			if not v:IsPlayer() then continue end
			val = true
			table.insert(tbl, v)
		end
		self.Timer = CurTime() + 2
		
		local output = self:GetOutput()
		if not IsValid(output) then return end
		if val then
			output:SetData(true)
			output:SetActiveStatus(true)
		else
			output:SetData(false)
			output:SetActiveStatus(false)
		end
	end
end