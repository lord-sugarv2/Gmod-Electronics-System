net.Receive("LElectronics:Notify", function()
    local message = net.ReadString()
    notification.AddLegacy("[LElectronics] "..message, NOTIFY_ERROR, 3)
end)