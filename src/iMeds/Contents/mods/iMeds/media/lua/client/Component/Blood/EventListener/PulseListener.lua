local incrementValue = 0.04
local tachycardiaPulse = { 90, 120, 160 }
local bradycardiaPulse = { 60, 35, 5 }

local updatePulse = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    local requestedPulse = Blood.pulse.normal
    local endurancePulse
    local panicPulse

    local modifier = Blood.pulse.max - Blood.pulse.min
    -- y = (1 - endurance) * x + 50
    endurancePulse = (1 - Survivor:getEndurance()) * modifier + Blood.pulse.normal
    panicPulse = Survivor:getPanic() * modifier / 100 + Blood.pulse.normal

    requestedPulse = endurancePulse > panicPulse and endurancePulse or panicPulse

    local tachycardia = Survivor:getSideEffects()[Tachycardia.alias]
    if tachycardia ~= nil and tachycardia.isActive then
        requestedPulse = tachycardiaPulse[tachycardia.level] > requestedPulse and tachycardiaPulse[tachycardia.level] or requestedPulse
    end

    local bradycardia = Survivor:getSideEffects()[Bradycardia.alias]
    if bradycardia ~= nil and bradycardia.isActive then
        requestedPulse = bradycardiaPulse[bradycardia.level]
    end

    local pulse = Blood.pulse.normal
    if Survivor:getBlood():getPulse() < requestedPulse then
        pulse = Survivor:getBlood():getPulse() + incrementValue * getGameTime():getMultiplier()
    else
        pulse = Survivor:getBlood():getPulse() - incrementValue * getGameTime():getMultiplier()
    end

    Survivor:getBlood():setPulse(pulse)

    if Survivor:getBlood():getPulse() < Blood.pulse.min then
        Survivor:getBlood():setPulse(Blood.pulse.min)
    end

    if Survivor:getBlood():getPulse() > Blood.pulse.max then
        Survivor:getBlood():setPulse(Blood.pulse.max)
    end
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function()
    Events.OnTick.Add(updatePulse)
end)