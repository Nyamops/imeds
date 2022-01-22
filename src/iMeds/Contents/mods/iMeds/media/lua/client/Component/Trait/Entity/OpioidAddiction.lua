OpioidAddiction = {
    alias = 'OpioidAddiction',
    name = getText('UI_Trait_OpioidAddiction_Name'),
    description = getText('UI_Trait_OpioidAddiction_Description'),
    cost = -12,
    freeRecipes = {},
    xpBoosts = {
        Perks.Doctor,
        Perks.Strength,
        Perks.Fitness,
    },
    xpBoostValues = {
        [Perks.Doctor] = 1,
        [Perks.Strength] = -2,
        [Perks.Fitness] = -2,
    },
    mutualExclusives = {
        'HighPainThreshold',
        'LowPainThreshold',
        'FastHealer',
        'FastLearner',
        'Strong',
        'Athletic',
        'Graceful',
        'Obese',
        'Overweight',
        'Fit',
    },
}

ZCore:getContainer():register(
    require 'Component/Trait/Entity/Trait',
    'imeds.trait.entity.opioid_addiction',
    {
        OpioidAddiction
    },
    'imeds.trait.entity'
)

Events.OnTick.Add(
    function()
        if not getPlayer():HasTrait(OpioidAddiction.alias) then
            return false
        end

        if Survivor:getBlood():getDrugs()[Morphine.alias] == nil then
            return false
        end

        if not Survivor:getBlood():getDrugs()[Morphine.alias].isActive then
            return false
        end

        Survivor:setStressFromOpiateAddiction(Survivor:getStressFromOpiateAddiction() + 0.000003 * getGameTime():getMultiplier())

        if Survivor:getStressFromOpiateAddiction() > 25 then
            Survivor:setUnhappynessLevel(Survivor:getUnhappynessLevel() + 0.000003 * getGameTime():getMultiplier())
            Survivor:setStress(Survivor:getStress() + 0.000003 * getGameTime():getMultiplier())
        end

        if Survivor:getStressFromOpiateAddiction() > 40 then
            Survivor:setAdditionalBodyPartPainByType(BodyPart.Head, 100)
        end

        if Survivor:getStressFromOpiateAddiction() > 70 then
            Survivor:setFoodSicknessLevel(Survivor:getFoodSicknessLevel() + 0.000003 * getGameTime():getMultiplier())
        end
    end
)