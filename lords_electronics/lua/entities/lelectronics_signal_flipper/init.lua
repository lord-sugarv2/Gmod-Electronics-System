AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/bull/gates/processor_mini.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
	local physics = self:GetPhysicsObject()
	if (physics:IsValid()) then
		physics:Wake()
	end

	self:SetVars(true, true)
	self:SetActiveStatus(false)
end

function ENT:SetActiveStatus(bool)
	bool = not bool
	self:SetActive(bool)

	if bool then
		self:OnActive()
	else
		self:OnDeactivate()
	end

	local output = self:GetOutput()
	if IsValid(output) then
		output:SetActiveStatus(bool) -- Update our child ent 
	end
end