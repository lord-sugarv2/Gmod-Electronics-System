hook.Add("HUDPaint", "LElectronics:DrawInfo", function()
    local ply = LocalPlayer()
    local tr = ply:GetEyeTrace()
    local ent = tr.Entity
    if not IsValid(ent) then return end
    if not LElectronics:IsElectronic(ent:GetClass()) then return end

    local w, h = ScrW(), ScrH()
    local width, tall = 300, 0
    if ent:GetHasInput() then tall = tall + 35 end
    if ent:GetHasOutput() then tall = tall + 35 end
    tall = tall + 35 -- Active Section

    surface.SetDrawColor(0, 0, 0, 100)
    surface.DrawRect((w/2)-(width/2), 300, width, tall)

    local int = 5
    if ent:GetHasInput() then
        local input = ent:GetInput()
        draw.SimpleText("Input: "..(IsValid(input) and input.PrintName or "N/A"), "DermaLarge", w/2, 300+int, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        int = int + 35
    end

    if ent:GetHasOutput() then
        local output = ent:GetOutput()
        draw.SimpleText("Output: "..(IsValid(output) and output.PrintName or "N/A"), "DermaLarge", w/2, 300+int, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        int = int + 35
    end

    draw.SimpleText("State: "..(ent:GetActive() and "on" or "off"), "DermaLarge", w/2, 300+int, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)

end)