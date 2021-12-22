require 'TimedActions/ISBaseTimedAction'

AttachNeedleToSyringeAction = {}
AttachNeedleToSyringeAction = ISBaseTimedAction:derive('AttachNeedleToSyringeAction')

function AttachNeedleToSyringeAction:isValid()
    if self.syringe and self.needle then
        return self.character:getInventory():contains(self.syringe) and self.character:getInventory():contains(self.needle)
    end

    return false
end

function AttachNeedleToSyringeAction:update()
    if self.syringe and self.needle then
        self.syringe:setJobDelta(self:getJobDelta())
        self.needle:setJobDelta(self:getJobDelta())
    end
end

function AttachNeedleToSyringeAction:start()
    if self.syringe and self.needle then
        self.syringe:setJobType(self.jobType)
        self.syringe:setJobDelta(0.0)
        self.needle:setJobType(self.jobType)
        self.needle:setJobDelta(0.0)
    end

    self:setActionAnim('Loot')
    self.character:SetVariable('LootPosition', 'Mid')

    self:setOverrideHandModels(self.syringe, self.needle)
end

function AttachNeedleToSyringeAction:stop()
    if self.syringe and self.needle then
        self.syringe:setJobDelta(0.0)
        self.needle:setJobDelta(0.0)
    end

    ISBaseTimedAction.stop(self)
end

function AttachNeedleToSyringeAction:perform()
    ISBaseTimedAction.perform(self)
    if self.syringe and self.needle then
        self.syringe:setJobDelta(0.0)
        self.needle:setJobDelta(0.0)
    end

    local syringe = InventoryItemFactory.CreateItem(SyringeWithNeedle.fullType)
    syringe:getModData().syringe = self.syringe:getModData().syringe

    syringe:getModData().syringe.isClean = self.syringe:getModData().syringe.isClean
        and self.needle:getModData().needle.isClean

    syringe:getModData().syringe.isInfected = self.syringe:getModData().syringe.isInfected
        and self.needle:getModData().needle.isInfected

    syringe:setUsedDelta(0.0)

    self.character:sendObjectChange('addItem', { item = syringe })
    self.syringe:Use()
    self.needle:Use()
end

function AttachNeedleToSyringeAction:new(player, syringe, needle)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.syringe = syringe
    public.needle = needle
    public.maxTime = 60
    public.jobType = 'AttachNeedleToSyringeAction'

    return public
end

return AttachNeedleToSyringeAction