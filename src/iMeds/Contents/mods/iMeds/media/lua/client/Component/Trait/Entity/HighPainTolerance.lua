HighPainTolerance = {
    alias = 'HighPainTolerance',
    name = getText('UI_Trait_HighPainTolerance_Name'),
    description = getText('UI_Trait_HighPainTolerance_Description'),
    cost = 6,
    freeRecipes = {},
    freeTraits = {},
    xpBoosts = {},
    xpBoostValues = {},
    mutualExclusives = {
        'LowPainTolerance',
    },
}

ZCore:getContainer():register(
    require 'Component/Trait/Entity/Trait',
    'imeds.trait.entity.high_pain_tolerance',
    {
        HighPainTolerance
    },
    'imeds.trait.entity'
)

Events.OnTick.Add(
    function()
        if not getPlayer():HasTrait(HighPainTolerance.alias) then
            return false
        end

        if Survivor:getPainReduction() < 20 then
            Survivor:setPainReduction(20)
        end
    end
)