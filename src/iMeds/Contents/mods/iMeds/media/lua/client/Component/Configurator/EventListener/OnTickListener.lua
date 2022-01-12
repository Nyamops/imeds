if isClient() or isServer() then
    return
end

Events.OnGameStart.Add(
    function()
        if SandboxVars.ImmersiveMedicine.IsBloodSystemActive == nil then
            SandboxVars.ImmersiveMedicine.IsBloodSystemActive = true
        end

        if SandboxVars.ImmersiveMedicine.IsBloodTypeSystemActive == nil then
            SandboxVars.ImmersiveMedicine.IsBloodTypeSystemActive = true
        end
    end
)