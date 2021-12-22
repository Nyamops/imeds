local removeProps = function()
    if not getPlayer() or getPlayer():isDead() then
        return false
    end

    if Survivor:haveItem(BloodVolumeReducer.fullType) then
        Survivor:removeItem(BloodVolumeReducer.fullType)

        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:dispatch('onBloodVolumeReducerDelete', {})
    end

    if Survivor:haveItem(BloodVolumeIncreaser.fullType) then
        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:dispatch(
            'onBloodVolumeIncreaserDelete',
            Survivor:getItem(BloodVolumeIncreaser.fullType):getModData()
        )

        Survivor:removeItem(BloodVolumeIncreaser.fullType)
    end

    if Survivor:haveItem(BloodTester.fullType) then
        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:dispatch('onBloodTesterDelete', {})

        Survivor:removeItem(BloodTester.fullType)
    end
end

Events.OnTickEvenPaused.Add(removeProps)