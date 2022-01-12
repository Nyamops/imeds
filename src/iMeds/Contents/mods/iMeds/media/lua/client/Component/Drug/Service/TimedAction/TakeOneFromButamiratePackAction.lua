require 'TimedActions/ISBaseTimedAction'

TakeOneFromButamiratePackAction = {}
TakeOneFromButamiratePackAction = ISBaseTimedAction:derive('TakeOneFromButamiratePackAction')

function TakeOneFromButamiratePackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromButamiratePackAction:start()
    self.item:setJobType(self.jobType)
    self.item:setJobDelta(0.0)

    self:setActionAnim(CharacterActionAnims.InsertBullets);

    self:setOverrideHandModels(self.item:getStaticModel(), nil)
    self.countStart = round(self.item:getDrainableUsesFloat())
end

function TakeOneFromButamiratePackAction:update()
    local jobDelta = self.countStart - round(self.item:getDrainableUsesFloat())
    self.item:setJobDelta(jobDelta / self.countStart)
end

function TakeOneFromButamiratePackAction:animEvent(event, parameter)
    if event == 'InsertBullet' then
        self.item:Use()

        local drug = DrugCreator:new():createByFullType(Butamirate.fullType)

        if isClient() then
            local args = { id = self.character:getOnlineID(), item = drug }
            sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
        else
            self.character:sendObjectChange('addItem', { item = drug })
        end
    end
end

function TakeOneFromButamiratePackAction:stop()
    self.item:setJobDelta(0.0)

    ISBaseTimedAction.stop(self)
end

function TakeOneFromButamiratePackAction:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
end

function TakeOneFromButamiratePackAction:new(player, item, count)
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

return TakeOneFromButamiratePackAction