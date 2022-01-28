local normalEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Umifenovir.alias] == nil then
        return false
    end

    if Survivor:getBlood():getDrugs()[Umifenovir.alias].isActive then
        if Survivor:isInfected() and Survivor:getInfectionMortalityDuration() < 100 then
            local mortalityDuration = Survivor:getInfectionMortalityDuration() + 0.0001 * getGameTime():getMultiplier()
            Survivor:setInfectionMortalityDuration(mortalityDuration)
        end

        if Survivor:getInfectionMortalityDuration() > 100 then
            Survivor:setInfectionMortalityDuration(100)
        end
    end
end

local overdoseEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Umifenovir.alias] == nil then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Umifenovir.alias].isOverdose then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Umifenovir.alias].isOverdoseEffectApplied then
        local duration = Umifenovir.durationByDosageForm[DosageForm.Oral.Pill.alias] / 2 * TimeHandler.durationModifier
        Survivor:getBlood():getDrugs()[Umifenovir.alias].duration = Survivor:getBlood():getDrugs()[Umifenovir.alias].duration - duration

        Survivor:getBlood():getDrugs()[Umifenovir.alias].isOverdoseEffectApplied = true
    end
end

Events.OnTick.Add(normalEffect)
Events.OnTick.Add(overdoseEffect)