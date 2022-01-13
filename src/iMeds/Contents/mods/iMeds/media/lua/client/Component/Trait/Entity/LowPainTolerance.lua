LowPainTolerance = {
    alias = 'LowPainTolerance',
    name = getText('UI_Trait_LowPainTolerance_Name'),
    description = getText('UI_Trait_LowPainTolerance_Description'),
    cost = -4,
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