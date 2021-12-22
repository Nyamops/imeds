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
        Survivor:getBlood():setGroup(private.bloodGroupStorage:getRandomBloodGroup():getId())
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'SurvivorCreator'

    return public
end

return SurvivorCreator