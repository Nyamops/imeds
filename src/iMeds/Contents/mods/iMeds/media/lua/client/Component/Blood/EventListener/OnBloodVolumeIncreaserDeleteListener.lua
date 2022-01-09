OnBloodVolumeIncreaserDeleteListener = {}

---@return OnBloodVolumeIncreaserDeleteListener
function OnBloodVolumeIncreaserDeleteListener:new()
    ---@class OnBloodVolumeIncreaserDeleteListener
    local public = {}

    function public:update(data)
        if not SandboxVars.IsBloodSystemActive then
            return false
        end

        local additionalPoisonLevel = data.blood.isFresh and 0 or 50
        if data.blood.isRotten then
            additionalPoisonLevel = 100
        end

        local levelModifier = Survivor:getBlood():getVolume() / data.blood.volume

        Survivor:getBlood():addVolume(data.blood.volume)
        Survivor:setDrunkenness(data.blood.donor.drunkennessLevel / levelModifier)
        Survivor:setPoisonLevel(data.blood.donor.poisonLevel / levelModifier + additionalPoisonLevel)
        Survivor:setIsInfected(data.blood.donor.isInfected)

        if not SandboxVars.IsBloodTypeSystemActive then
            return false
        end

        if not Survivor:getBlood():getGroup():hasCompatibility(data.blood.group) then
            Survivor:setFoodSicknessLevel(100)
            Survivor:setPoisonLevel(100)
            Survivor:setEndurance(0)
            Survivor:setFatigue(1)
            Survivor:setDrunkenness(100)
        end
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