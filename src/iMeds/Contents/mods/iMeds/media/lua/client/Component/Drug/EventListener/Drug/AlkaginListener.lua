local normalEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Alkagin.alias] == nil then
        return false
    end

    if Survivor:getBlood():getDrugs()[Alkagin.alias].isActive then
        Survivor:setPainReductionFromMeds(35)
    end
end

local overdoseEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Alkagin.alias] == nil then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Alkagin.alias].isOverdose then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Alkagin.alias].isOverdoseEffectApplied then
        Survivor:setFoodSicknessLevel(80)

        Survivor:getBlood():getDrugs()[Alkagin.alias].isOverdoseEffectApplied = true
    end
end

Events.OnTick.Add(normalEffect)
Events.OnTick.Add(overdoseEffect)