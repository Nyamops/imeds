require 'TimedActions/ISBaseTimedAction'

TakeOneFromNaloxonPackAction = {}
TakeOneFromNaloxonPackAction = ISBaseTimedAction:derive('TakeOneFromNaloxonPackAction')

function TakeOneFromNaloxonPackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromNaloxonPackAction:update()
    if self.item then
        self.item:setJobDelta(self:getJobDelta())
    end
end

function TakeOneFromNaloxonPackAction:start()
    if self.item then
        self.item:setJobType(self.jobType)
        self.item:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')
    self.character:reportEvent("EventLootItem")

    self:setOverrideHandModels(self.item, nil)
end

function TakeOneFromNaloxonPackAction:stop()
    if self.item then
        self.item:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function TakeOneFromNaloxonPackAction:perform()
    ISBaseTimedAction.perform(self)
    if self.item then
        self.item:setJobDelta(0.0)
    end

    self.item:Use()

    local drug = DrugCreator:new():createByFullType(Naloxon.fullType)

    if isClient() then
        local args = { id = self.character:getOnlineID(), item = drug }
        sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
    else
        self.character:sendObjectChange('addItem', { item = drug })
    end
end

function TakeOneFromNaloxonPackAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 60
    public.jobType = 'TakeOneFromNaloxonPackAction'

    return public
end

return TakeOneFromNaloxonPackAction