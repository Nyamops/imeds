require 'TimedActions/ISBaseTimedAction'

TakeOneFromSyringePackAction = {}
TakeOneFromSyringePackAction = ISBaseTimedAction:derive('TakeOneFromSyringePackAction')

function TakeOneFromSyringePackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromSyringePackAction:update()
    if self.item then
        self.item:setJobDelta(self:getJobDelta())
    end
end

function TakeOneFromSyringePackAction:start()
    if self.item then
        self.item:setJobType(self.jobType)
        self.item:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')
    self.character:reportEvent("EventLootItem")

    self:setOverrideHandModels(self.item, nil)
end

function TakeOneFromSyringePackAction:stop()
    if self.item then
        self.item:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function TakeOneFromSyringePackAction:perform()
    ISBaseTimedAction.perform(self)
    if self.item then
        self.item:setJobDelta(0.0)
    end

    self.item:Use()

    local syringe = InventoryItemFactory.CreateItem(Syringe.fullType)
    syringe:getModData().syringe = {
        maxVolume = 5,
        volume = 0,
        drug = nil,
        isClean = true,
        isInfected = false,
    }

    if isClient() then
        local args = { id = self.character:getOnlineID(), item = syringe }
        sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
    else
        self.character:sendObjectChange('addItem', { item = syringe })
    end
end

function TakeOneFromSyringePackAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 60
    public.jobType = 'TakeOneFromSyringePackAction'

    return public
end

return TakeOneFromSyringePackAction