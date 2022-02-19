function LElectronics:Use(ply, ent)
    if IsValid(ply.LElectronicsEnt) and ply.LElectronicsEnt ~= ent and ent:GetHasInput() then
        LElectronics:EndTouch(ply, ent)
    else
        LElectronics:StartTouch(ply, ent)
    end
end

function LElectronics:StartTouch(ply, ent)
    if not IsValid(ent) then return end
    if ent:GetHasOutput() == false then return end -- If we dont have an output then we cant connect to anything
    ply.LElectronicsEnt = ent
end

function LElectronics:EndTouch(ply, ent)
    if not IsValid(ent) then return end -- Check if child is ok
    if not IsValid(ply.LElectronicsEnt) then return end -- Check if parent is ok
    if ent:GetHasInput() == false then return end -- If we dont have an input then we cant get a parent ):
    if ply.LElectronicsEnt:GetInput() == ent then return end

    ent:SetInput(ply.LElectronicsEnt) -- Set our parent
    ent:SetActiveStatus(ply.LElectronicsEnt:GetActive()) -- Set the child active / deactive
    ply.LElectronicsEnt:SetOutput(ent) -- Give the parent a child

    ply.LElectronicsEnt = false
end