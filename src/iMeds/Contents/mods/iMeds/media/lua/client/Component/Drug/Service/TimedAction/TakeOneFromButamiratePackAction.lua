require 'TimedActions/ISBaseTimedAction'

TakeOneFromButamiratePackAction = {}
TakeOneFromButamiratePackAction = ISBaseTimedAction:derive('TakeOneFromButamiratePackAction')

function TakeOneFromButamiratePackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromButamiratePackAction:update()
    if self.item then
        self.item:setJobDelta(self:getJobDelta())
    end
end

function TakeOneFromButamiratePackAction:start()
    if self.item then
        self.item:setJobType(self.jobType)
        self.item:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')
    self.character:reportEvent("EventLootItem")

    self:setOverrideHandModels(self.item, nil)
end

function TakeOneFromButamiratePackAction:stop()
    if self.item then
        self.item:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function TakeOneFromButamiratePackAction:perform()
    ISBaseTimedAction.perform(self)
    if self.item then
        self.item:setJobDelta(0.0)
    end

    self.item:Use()

    local drug = DrugCreator:new():createByFullType(Butamirate.fullType)

    if isClient() then
        local args = { id = self.character:getOnlineID(), item = drug }
        sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
    else
        self.character:sendObjectChange('addItem', { item = drug })
    end
end

function TakeOneFromButamiratePackAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 60
    public.jobType = 'TakeOneFromButamiratePackAction'

    return public
end

return TakeOneFromButamiratePackAction