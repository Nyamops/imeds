require 'TimedActions/ISBaseTimedAction'

FillSyringeAction = {}
FillSyringeAction = ISBaseTimedAction:derive('FillSyringeAction')

function FillSyringeAction:isValid()
    if self.syringe and self.drug then
        return self.character:getInventory():contains(self.syringe) and self.character:getInventory():contains(self.drug)
    end

    return false
end

function FillSyringeAction:update()
    if self.syringe and self.drug then
        self.syringe:setJobDelta(self:getJobDelta())
        self.drug:setJobDelta(self:getJobDelta())
    end
end

function FillSyringeAction:start()
    if self.syringe and self.drug then
        self.syringe:setJobType(self.jobType)
        self.syringe:setJobDelta(0.0)
        self.drug:setJobType(self.jobType)
        self.drug:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')

    self:setOverrideHandModels(self.syringe, self.drug)
end

function FillSyringeAction:stop()
    if self.syringe and self.drug then
        self.syringe:setJobDelta(0.0)
        self.drug:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function FillSyringeAction:perform()
    ISBaseTimedAction.perform(self)
    if self.syringe and self.drug then
        self.syringe:setJobDelta(0.0)
        self.drug:setJobDelta(0.0)
    end

    local syringe = self.syringe
    if self.syringe:getFullType() == SyringeWithNeedle.fullType then
        syringe = InventoryItemFactory.CreateItem(FullSyringeWithNeedle.fullType)
        syringe:setUsedDelta(0.0)
        syringe:getModData().syringe = self.syringe:getModData().syringe
        syringe:getModData().syringe.drug = self.drug:getModData().drug
        syringe:setName(string.format(getText('UI_ContextMenu_Syringe'), self.drug:getName()))
    end

    if syringe:getModData().syringe.volume <= syringe:getModData().syringe.maxVolume then
        ---@type DrugStorage
        local drugStorage = ZCore:getContainer():get('imeds.drug.storage.drug_storage')
        local drug = drugStorage:getByFullType(syringe:getModData().syringe.drug.fullType)

        syringe:getModData().syringe.volume = syringe:getModData().syringe.volume + drug:getSingleDose()
        syringe:setUsedDelta(syringe:getModData().syringe.volume * syringe:getUseDelta())
    end

    if self.syringe:getFullType() == SyringeWithNeedle.fullType then

        if isClient() then
            local args = { id = self.character:getOnlineID(), item = syringe }
            sendClientCommand(self.character, 'drug', FillSyringeCommand.defaultName, args)
        else
            self.character:sendObjectChange('addItem', { item = syringe })
        end

        self.syringe:Use()
    end

    self.drug:Use()
end

function FillSyringeAction:new(player, syringe, drug)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.syringe = syringe
    public.drug = drug
    public.maxTime = 150
    public.jobType = 'FillSyringeAction'

    return public
end

return FillSyringeAction