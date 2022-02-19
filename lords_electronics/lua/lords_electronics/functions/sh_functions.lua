function LElectronics:AddElectronic(class, name)
    LElectronics.Electronics[class] = true
end

function LElectronics:IsElectronic(class)
    local info = LElectronics.Electronics[class]
    return info and true or false
end

function LElectronics:GoodDist(ply, ent)
    if ply:GetPos():Distance(ent:GetPos()) > 100 then return false end
    return true
end

function LElectronics:TraceIsEnt(ply, ent)
    local tr = ply:GetEyeTrace().Entity
    if tr == ent then return true end
end