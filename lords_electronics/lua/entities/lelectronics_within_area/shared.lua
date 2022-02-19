ENT.Type = "anim"
ENT.Base = "lelectronics_base"
ENT.Spawnable = true
ENT.Category = "LElectronics"
ENT.WithinRange = 150
ENT.PrintName = "Within "..ENT.WithinRange.." units"

LElectronics:AddElectronic(string.Replace(ENT.Folder, "entities/", ""))

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Output")
    self:NetworkVar("Entity", 1, "Input")
    self:NetworkVar("Bool", 0, "HasOutput")
    self:NetworkVar("Bool", 1, "HasInput")
    self:NetworkVar("Bool", 2, "Active")
end