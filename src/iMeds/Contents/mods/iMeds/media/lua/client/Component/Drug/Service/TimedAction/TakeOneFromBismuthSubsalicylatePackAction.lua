require 'TimedActions/ISBaseTimedAction'

TakeOneFromBismuthSubsalicylatePackAction = {}
TakeOneFromBismuthSubsalicylatePackAction = ISBaseTimedAction:derive('TakeOneFromBismuthSubsalicylatePackAction')

function TakeOneFromBismuthSubsalicylatePackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromBismuthSubsalicylatePackAction:update()
    if self.item then
        self.item:setJobDelta(self:getJobDelta())
    end
end

function TakeOneFromBismuthSubsalicylatePackAction:start()
    if self.item then
        self.item:setJobType(self.jobType)
        self.item:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')
    self.character:reportEvent("EventLootItem")

    self:setOverrideHandModels(self.item, nil)
end

function TakeOneFromBismuthSubsalicylatePackAction:stop()
    if self.item then
        self.item:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function TakeOneFromBismuthSubsalicylatePackAction:perform()
    ISBaseTimedAction.perform(self)
    if self.item then
        self.item:setJobDelta(0.0)
    end

    self.item:Use()

    local drug = DrugCreator:new():createByFullType(BismuthSubsalicylate.fullType)

    if isClient() then
        local args = { id = self.character:getOnlineID(), item = drug }
        sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
    else
        self.character:sendObjectChange('addItem', { item = drug })
    end
end

function TakeOneFromBismuthSubsalicylatePackAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 60
    public.jobType = 'TakeOneFromBismuthSubsalicylatePackAction'

    return public
end

return TakeOneFromBismuthSubsalicylatePackAction