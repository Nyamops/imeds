---@type SideEffectStorage
local sideEffectStorage
local tachycardia
local bradycardia
local visualImpairment
local sweating

local updateBloodLossEffects = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    if not SandboxVars.ImmersiveMedicine.IsBloodSystemActive then
        return false
    end

    local bloodLoss = Blood.maxVolume - Survivor:getBlood():getVolume()

    if sideEffectStorage == nil then
        sideEffectStorage = ZCore:getContainer():get('imeds.side_effect.storage.side_effect_storage')
        ---@type SideEffect
        tachycardia = sideEffectStorage:getByAlias(Tachycardia.alias)
        ---@type SideEffect
        bradycardia = sideEffectStorage:getByAlias(Bradycardia.alias)
        ---@type SideEffect
        visualImpairment = sideEffectStorage:getByAlias(VisualImpairment.alias)
        ---@type SideEffect
        sweating = sideEffectStorage:getByAlias(Sweating.alias)
    end

    if bloodLoss > 250 and bloodLoss <= 1000 then
        if Survivor:getFatigue() < 0.6 then
            Survivor:setFatigue(0.6)
        end

        if Survivor:getEndurance() > 0.7 then
            Survivor:setEndurance(0.7)
        end

        Survivor:removeSideEffect(Tachycardia.alias)
        Survivor:removeSideEffect(Sweating.alias)

    elseif bloodLoss > 1000 and bloodLoss <= 2000 then
        if Survivor:getFatigue() < 0.7 then
            Survivor:setFatigue(0.7)
        end

        if Survivor:getEndurance() > 0.4 then
            Survivor:setEndurance(0.4)
        end

        if Survivor:getThirst() < 0.15 then
            Survivor:setThirst(0.15)
        end

        Survivor:addSideEffect(sweating, 1)
        Survivor:addSideEffect(tachycardia, 1)
        Survivor:removeSideEffect(VisualImpairment.alias)

    elseif bloodLoss > 2000 and bloodLoss <= 3500 then
        Survivor:addSideEffect(tachycardia, 2)
        Survivor:addSideEffect(visualImpairment, 1)
        Survivor:addSideEffect(sweating, 2)

        Survivor:setFatigue(1)
        Survivor:setEndurance(0)
        Survivor:setStress(1)
        Survivor:setTemperature(34)

        if Survivor:getThirst() < 0.26 then
            Survivor:setThirst(0.26)
        end

        getPlayer():setBlockMovement(false)
        getPlayer():setBannedAttacking(false)
    elseif bloodLoss > 3500 and bloodLoss <= 3600 then
        Survivor:addSideEffect(bradycardia, 3)
        Survivor:addSideEffect(visualImpairment, 1)

        --TODO Тоже надо выпилить отсюда и оформить нормально
        getPlayer():setBlockMovement(true)
        getPlayer():setBannedAttacking(true)
        getPlayer():reportEvent('EventSitOnGround')

        getPlayer():nullifyAiming()
    elseif bloodLoss > 3600 then
        getPlayer():getBodyDamage():ReduceGeneralHealth(150)
    end
end

Events.OnTick.Add(updateBloodLossEffects)