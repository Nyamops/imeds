require 'TimedActions/ISBaseTimedAction'

TakeOneFromUnknownPackAction = {}
TakeOneFromUnknownPackAction = ISBaseTimedAction:derive('TakeOneFromUnknownPackAction')

function TakeOneFromUnknownPackAction:isValid()
    if self.character:getPerkLevel(Perks.Doctor) < 3 and not self.character:HasTrait(Pharmacist.alias) then
        return false
    end

    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromUnknownPackAction:update()
    if self.item then
        self.item:setJobDelta(self:getJobDelta())
    end
end

function TakeOneFromUnknownPackAction:start()
    if self.item then
        self.item:setJobType(self.jobType)
        self.item:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')
    self.character:reportEvent("EventLootItem")

    self:setOverrideHandModels(self.item, nil)
end

function TakeOneFromUnknownPackAction:stop()
    if self.item then
        self.item:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function TakeOneFromUnknownPackAction:perform()
    ISBaseTimedAction.perform(self)
    if self.item then
        self.item:setJobDelta(0.0)
    end

    self.item:Use()

    ---@type DrugPackStorage
    local drugPackStorage = ZCore:getContainer():get('imeds.drug.storage.drug_pack_storage')
    local pack = InventoryItemFactory.CreateItem(drugPackStorage:getOneByRandom():getFullType())

    if isClient() then
        local args = { id = self.character:getOnlineID(), item = pack }
        sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
    else
        self.character:sendObjectChange('addItem', { item = pack })
    end
end

function TakeOneFromUnknownPackAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 60
    public.jobType = 'TakeOneFromUnknownPackAction'

    return public
end

return TakeOneFromUnknownPackAction