local removeSideEffect = function()
    if not getSpecificPlayer(0) or getSpecificPlayer(0):isDead() or not Survivor:isInitialized() then
        return false
    end

    ---@type SideEffectStorage
    local sideEffectStorage = ZCore:getContainer():get('imeds.side_effect.storage.side_effect_storage')

    for _, sideEffect in pairs(sideEffectStorage:findAll()) do
        Survivor:removeSideEffect(sideEffect:getAlias())
    end
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'SideEffect' then
        Events.OnTick.Add(removeSideEffect)
    end
end)