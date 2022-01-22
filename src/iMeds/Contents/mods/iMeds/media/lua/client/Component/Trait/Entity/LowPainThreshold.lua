LowPainThreshold = {
    alias = 'LowPainThreshold',
    name = getText('UI_Trait_LowPainThreshold_Name'),
    description = getText('UI_Trait_LowPainThreshold_Description'),
    cost = -6,
    freeRecipes = {},
    xpBoosts = {},
    xpBoostValues = {},
    mutualExclusives = {},
}

ZCore:getContainer():register(
    require 'Component/Trait/Entity/Trait',
    'imeds.trait.entity.low_pain_threshold',
    {
        LowPainThreshold
    },
    'imeds.trait.entity'
)

Events.OnTick.Add(
    function()
        if not getPlayer():HasTrait(LowPainThreshold.alias) then
            return false
        end

        getPlayer():getBodyDamage():setInitialWoundPain(100)
        getPlayer():getBodyDamage():setInitialScratchPain(30)
        getPlayer():getBodyDamage():setInitialThumpPain(25)
        getPlayer():getBodyDamage():setInitialBitePain(40)
        getPlayer():getBodyDamage():setContinualPainIncrease(0.00125)
    end
)