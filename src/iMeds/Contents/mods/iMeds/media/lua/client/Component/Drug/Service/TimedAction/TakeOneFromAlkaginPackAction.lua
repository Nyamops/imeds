require 'TimedActions/ISBaseTimedAction'

TakeOneFromAlkaginPackAction = {}
TakeOneFromAlkaginPackAction = ISBaseTimedAction:derive('TakeOneFromAlkaginPackAction')

function TakeOneFromAlkaginPackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromAlkaginPackAction:update()
    if self.item then
        self.item:setJobDelta(self:getJobDelta())
    end
end

function TakeOneFromAlkaginPackAction:start()
    if self.item then
        self.item:setJobType(self.jobType)
        self.item:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')
    self.character:reportEvent("EventLootItem")

    self:setOverrideHandModels(self.item, nil)
end

function TakeOneFromAlkaginPackAction:stop()
    if self.item then
        self.item:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function TakeOneFromAlkaginPackAction:perform()
    ISBaseTimedAction.perform(self)
    if self.item then
        self.item:setJobDelta(0.0)
    end

    self.item:Use()

    local drug = DrugCreator:new():createByFullType(Alkagin.fullType)

    if isClient() then
        local args = { id = self.character:getOnlineID(), item = drug }
        sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
    else
        self.character:sendObjectChange('addItem', { item = drug })
    end
end

function TakeOneFromAlkaginPackAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 60
    public.jobType = 'TakeOneFromAlkaginPackAction'

    return public
end

return TakeOneFromAlkaginPackAction