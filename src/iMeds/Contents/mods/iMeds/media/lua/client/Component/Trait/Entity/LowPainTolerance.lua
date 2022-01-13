LowPainTolerance = {
    alias = 'LowPainTolerance',
    name = getText('UI_Trait_LowPainTolerance_Name'),
    description = getText('UI_Trait_LowPainTolerance_Description'),
    cost = -6,
    freeRecipes = {},
    freeTraits = {},
    xpBoosts = {},
    xpBoostValues = {},
    mutualExclusives = {
        'HighPainTolerance',
    },
}

ZCore:getContainer():register(
    require 'Component/Trait/Entity/Trait',
    'imeds.trait.entity.low_pain_tolerance',
    {
        LowPainTolerance
    },
    'imeds.trait.entity'
)

Events.OnTick.Add(
    function()
        if not getPlayer():HasTrait(LowPainTolerance.alias) then
            return false
        end

        -- +25% to pain
        getPlayer():getBodyDamage():setInitialWoundPain(100)
        getPlayer():getBodyDamage():setInitialScratchPain(23)
        getPlayer():getBodyDamage():setInitialThumpPain(18)
        getPlayer():getBodyDamage():setInitialBitePain(31)
        getPlayer():getBodyDamage():setContinualPainIncrease(0.00125)
    end
)