SurvivorCreator = {}

---@return SurvivorCreator
function SurvivorCreator:new(bloodGroupStorage)
    ---@class SurvivorCreator
    local public = {}
    local private = {}

    ---@type BloodGroupStorage
    private.bloodGroupStorage = bloodGroupStorage

    function public:create()
        getPlayer():getModData().survivor = {
            isInitialized = false,
        }
        getPlayer():getModData().survivor.blood = {}
        getPlayer():getModData().survivor.blood.drugs = {}
        getPlayer():getModData().survivor.isKnowOwnBloodGroup = false

        Survivor:getBlood():setVolume(Blood.maxVolume)

        local bloodGroup = private.bloodGroupStorage:getRandomBloodGroup()
        if getPlayer():HasTrait(UniversalDonor.alias) then
            bloodGroup = private.bloodGroupStorage:getById(BloodGroup.ON)
            Survivor:setIsKnowOwnBloodGroup(true)
        elseif getPlayer():HasTrait(UniversalRecipient.alias) then
            bloodGroup = private.bloodGroupStorage:getById(BloodGroup.ABP)
            Survivor:setIsKnowOwnBloodGroup(true)
        end

        Survivor:getBlood():setGroup(bloodGroup:getId())
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'SurvivorCreator'

    return public
end

return SurvivorCreator
