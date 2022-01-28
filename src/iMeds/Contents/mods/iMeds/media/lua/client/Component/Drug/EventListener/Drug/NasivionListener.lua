local normalEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Nasivion.alias] == nil then
        return false
    end

    if Survivor:getBlood():getDrugs()[Nasivion.alias].isActive then
        if not getPlayer():getBodyDamage():isHasACold() then
            return false
        end

        --- 1 - sneeze
        --- 2 - cough
        --- 3 - tissue sneeze
        --- 4 - tissue cough
        if Survivor:getBlood():getDrugs()[Butamirate.alias] ~= nil and Survivor:getBlood():getDrugs()[Butamirate.alias].isActive then
            getPlayer():getBodyDamage():setSneezeCoughActive(5)

            return
        end

        if getPlayer():getBodyDamage():getTimeToSneezeOrCough() <= 1 then
            getPlayer():getBodyDamage():setSneezeCoughActive(5)
        end

        if getPlayer():getBodyDamage():getTimeToSneezeOrCough() <= 1 and getPlayer():getMoodles():getMoodleLevel(MoodleType.HasACold) > 3 then
            getPlayer():getBodyDamage():setSneezeCoughActive(2)

            if getPlayer():hasEquipped('Tissue') then
                getPlayer():getBodyDamage():setSneezeCoughActive(4)
            end
        end

        if getPlayer():IsSpeaking() then
            getPlayer():getBodyDamage():setSneezeCoughActive(0)

            if getPlayer():getMoodles():getMoodleLevel(MoodleType.HasACold) == 2 then
                local result = getPlayer():getBodyDamage():getMildColdSneezeTimerMin() + ZombRand(1, getPlayer():getBodyDamage():getMildColdSneezeTimerMax() - getPlayer():getBodyDamage():getMildColdSneezeTimerMin())
                getPlayer():getBodyDamage():setTimeToSneezeOrCough(result);
            elseif getPlayer():getMoodles():getMoodleLevel(MoodleType.HasACold) == 3 then
                local result = getPlayer():getBodyDamage():getColdSneezeTimerMin() + ZombRand(1, getPlayer():getBodyDamage():getColdSneezeTimerMax() - getPlayer():getBodyDamage():getColdSneezeTimerMin())
                getPlayer():getBodyDamage():setTimeToSneezeOrCough(result);
            elseif getPlayer():getMoodles():getMoodleLevel(MoodleType.HasACold) == 4 then
                local result = getPlayer():getBodyDamage():getNastyColdSneezeTimerMin() + ZombRand(1, getPlayer():getBodyDamage():getNastyColdSneezeTimerMax() - getPlayer():getBodyDamage():getNastyColdSneezeTimerMin())
                getPlayer():getBodyDamage():setTimeToSneezeOrCough(result);
            end
        end
    end
end

local overdoseEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Nasivion.alias] == nil then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Nasivion.alias].isOverdose then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Nasivion.alias].isOverdoseEffectApplied then
        local duration = Nasivion.durationByDosageForm[DosageForm.Intranasal.Drops.alias] / 2 * TimeHandler.durationModifier
        Survivor:getBlood():getDrugs()[Nasivion.alias].duration = Survivor:getBlood():getDrugs()[Nasivion.alias].duration - duration

        Survivor:getBlood():getDrugs()[Nasivion.alias].isOverdoseEffectApplied = true
    end
end

Events.OnTick.Add(normalEffect)
Events.OnTick.Add(overdoseEffect)