local isConfigReceived = false
Events.OnTick.Add(
    function()
        if not isConfigReceived and getPlayer() and getPlayer():getOnlineID() then
            sendClientCommand(getPlayer(), 'configurator', 'getImmersiveMedicineConfig', { id = getPlayer():getOnlineID() })
            isConfigReceived = true
        end
    end
)