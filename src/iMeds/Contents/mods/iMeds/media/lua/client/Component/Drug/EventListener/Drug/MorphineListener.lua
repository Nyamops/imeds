local normalEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Morphine.alias] == nil then
        return false
    end

    if Survivor:getBlood():getDrugs()[Morphine.alias].isActive then
        for _, index in pairs(BodyPart) do
            Survivor:setAdditionalBodyPartPainByType(index, 0)
        end

        Survivor:setPainReduction(70)
        Survivor:setStress(0)
        Survivor:setUnhappynessLevel(0)
        Survivor:setBoredomLevel(0)
        Survivor:setPanic(0)

        local drunkenness = Survivor:getBlood():getDrugs()[Morphine.alias].dose * 50
        if drunkenness > 100 then
            drunkenness = 100
        end

        Survivor:setDrunkenness(drunkenness)
    end
end

local overdoseEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Morphine.alias] == nil then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Morphine.alias].isOverdose then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Morphine.alias].isOverdoseEffectApplied then
        Survivor:setFoodSicknessLevel(100)
        Survivor:setPoisonLevel(60)
        Survivor:setEndurance(0)
        Survivor:setFatigue(1)

        Survivor:getBlood():getDrugs()[Morphine.alias].isOverdoseEffectApplied = true
    end
end

Events.OnTick.Add(normalEffect)
Events.OnTick.Add(overdoseEffect)