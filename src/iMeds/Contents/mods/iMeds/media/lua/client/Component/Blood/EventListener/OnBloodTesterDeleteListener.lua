OnBloodTesterDeleteListener = {}

---@return OnBloodTesterDeleteListener
function OnBloodTesterDeleteListener:new()
    ---@class OnBloodTesterDeleteListener
    local public = {}

    function public:update(data)
        local bloodTestingKit = InventoryItemFactory.CreateItem(BloodTestingKit.fullType)
        bloodTestingKit:setTooltip(Survivor:getBlood():getGroup():getName())
        bloodTestingKit:setUsedDelta(0)
        getPlayer():getSquare():AddWorldInventoryItem(bloodTestingKit, 0.5, 0.5, 0)

        Survivor:getBlood():reduceVolume(5)
        Survivor:setIsKnowOwnBloodGroup(true)
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OnBloodTesterDeleteListener'

    return public
end

Events.OnGameBoot.Add(
    function()
        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:subscribe('onBloodTesterDelete', OnBloodTesterDeleteListener:new())
    end
)