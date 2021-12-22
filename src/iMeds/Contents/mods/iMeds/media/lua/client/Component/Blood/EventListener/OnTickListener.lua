local ticksFromPreviousHeartBeat = 0
local lowBloodLossHeartbeatDelay = 100
local moderateBloodLossHeartbeatDelay = 60
local criticalBloodLossHeartbeatDelay = 300

local updateBloodVolume = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    local bloodVolumeReducingModifier = 0
    for _, bodyPartType in pairs(BodyPart) do
        local bodyPart = Survivor:getBodyPartByType(bodyPartType)

        if bodyPart:bleeding() then
            bloodVolumeReducingModifier = bloodVolumeReducingModifier + 0.02
        end

        if bodyPart:bleeding() and (bodyPart:isDeepWounded() or bodyPart:bitten()) then
            bloodVolumeReducingModifier = bloodVolumeReducingModifier + 0.04
        end
    end

    Survivor:getBlood():reduceVolume(bloodVolumeReducingModifier * getGameTime():getMultiplier())

    if bloodVolumeReducingModifier == 0 then
        local hungerLevel = getPlayer():getMoodles():getMoodleLevel(MoodleType.Hungry)
        local thirstLevel = getPlayer():getMoodles():getMoodleLevel(MoodleType.Thirst)
        local bloodVolumeIncreasingModifier = (4 - hungerLevel) / 1200 + (4 - thirstLevel) / 1200
        Survivor:getBlood():addVolume(bloodVolumeIncreasingModifier * getGameTime():getMultiplier())
    end

    if Survivor:getBlood():getVolume() > Blood.maxVolume then
        Survivor:getBlood():setVolume(Blood.maxVolume)
    end

    local bloodLoss = Blood.maxVolume - Survivor:getBlood():getVolume()

    ticksFromPreviousHeartBeat = ticksFromPreviousHeartBeat + 1

    --TODO Вынести в отдельный сервис типа BloodLossHandler
    if bloodLoss > 200 and bloodLoss <= 1500 then
        if Survivor:getFatigue() < 0.6 then
            Survivor:setFatigue(0.6)
        end

        if Survivor:getEndurance() > 0.7 then
            Survivor:setEndurance(0.7)
        end
    elseif bloodLoss > 1500 and bloodLoss <= 2500 then
        if Survivor:getFatigue() < 0.7 then
            Survivor:setFatigue(0.7)
        end

        if Survivor:getEndurance() > 0.4 then
            Survivor:setEndurance(0.4)
        end

        if Survivor:getWetness() < 16 then
            Survivor:setWetness(16)
        end

        if Survivor:getThirst() < 0.15 then
            Survivor:setThirst(0.15)
        end

        --TODO Тахикардия (Вынести в отдельный эффект)
        if ticksFromPreviousHeartBeat > lowBloodLossHeartbeatDelay then
            getSoundManager():playUISound('heart')
            ticksFromPreviousHeartBeat = 0
        end

    elseif bloodLoss > 2500 and bloodLoss <= 3500 then
        --TODO Тахикардия (Вынести в отдельный эффект)
        if ticksFromPreviousHeartBeat > moderateBloodLossHeartbeatDelay then
            getSoundManager():playUISound('heart')
            ticksFromPreviousHeartBeat = 0
        end

        --TODO Ухудшение зрения (Вынести в отдельный эффект)
        if (getCore():getZoom(0) > 0.25) then
            getCore():doZoomScroll(getPlayer():getPlayerNum(), -1)
        end

        Survivor:setFatigue(1)
        Survivor:setEndurance(0)
        Survivor:setStress(1)
        Survivor:setTemperature(34)

        if Survivor:getWetness() < 41 then
            Survivor:setWetness(41)
        end

        if Survivor:getThirst() < 0.26 then
            Survivor:setThirst(0.26)
        end

        getPlayer():setBlockMovement(false)
        getPlayer():setBannedAttacking(false)
    elseif bloodLoss > 3500 and bloodLoss <= 3600 then
        --TODO Брадикардия (Вынести в отдельный эффект)
        if ticksFromPreviousHeartBeat > criticalBloodLossHeartbeatDelay then
            getSoundManager():playUISound('heart')
            ticksFromPreviousHeartBeat = 0
        end

        --TODO Тоже надо выпилить отсюда и оформить нормально
        getPlayer():setBlockMovement(true)
        getPlayer():setBannedAttacking(true)
        getPlayer():reportEvent('EventSitOnGround')

        --TODO Ухудшение зрения (Вынести в отдельный эффект)
        getPlayer():nullifyAiming()
        if (getCore():getZoom(0) > 0.25) then
            getCore():doZoomScroll(getPlayer():getPlayerNum(), -1)
        end
    elseif bloodLoss > 3600 then
        getPlayer():getBodyDamage():ReduceGeneralHealth(150)
    end
end

Events.OnTick.Add(updateBloodVolume)

local resetBloodVolume = function()
    if getPlayer():isGodMod() then
        getPlayer():setBlockMovement(false)
        getPlayer():setBannedAttacking(false)
        Survivor:getBlood():setVolume(Blood.maxVolume)

        ---@type DrugStorage
        local drugStorage = ZCore:getContainer():get('imeds.drug.storage.drug_storage')
        for _, drug in pairs(drugStorage:findAll()) do
            if Survivor:getBlood():getDrugs()[drug:getAlias()] ~= nil then
                Survivor:getBlood():getDrugs()[drug:getAlias()].onset = 0
                Survivor:getBlood():getDrugs()[drug:getAlias()].duration = 0
                Survivor:getBlood():getDrugs()[drug:getAlias()].dose = 0
                Survivor:getBlood():getDrugs()[drug:getAlias()].isActive = false
                Survivor:getBlood():getDrugs()[drug:getAlias()].isOverdose = false
                Survivor:getBlood():getDrugs()[drug:getAlias()].isOverdoseEffectApplied = false
            end
        end
    end
end

Events.OnTick.Add(resetBloodVolume)