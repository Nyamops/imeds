require 'TimedActions/ISBaseTimedAction'

TakeOneFromNeedlePackAction = {}
TakeOneFromNeedlePackAction = ISBaseTimedAction:derive('TakeOneFromNeedlePackAction')

function TakeOneFromNeedlePackAction:isValid()
    if self.item then
        return self.character:getInventory():contains(self.item)
    end

    return false
end

function TakeOneFromNeedlePackAction:start()
    self.item:setJobType(self.jobType)
    self.item:setJobDelta(0.0)

    self:setActionAnim(CharacterActionAnims.InsertBullets);

    self:setOverrideHandModels(self.item:getStaticModel(), nil)
    self.countStart = round(self.item:getDrainableUsesFloat())
end

function TakeOneFromNeedlePackAction:update()
    local jobDelta = self.countStart - round(self.item:getDrainableUsesFloat())
    self.item:setJobDelta(jobDelta / self.countStart)
end

function TakeOneFromNeedlePackAction:animEvent(event, parameter)
    if event == 'InsertBullet' then
        self.item:Use()

        local needle = InventoryItemFactory.CreateItem(Needle.fullType)
        needle:getModData().needle = {
            isClean = true,
            isInfected = false,
        }

        if isClient() then
            local args = { id = self.character:getOnlineID(), item = needle }
            sendClientCommand(self.character, 'drug', TakeOneCommand.defaultName, args)
        else
            self.character:sendObjectChange('addItem', { item = needle })
        end
    end
end

function TakeOneFromNeedlePackAction:stop()
    self.item:setJobDelta(0.0)

    ISBaseTimedAction.stop(self)
end

function TakeOneFromNeedlePackAction:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)
end

function TakeOneFromNeedlePackAction:new(player, item, count)
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

return TakeOneFromNeedlePackAction