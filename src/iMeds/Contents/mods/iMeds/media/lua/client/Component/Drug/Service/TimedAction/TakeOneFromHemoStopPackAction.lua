require 'TimedActions/ISBaseTimedAction'

TakeOneFromHemoStopPackAction = {}
TakeOneFromHemoStopPackAction = ISBaseTimedAction:derive('TakeOneFromHemoStopPackAction')

function TakeOneFromHemoStopPackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromHemoStopPackAction:start()
    self.item:setJobType(self.jobType)
    self.item:setJobDelta(0.0)

    self:setActionAnim(CharacterActionAnims.InsertBullets);

    self:setOverrideHandModels(self.item:getStaticModel(), nil)
    self.countStart = round(self.item:getDrainableUsesFloat())
end

function TakeOneFromHemoStopPackAction:update()
    local jobDelta = self.countStart - round(self.item:getDrainableUsesFloat())
    self.item:setJobDelta(jobDelta / self.countStart)
end

function TakeOneFromHemoStopPackAction:animEvent(event, parameter)
    if event == 'InsertBullet' then
        self.item:Use()

        local drug = DrugCreator:new():createByFullType(HemoStop.fullType)

        if isClient() then
            local args = { id = self.character:getOnlineID(), item = drug }
            sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
        else
            self.character:sendObjectChange('addItem', { item = drug })
        end
    end
end

function TakeOneFromHemoStopPackAction:stop()
    self.item:setJobDelta(0.0)

    ISBaseTimedAction.stop(self)
end

function TakeOneFromHemoStopPackAction:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
end

function TakeOneFromHemoStopPackAction:new(player, item, count)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.count = count
    public.maxTime = -1
    public.jobType = getText('UI_ContextMenu_Take')

    return public
end

return TakeOneFromHemoStopPackAction