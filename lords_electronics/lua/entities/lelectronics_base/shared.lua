ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "LElectronics Base"
ENT.Spawnable = false
ENT.Category = "LElectronics"

LElectronics:AddElectronic(string.Replace(ENT.Folder, "entities/", ""))

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Output")
    self:NetworkVar("Entity", 1, "Input")
    self:NetworkVar("Bool", 0, "HasOutput")
    self:NetworkVar("Bool", 1, "HasInput")
    self:NetworkVar("Bool", 2, "Active")
end