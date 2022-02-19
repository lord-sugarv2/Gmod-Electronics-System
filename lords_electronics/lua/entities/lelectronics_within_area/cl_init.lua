include("shared.lua")
function ENT:Draw()
    self:DrawModel()
end

concommand.Add("LElectronics.DrawSphere", function()
    LElectronics.DrawSphere = not LElectronics.DrawSphere
end)

hook.Add("PostDrawTranslucentRenderables", "LElectronics:DrawSpher", function()
    for k, v in ipairs(ents.FindByClass("lelectronics_within_area")) do
        if not LElectronics.DrawSphere then return end
        render.SetColorMaterial()
        render.DrawSphere(v:GetPos(), v.WithinRange, 30, 30, Color(0, 175, 175, 100))
        render.DrawSphere(v:GetPos(), -v.WithinRange, 30, 30, Color(0, 175, 175, 100))
    end
end)