local isConfigReceived = false

Events.OnGameStart.Add(
    function()
        if SandboxVars.IsBloodSystemActive == nil then
            SandboxVars.IsBloodSystemActive = true
        end

        if SandboxVars.IsBloodTypeSystemActive == nil then
            SandboxVars.IsBloodTypeSystemActive = true
        end

        isConfigReceived = false
    end
)

if not isClient() then
    return
end

Events.OnTick.Add(
    function()
        if not isConfigReceived and getPlayer() and getPlayer():getOnlineID() then
            sendClientCommand(getPlayer(), 'configurator', 'getImmersiveMedicineConfig', { id = getPlayer():getOnlineID() })
            isConfigReceived = true
        end
    end
)