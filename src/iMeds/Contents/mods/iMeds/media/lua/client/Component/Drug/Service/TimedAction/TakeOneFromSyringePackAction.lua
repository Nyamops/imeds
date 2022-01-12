require 'TimedActions/ISBaseTimedAction'

TakeOneFromSyringePackAction = {}
TakeOneFromSyringePackAction = ISBaseTimedAction:derive('TakeOneFromSyringePackAction')

function TakeOneFromSyringePackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromSyringePackAction:start()
    self.item:setJobType(self.jobType)
    self.item:setJobDelta(0.0)

    self:setActionAnim(CharacterActionAnims.InsertBullets);

    self:setOverrideHandModels(self.item:getStaticModel(), nil)
    self.countStart = round(self.item:getDrainableUsesFloat())
end

function TakeOneFromSyringePackAction:update()
    local jobDelta = self.countStart - round(self.item:getDrainableUsesFloat())
    self.item:setJobDelta(jobDelta / self.countStart)
end

function TakeOneFromSyringePackAction:animEvent(event, parameter)
    if event == 'InsertBullet' then
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
end

function TakeOneFromSyringePackAction:stop()
    self.item:setJobDelta(0.0)

    ISBaseTimedAction.stop(self)
end

function TakeOneFromSyringePackAction:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
end

function TakeOneFromSyringePackAction:new(player, item, count)
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

return TakeOneFromSyringePackAction