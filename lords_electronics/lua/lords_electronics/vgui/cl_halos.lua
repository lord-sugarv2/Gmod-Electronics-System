local color_green = Color(100, 255, 100)
local color_red = Color(255, 100, 100)
local val = true
hook.Add("PreDrawHalos", "LElectronics:SelectedHalos", function()
	local ent = LocalPlayer():GetNWEntity("LElectronics:Selected")
    if not IsValid(ent) then val = true return end

    val = false
    halo.Add({ent}, color_green, 5, 5, 2)

    local tr = LocalPlayer():GetEyeTrace().Entity
    if not IsValid(tr) then return end
    if not LElectronics:IsElectronic(tr:GetClass()) then return end

    halo.Add({tr}, color_red, 5, 5, 2)
end)

hook.Add("HUDPaint", "LElectronics:DrawAllHalos", function()
    local tr = LocalPlayer():GetEyeTrace().Entity
    if not IsValid(tr) then return end
    if not LElectronics:IsElectronic(tr:GetClass()) then return end
    if not val then return end

    local tbl = {}
    table.insert(tbl, tr)
    if IsValid(tr:GetOutput()) then table.insert(tbl, tr:GetOutput()) end
    if IsValid(tr:GetInput()) then table.insert(tbl, tr:GetInput()) end
    halo.Add(tbl, color_red, 5, 5, 2)
end)