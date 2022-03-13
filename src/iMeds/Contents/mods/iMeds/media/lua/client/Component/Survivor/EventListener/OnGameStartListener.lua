local isInitialized = false
local initializeSurvivor = function()
    if Survivor:isDeadOrNotExist() then
        return false
    end

    if not Survivor:isInitialized() then
        local container = ZCore:getContainer()
        ---@type SurvivorCreator
        local survivorCreator = container:get('imeds.survivor.service.survivor_creator')
        survivorCreator:create()

        Survivor:setIsInitialized(true)

        local logger = container:get('imeds.logger.default')
        logger:info('Survivor successfully created')
    end

    if not isInitialized then
        triggerEvent(ImmersiveMedicineEvent.iMedsSurvivorCreated, iMedsComponent.Drug);
        triggerEvent(ImmersiveMedicineEvent.iMedsSurvivorCreated, iMedsComponent.Moodle);
        triggerEvent(ImmersiveMedicineEvent.iMedsSurvivorCreated, iMedsComponent.SideEffect);
        triggerEvent(ImmersiveMedicineEvent.iMedsSurvivorCreated, iMedsComponent.Trait);
        triggerEvent(ImmersiveMedicineEvent.iMedsSurvivorCreated, iMedsComponent.Blood);
        isInitialized = true
    end
end

Events.OnPlayerDeath.Add(function() isInitialized = false end)
Events.OnGameStart.Add(initializeSurvivor)
Events.OnCreatePlayer.Add(initializeSurvivor)