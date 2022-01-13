local normalEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Erythropoietin.alias] == nil then
        return false
    end

    if Survivor:getBlood():getDrugs()[Erythropoietin.alias].isActive then
        Survivor:setEndurance(Survivor:getEndurance() + 0.002 * getGameTime():getMultiplier())
    end
end

local overdoseEffect = function()
    if not Survivor:isInitialized() or Survivor:getBlood():getDrugs()[Erythropoietin.alias] == nil then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Erythropoietin.alias].isOverdose then
        return false
    end

    if not Survivor:getBlood():getDrugs()[Erythropoietin.alias].isOverdoseEffectApplied then
        Survivor:setEndurance(0.15)
        Survivor:setFatigue(0.6)
    end
end

Events.OnTick.Add(normalEffect)
Events.OnTick.Add(overdoseEffect)