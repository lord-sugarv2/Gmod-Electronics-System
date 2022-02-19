AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/bull/gates/resistor.mdl")
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

function ENT:SetActiveStatus(bool, output)
	self:SetActive(bool)

	timer.Simple(self.TimerTime, function()
		if not IsValid(self) then
			if IsValid(output) then
				output:SetActiveStatus(bool) -- Update our child ent 
			end
			return
		end

		if bool then
			self:OnActive()
		else
			self:OnDeactivate()
		end

		local output = self:GetOutput()
		if IsValid(output) then
			output:SetActiveStatus(bool) -- Update our child ent 
		end
	end)
end

function ENT:OnRemove()
	-- If we are giving to an entity then stop that connection
	local output = self:GetOutput()
	if IsValid(output) then
		output:SetActiveStatus(false, output) -- Make the ent have no power
		output:SetInput(nil) -- Make it so the ent has no input
	end

	local input = self:GetInput()
	if IsValid(input) then
		input:SetOutput(nil) -- Get the ent that is giving us power and make it so we dont exist
	end
end