OnBloodVolumeIncreaserDeleteListener = {}

---@return OnBloodVolumeIncreaserDeleteListener
function OnBloodVolumeIncreaserDeleteListener:new()
    ---@class OnBloodVolumeIncreaserDeleteListener
    local public = {}

    function public:update(data)
        local additionalPoisonLevel = data.blood.isFresh and 0 or 50
        if data.blood.isRotten then
            additionalPoisonLevel = 100
        end

        local levelModifier = Survivor:getBlood():getVolume() / data.blood.volume

        Survivor:getBlood():addVolume(data.blood.volume)
        Survivor:setDrunkenness(data.blood.donor.drunkennessLevel / levelModifier)
        Survivor:setPoisonLevel(data.blood.donor.poisonLevel / levelModifier + additionalPoisonLevel)

        if not Survivor:getBlood():getGroup():hasCompatibility(data.blood.group) then
            Survivor:setFoodSicknessLevel(100)
            Survivor:setPoisonLevel(100)
            Survivor:setEndurance(0)
            Survivor:setFatigue(1)
            Survivor:setDrunkenness(100)
        end

        Survivor:setIsInfected(data.blood.donor.isInfected)
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OnBloodVolumeIncreaserDeleteListener'

    return public
end

Events.OnGameBoot.Add(
    function()
        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:subscribe('onBloodVolumeIncreaserDelete', OnBloodVolumeIncreaserDeleteListener:new())
    end
)