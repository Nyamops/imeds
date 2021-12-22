Pharmacist = {
    alias = 'Pharmacist',
    name = getText('UI_Trait_Pharmacist_Name'),
    description = getText('UI_Trait_Pharmacist_Description'),
    cost = 6,
    freeRecipes = {},
    freeTraits = {},
    xpBoosts = {},
    xpBoostValues = {},
    mutualExclusives = {
        'Illiterate',
    },
}

ZCore:getContainer():register(
    require 'Component/Trait/Entity/Trait',
    'imeds.trait.entity.pharmacist',
    {
        Pharmacist
    },
    'imeds.trait.entity'
)