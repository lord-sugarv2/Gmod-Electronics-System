local function TextW(text)
    surface.SetFont("DermaLarge")
    local w, h = surface.GetTextSize(text)
    return w
end
hook.Add("HUDPaint", "LElectronics:DrawInfo", function()
    local ply = LocalPlayer()
    local tr = ply:GetEyeTrace()
    local ent = tr.Entity
    if not IsValid(ent) then return end
    if not LElectronics:IsElectronic(ent:GetClass()) then return end

    local w, h = ScrW(), ScrH()
    local width, tall = 300, 40
    if ent:GetHasInput() then tall = tall + 35 end
    if ent:GetHasOutput() then tall = tall + 35 end

    local input = ent:GetInput()
    local txt1 = "Input: "..(IsValid(input) and input.PrintName or "N/A")
    local new = TextW(txt1)

    local output = ent:GetOutput()
    local txt2 = "Output: "..(IsValid(output) and output.PrintName or "N/A")
    if TextW(txt2) > new then new = TextW(txt2) end
    new = math.max(width, new) + 50

    surface.SetDrawColor(0, 0, 0, 100)
    surface.DrawRect((w/2)-(new/2), 300, new, tall)

    local int = 5
    local ew = 0
    if ent:GetHasInput() then
        draw.SimpleText(txt1, "DermaLarge", w/2, 300+int, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        int = int + 35
    end

    if ent:GetHasOutput() then
        draw.SimpleText(txt2, "DermaLarge", w/2, 300+int, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        int = int + 35
    end

    draw.SimpleText("State: "..(ent:GetActive() and "on" or "off"), "DermaLarge", w/2, 300+int, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
end)