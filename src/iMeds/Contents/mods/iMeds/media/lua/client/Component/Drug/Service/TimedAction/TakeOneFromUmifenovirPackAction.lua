require 'TimedActions/ISBaseTimedAction'

TakeOneFromUmifenovirPackAction = {}
TakeOneFromUmifenovirPackAction = ISBaseTimedAction:derive('TakeOneFromUmifenovirPackAction')

function TakeOneFromUmifenovirPackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromUmifenovirPackAction:start()
    self.item:setJobType(self.jobType)
    self.item:setJobDelta(0.0)

    self:setActionAnim(CharacterActionAnims.InsertBullets);

    self:setOverrideHandModels(self.item:getStaticModel(), nil)
    self.countStart = round(self.item:getDrainableUsesFloat())
end

function TakeOneFromUmifenovirPackAction:update()
    local jobDelta = self.countStart - round(self.item:getDrainableUsesFloat())
    self.item:setJobDelta(jobDelta / self.countStart)
end

function TakeOneFromUmifenovirPackAction:animEvent(event, parameter)
    if event == 'InsertBullet' then
        self.item:Use()

        local drug = DrugCreator:new():createByFullType(Umifenovir.fullType)

        if isClient() then
            local args = { id = self.character:getOnlineID(), item = drug }
            sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
        else
            self.character:sendObjectChange('addItem', { item = drug })
        end
    end
end

function TakeOneFromUmifenovirPackAction:stop()
    self.item:setJobDelta(0.0)

    ISBaseTimedAction.stop(self)
end

function TakeOneFromUmifenovirPackAction:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
end

function TakeOneFromUmifenovirPackAction:new(player, item, count)
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

return TakeOneFromUmifenovirPackAction