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

        local incrementValue = 0.001
        if Survivor:getBlood():getDrugs()[Morphine.alias] ~= nil and Survivor:getBlood():getDrugs()[Morphine.alias].isActive then
            incrementValue = 0
        end

        Survivor:setStressFromOpiateAddiction(Survivor:getStressFromOpiateAddiction() + incrementValue * getGameTime():getMultiplier())

        local maxStress = 0

        if Survivor:getStressFromOpiateAddiction() > 25 then
            Survivor:setUnhappynessLevel(Survivor:getUnhappynessLevel() + incrementValue * 4 * getGameTime():getMultiplier())
            Survivor:setStress(Survivor:getStress() + incrementValue / 20 * getGameTime():getMultiplier())
            Survivor:setAdditionalBodyPartPainByType(BodyPart.Head, 20)

            maxStress = 0.26
        end

        if Survivor:getStressFromOpiateAddiction() > 40 then
            Survivor:setAdditionalBodyPartPainByType(BodyPart.Head, 40)
            maxStress = 0.6
        end

        if Survivor:getStressFromOpiateAddiction() > 70 then
            Survivor:setFoodSicknessLevel(Survivor:getFoodSicknessLevel() + incrementValue * getGameTime():getMultiplier())
            Survivor:setAdditionalBodyPartPainByType(BodyPart.Head, 100)
            maxStress = 0.76
        end

        if Survivor:getStressFromOpiateAddiction() > 100 then
            Survivor:setStressFromOpiateAddiction(100)
        end

        if Survivor:getStress() > maxStress then
            Survivor:setStress(maxStress)
        end
    end
)