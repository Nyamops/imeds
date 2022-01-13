Survivor = {}

---@return table<string, any>
function Survivor:getModData()
    return getPlayer():getModData()
end

---@return number
function Survivor:getPain()
    return getPlayer():getStats():getPain()
end

---@param value number
---@return void
function Survivor:setPain(value)
    getPlayer():getStats():setPain(value)
end

---@return number
function Survivor:getDrunkenness()
    return getPlayer():getStats():getDrunkenness()
end

---@return void
---@param value number
function Survivor:setDrunkenness(value)
    getPlayer():getStats():setDrunkenness(value)
end

---@return number
function Survivor:getEndurance()
    return getPlayer():getStats():getEndurance()
end

---@return void
---@param value number
function Survivor:setEndurance(value)
    getPlayer():getStats():setEndurance(value)
end

---@return number
function Survivor:getFatigue()
    return getPlayer():getStats():getFatigue()
end

---@return void
---@param value number
function Survivor:setFatigue(value)
    getPlayer():getStats():setFatigue(value)
end

---@return number
function Survivor:getFoodSicknessLevel()
    return getPlayer():getBodyDamage():getFoodSicknessLevel()
end

---@return void
---@param value number
function Survivor:setFoodSicknessLevel(value)
    getPlayer():getBodyDamage():setFoodSicknessLevel(value)
end

---@return number
function Survivor:getThirst()
    return getPlayer():getStats():getThirst()
end

---@return void
---@param value number
function Survivor:setThirst(value)
    getPlayer():getStats():setThirst(value)
end

---@return number
function Survivor:getHunger()
    return getPlayer():getStats():getHunger()
end

---@param value number
---@return void
function Survivor:setHunger(value)
    getPlayer():getStats():setHunger(value)
end

---@param type string
---@return table
function Survivor:getBodyPartByType(type)
    return getPlayer():getBodyDamage():getBodyPart(type)
end

---@param type number
---@return number
function Survivor:getAdditionalBodyPartPainByType(type)
    return Survivor:getBodyPartByType(type):getAdditionalPain()
end

---@param type number
---@param value number
---@return void
function Survivor:setAdditionalBodyPartPainByType(type, value)
    Survivor:getBodyPartByType(type):setAdditionalPain(value)
end

---@return number
function Survivor:getPainReduction()
    return getPlayer():getBodyDamage():getPainReduction()
end

---@param value number
---@return void
function Survivor:setPainReduction(value)
    getPlayer():getBodyDamage():setPainReduction(value)
end

---@return number
function Survivor:getPainReductionFromMeds()
    return getPlayer():getBodyDamage():getPainReductionFromMeds()
end

---@param value number
---@return void
function Survivor:setPainReductionFromMeds(value)
    getPlayer():getBodyDamage():setPainReductionFromMeds(value)
end

---@param type number
---@return number
function Survivor:getBodyPartHealthByType(type)
    return  Survivor:getBodyPartByType(type):getHealth()
end

---@param type number
---@param value number
---@return void
function Survivor:setBodyPartHealthByType(type, value)
    Survivor:getBodyPartByType(type):SetHealth(value)
end

---@return number
function Survivor:getStress()
    return getPlayer():getStats():getStress()
end

---@return void
---@param value number
function Survivor:setStress(value)
    getPlayer():getStats():setStress(value)
end

---@return number
function Survivor:getPoisonLevel()
    return getPlayer():getBodyDamage():getPoisonLevel()
end

---@return void
---@param value number
function Survivor:setPoisonLevel(value)
    getPlayer():getBodyDamage():setPoisonLevel(value)
end

---@return number
function Survivor:getPanic()
    return getPlayer():getStats():getPanic()
end

---@return void
---@param value number
function Survivor:setPanic(value)
    getPlayer():getStats():setPanic(value)
end

---@return number
function Survivor:getTemperature()
    return getPlayer():getBodyDamage():getTemperature()
end

---@return void
---@param value number
function Survivor:setTemperature(value)
    getPlayer():getBodyDamage():setTemperature(value)
end

