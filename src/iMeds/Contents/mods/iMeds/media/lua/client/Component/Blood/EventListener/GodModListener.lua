---@type SideEffectStorage
local sideEffectStorage

local resetAll = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    if getPlayer():isGodMod() then
        if sideEffectStorage == nil then
            sideEffectStorage = ZCore:getContainer():get('imeds.side_effect.storage.side_effect_storage')
        end

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

        for _, sideEffect in pairs(sideEffectStorage:findAll()) do
            if Survivor:getSideEffects()[sideEffect:getAlias()] ~= nil then
                Survivor:removeSideEffect(sideEffect:getAlias())
            end
        end

        Survivor:setStressFromOpioidAddiction(0)
        Survivor:getBlood():setOpiatePoisonLevel(0)
    end
end

Events.OnTick.Add(resetAll)