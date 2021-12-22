function initializeSurvivor()
    if getPlayer() and not getPlayer():isDead() and not Survivor:isInitialized() then
        local container = ZCore:getContainer()
        ---@type SurvivorCreator
        local survivorCreator = container:get('imeds.survivor.service.survivor_creator')
        survivorCreator:create()

        Survivor:setIsInitialized(true)

        local logger = container:get('imeds.logger.default')
        logger:info('Survivor successfully created')
    end
end

Events.OnGameStart.Add(initializeSurvivor)
Events.OnCreatePlayer.Add(initializeSurvivor)