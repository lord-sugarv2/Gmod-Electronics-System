include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    local angle = self:GetAngles()
    angle:RotateAroundAxis(angle:Up(), 180)
    angle:RotateAroundAxis(angle:Right(), 90)

    cam.Start3D2D(self:GetPos()+(self:GetForward()*.15), angle, .2)
        draw.SimpleText(self:GetText(), "Trebuchet18", 65, -4, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()
end