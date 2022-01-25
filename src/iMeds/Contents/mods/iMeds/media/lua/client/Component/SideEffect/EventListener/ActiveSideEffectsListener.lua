local removeSideEffect = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    Survivor:removeSideEffect(Sweating.alias)
    Survivor:removeSideEffect(Tachycardia.alias)
    Survivor:removeSideEffect(Bradycardia.alias)
    Survivor:removeSideEffect(VisualImpairment.alias)
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'SideEffect' then
        Events.OnTick.Add(removeSideEffect)
    end
end)