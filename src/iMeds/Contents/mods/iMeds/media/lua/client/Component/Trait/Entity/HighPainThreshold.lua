HighPainThreshold = {
    alias = 'HighPainThreshold',
    name = getText('UI_Trait_HighPainThreshold_Name'),
    description = getText('UI_Trait_HighPainThreshold_Description'),
    cost = 6,
    freeRecipes = {},
    xpBoosts = {},
    xpBoostValues = {},
    mutualExclusives = {
        'LowPainThreshold',
    },
}

ZCore:getContainer():register(
    require 'Component/Trait/Entity/Trait',
    'imeds.trait.entity.high_pain_threshold',
    {
        HighPainThreshold
    },
    'imeds.trait.entity'
)

HighPainThreshold.effect = function()
    if Survivor:getPainReduction() < 15 then
        Survivor:setPainReduction(15)
    end

    -- -25% to pain
    getPlayer():getBodyDamage():setInitialWoundPain(60)
    getPlayer():getBodyDamage():setInitialScratchPain(13)
    getPlayer():getBodyDamage():setInitialThumpPain(10)
    getPlayer():getBodyDamage():setInitialBitePain(18)
    getPlayer():getBodyDamage():setContinualPainIncrease(0.00075)
end

local effect = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    if not getPlayer():HasTrait(HighPainThreshold.alias) then
        return false
    end

    HighPainThreshold.effect()
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'Trait' then
        Events.OnTick.Add(effect)
    end
end)