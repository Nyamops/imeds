local removeProps = function()
    if not getPlayer() or getPlayer():isDead() then
        return false
    end

    if Survivor:haveItem(DrugApplier.fullType) then
        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:dispatch(
            'onDrugApplierDelete',
            Survivor:getItem(DrugApplier.fullType):getModData()
        )

        Survivor:removeItem(DrugApplier.fullType)
    end
end

Events.OnTickEvenPaused.Add(removeProps)