OnBloodVolumeReducerDeleteListener = {}

---@return OnBloodVolumeReducerDeleteListener
function OnBloodVolumeReducerDeleteListener:new()
    ---@class OnBloodVolumeReducerDeleteListener
    local public = {}

    function public:update(data)
        local fullBloodBag = BloodBagCreator:new():createFull()
        getPlayer():getSquare():AddWorldInventoryItem(fullBloodBag, 0.5, 0.5, 0)

        Survivor:getBlood():reduceVolume(fullBloodBag:getModData().blood.volume)
        Survivor:setEndurance(Survivor:getEndurance() - 0.35);
        Survivor:setFatigue(Survivor:getFatigue() + 0.45);
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OnBloodVolumeReducerDeleteListener'

    return public
end

Events.OnGameBoot.Add(
    function()
        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:subscribe('onBloodVolumeReducerDelete', OnBloodVolumeReducerDeleteListener:new())
    end
)