---@return number
function Survivor:getInfectionLevel()
    return getPlayer():getBodyDamage():getInfectionLevel()
end

---@return void
---@param value number
function Survivor:setWetness(value)
    getPlayer():getBodyDamage():setWetness(value)
end

---@return number
function Survivor:getWetness()
    return getPlayer():getBodyDamage():getWetness()
end

---@return void
---@param value number
function Survivor:setInfectionLevel(value)
    getPlayer():getBodyDamage():setInfectionLevel(value)
end

---@return number
function Survivor:getGeneralHealth()
    return getPlayer():getBodyDamage():getOverallBodyHealth()
end

---@return void
---@param value number
function Survivor:addGeneralHealth(value)
    getPlayer():getBodyDamage():AddGeneralHealth(value)
end

---@return void
---@param value number
function Survivor:reduceGeneralHealth(value)
    getPlayer():getBodyDamage():ReduceGeneralHealth(value)
end

---@return table
function Survivor:getPrimaryHandItem()
    return getPlayer():getPrimaryHandItem()
end

---@return void
---@param item table
function Survivor:setPrimaryHandItem(item)
    getPlayer():setPrimaryHandItem(item)
end

---@return boolean
function Survivor:isBannedAttacking()
    return getPlayer():isBannedAttacking()
end

---@return void
---@param bool boolean
function Survivor:setBannedAttacking(bool)
    getPlayer():setBannedAttacking(bool)
end

---@return boolean
function Survivor:isMoving()
    return getPlayer():getPlayerMoveDir():getLength() ~= 0
end

---@return boolean
function Survivor:isInfected()
    return getPlayer():getBodyDamage():IsInfected()
end

---@return void
---@param bool boolean
function Survivor:setIsInfected(bool)
    getPlayer():getBodyDamage():setInf(bool)
end

---@return table|nil
---@param fullType string
function Survivor:getItem(fullType)
    return getPlayer():getInventory():FindAndReturn(fullType)
end

---@return table
---@param fullType string
function Survivor:addItem(fullType)
    return getPlayer():getInventory():AddItem(fullType)
end

---@return void
---@param fullType string
function Survivor:removeItem(fullType)
    if getPlayer():getInventory():containsWithModule(fullType) then
        local item = getPlayer():getInventory():FindAndReturn(fullType)
        getPlayer():getInventory():Remove(item)
    end
end

---@param fullType string
---@return boolean
function Survivor:haveItem(fullType)
    return getPlayer():getInventory():containsWithModule(fullType)
end

---@return number
function Survivor:getUnhappynessLevel()
    return getPlayer():getBodyDamage():getUnhappynessLevel()
end

---@return void
---@param value number
function Survivor:setUnhappynessLevel(value)
    getPlayer():getBodyDamage():setUnhappynessLevel(value)
end

---@return number
function Survivor:getBoredomLevel()
    return getPlayer():getBodyDamage():getBoredomLevel()
end

---@return void
---@param value number
function Survivor:setBoredomLevel(value)
    getPlayer():getBodyDamage():setBoredomLevel(value);
end

---@return number
function Survivor:getInfectionMortalityDuration()
    return getPlayer():getBodyDamage():getInfectionMortalityDuration()
end

---@return void
---@param value number
function Survivor:setInfectionMortalityDuration(value)
    getPlayer():getBodyDamage():setInfectionMortalityDuration(value)
end

---@return boolean
function Survivor:isInitialized()
    return getPlayer():getModData().survivor and getPlayer():getModData().survivor.isInitialized or false
end

---@param bool boolean
---@return void
function Survivor:setIsInitialized(bool)
    getPlayer():getModData().survivor.isInitialized = bool
end

---@return Blood
function Survivor:getBlood()
    return require 'Component/Blood/Entity/Blood'
end

---@return boolean
function Survivor:isKnowOwnBloodGroup()
    return getPlayer():getModData().survivor.isKnowOwnBloodGroup
end

---@param bool boolean
---@return void
function Survivor:setIsKnowOwnBloodGroup(bool)
    getPlayer():getModData().survivor.isKnowOwnBloodGroup = bool
end

return Survivor