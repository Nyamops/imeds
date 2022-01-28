require 'TimedActions/ISBaseTimedAction'

CheckBloodPressureAction = {}
CheckBloodPressureAction = ISBaseTimedAction:derive('CheckBloodPressureAction')

function CheckBloodPressureAction:isValid()
    return self.character:isEquipped(self.item)
end

function CheckBloodPressureAction:start()
    self.item:setJobType(self.jobType)
    self.item:setJobDelta(0.0)

    self:setActionAnim(CharacterActionAnims.Bandage)
    self:setAnimVariable('BandageType', ISHealthPanel.getBandageType(self.bodyPart))
    self.character:reportEvent("EventBandage")
end

function CheckBloodPressureAction:update()
    self.item:setJobDelta(self.item:getJobDelta())
end

function CheckBloodPressureAction:stop()
    self.item:setJobDelta(0.0)

    ISBaseTimedAction.stop(self)
end

function CheckBloodPressureAction:perform()
    ISBaseTimedAction.perform(self)
    self.item:setJobDelta(0.0)

    BloodPressureMonitorMenu:updateSystolicBloodPressure()
    BloodPressureMonitorMenu:updateDiastolicBloodPressure()
end

function CheckBloodPressureAction:new(player, item)
    local public = {}
    setmetatable(public, self)
    self.__index = self
    public.character = player
    public.item = item
    public.maxTime = 300
    public.jobType = getText('UI_ContextMenu_CheckBloodPressure')
    public.stopOnWalk = false

    public.bodyPart = player:getBodyDamage():getBodyPart(BodyPart.Hand_R)
    if item:getFullType() == BloodPressureMonitorLeft.alias then
        public.bodyPart = player:getBodyDamage():getBodyPart(BodyPart.Hand_L)
    end

    return public
end

return CheckBloodPressureAction