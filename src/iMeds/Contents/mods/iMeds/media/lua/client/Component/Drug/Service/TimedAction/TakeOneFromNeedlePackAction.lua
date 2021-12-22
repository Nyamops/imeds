require 'TimedActions/ISBaseTimedAction'

TakeOneFromNeedlePackAction = {}
TakeOneFromNeedlePackAction = ISBaseTimedAction:derive('TakeOneFromNeedlePackAction')

function TakeOneFromNeedlePackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromNeedlePackAction:update()
    if self.item then
        self.item:setJobDelta(self:getJobDelta())
    end
end

function TakeOneFromNeedlePackAction:start()
    if self.item then
        self.item:setJobType(self.jobType)
        self.item:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')
    self.character:reportEvent("EventLootItem")

    self:setOverrideHandModels(self.item, nil)
end

function TakeOneFromNeedlePackAction:stop()
    if self.item then
        self.item:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function TakeOneFromNeedlePackAction:perform()
    ISBaseTimedAction.perform(self)
    if self.item then
        self.item:setJobDelta(0.0)
    end

    self.item:Use()

    local needle = InventoryItemFactory.CreateItem(Needle.fullType)
    needle:getModData().needle = {
        isClean = true,
        isInfected = false,
    }

    if isClient() then
        local args = { id = self.character:getOnlineID(), item = needle }
        sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
    else
        self.character:sendObjectChange('addItem', { item = needle })
    end
end

function TakeOneFromNeedlePackAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 60
    public.jobType = 'TakeOneFromNeedlePackAction'

    return public
end

return TakeOneFromNeedlePackAction