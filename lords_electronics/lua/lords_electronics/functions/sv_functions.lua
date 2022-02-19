util.AddNetworkString("LElectronics:Notify")
function LElectronics:Notify(ply, message)
    net.Start("LElectronics:Notify")
    net.WriteString(message)
    net.Send(ply)
end
function LElectronics:Use(ply, ent)
    if ply.LElectronicsEnt == ent then
        -- if we pressed again then deselect
        ply.LElectronicsEnt = false
        ply:SetNWEntity("LElectronics:Selected", false)
        return
    end

    if IsValid(ply.LElectronicsEnt) then
        if not ent:GetHasInput() then
            LElectronics:Notify(ply, "Ent dosnt have an input!")
            return
        end
        LElectronics:EndTouch(ply, ent)
    else
        LElectronics:StartTouch(ply, ent)
    end
end

function LElectronics:StartTouch(ply, ent)
    if not IsValid(ent) then return end
    if ent:GetHasOutput() == false then return end -- If we dont have an output then we cant connect to anything
    ply.LElectronicsEnt = ent
    ply:SetNWEntity("LElectronics:Selected", ent)
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
    ply:SetNWEntity("LElectronics:Selected", false)
    LElectronics:Notify(ply, "Connection has been made!")
end

function LElectronics:Explode(ent)
	ent:EmitSound("ambient/explosions/explode_4.wav")

	local detonate = ents.Create("env_explosion")
	detonate:SetOwner(ent)
	detonate:SetPos(ent:GetPos())
	detonate:SetKeyValue("iMagnitude", "100")
	detonate:Spawn()
	detonate:Activate()
	detonate:Fire("Explode", "", 0)
	
	local shake = ents.Create("env_shake")
	shake:SetOwner(ent)
	shake:SetPos(ent:GetPos())
	shake:SetKeyValue("amplitude", "2000")
	shake:SetKeyValue("radius", "200")
	shake:SetKeyValue("duration", "2.5")
	shake:SetKeyValue("frequency", "255")
	shake:SetKeyValue("spawnflags", "4")
	shake:Spawn()
	shake:Activate()
	shake:Fire("StartShake", "", 0)
end