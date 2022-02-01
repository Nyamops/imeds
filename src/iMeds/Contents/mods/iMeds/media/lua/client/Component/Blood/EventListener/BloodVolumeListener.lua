local updateBloodVolume = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    if not SandboxVars.ImmersiveMedicine.IsBloodSystemActive then
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
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'Blood' then
        Events.OnTick.Add(updateBloodVolume)
    end
end)

