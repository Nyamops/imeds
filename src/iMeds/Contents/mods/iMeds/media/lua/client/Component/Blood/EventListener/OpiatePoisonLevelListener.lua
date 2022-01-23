Events.OnTick.Add(
    function()
        if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
            return false
        end

        Survivor:getBlood():setOpiatePoisonLevel(Survivor:getBlood():getOpiatePoisonLevel() - ZomboidGlobals.FoodSicknessDecrease * getGameTime():getMultiplier())

        if Survivor:getBlood():getOpiatePoisonLevel() < 0 then
            Survivor:getBlood():setOpiatePoisonLevel(0)
        end

        if Survivor:getBlood():getOpiatePoisonLevel() > 100 then
            Survivor:getBlood():setOpiatePoisonLevel(100)
        end

        if Survivor:getBlood():getOpiatePoisonLevel() > 0 then
            Survivor:setFoodSicknessLevel(Survivor:getBlood():getOpiatePoisonLevel())
        end
    end
)