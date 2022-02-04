local removeProps = function()
    if not getSpecificPlayer(0) or getSpecificPlayer(0):isDead() then
        return false
    end

    if Survivor:haveItem(DrugApplier.fullType) then
        triggerEvent(ImmersiveMedicineEvent.iMedsDrugApplierDeleted, Survivor:getItem(DrugApplier.fullType):getModData())

        Survivor:removeItem(DrugApplier.fullType)
    end
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'Drug' then
        Events.OnTickEvenPaused.Add(removeProps)
    end
end)
