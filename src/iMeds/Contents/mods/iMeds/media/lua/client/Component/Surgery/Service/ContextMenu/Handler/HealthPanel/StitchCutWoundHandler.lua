StitchCutWoundHandler = {}
local BaseHandlerProxy = require('Component/Interface/Service/ContextMenu/Proxy/BaseHandlerProxy'):new()
StitchCutWoundHandler = BaseHandlerProxy:derive('StitchCutWoundHandler')

function StitchCutWoundHandler:new(panel, bodyPart)
    local public = BaseHandlerProxy.new(self, panel, bodyPart)
    public.items.ITEMS = {}

    return public
end

function StitchCutWoundHandler:checkItem(item)
    if in_table(item:getType(), { 'Needle', 'Thread', 'SutureNeedle' }) then
        self:addItem(self.items.ITEMS, item)
    end
end

function StitchCutWoundHandler:addToMenu(context)
    if not self:isInjured() or not self.bodyPart:isCut() then
        return false
    end

    local needle = self:getItemOfType(self.items.ITEMS, 'Base.Needle')
    local thread = self:getItemOfType(self.items.ITEMS, 'Base.Thread')
    local needlePlusThread = self:getItemOfType(self.items.ITEMS, 'Base.SutureNeedle')

    if needle ~= nil and thread ~= nil or needlePlusThread ~= nil then
        local option = context:addOption(getText('ContextMenu_Stitch'), nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(option, subMenu)

        if needlePlusThread ~= nil then
            subMenu:addOption(needlePlusThread:getName(), self, self.onMenuOptionSelected, needlePlusThread:getFullType(), needlePlusThread:getFullType())
        end

        if needle ~= nil and thread ~= nil then
            local text = needle:getName() .. '' + '' .. thread:getName()
            subMenu:addOption(text, self, self.onMenuOptionSelected, needle:getFullType(), thread:getFullType())
        end
    end
end

function StitchCutWoundHandler:dropItems(items)
    if not self:isInjured() or not self.bodyPart:isCut() then
        return false
    end

    local needlePlusThread = self:getItemOfType(self.items.ITEMS, 'Base.SutureNeedle')
    if needlePlusThread ~= nil then
        self:onMenuOptionSelected(needlePlusThread:getFullType(), needlePlusThread:getFullType())
        return true
    end

    local needle = self:getItemOfType(self.items.ITEMS, 'Base.Needle')
    local thread = self:getItemOfType(self.items.ITEMS, 'Base.Thread')

    if needle ~= nil and thread ~= nil then
        self:onMenuOptionSelected(needle:getFullType(), thread:getFullType())
        return true
    end

    return false
end

function StitchCutWoundHandler:isValid(needleType, threadType)
    if not self:isInjured() or not self.bodyPart:isCut() then
        return false
    end

    self:checkItems()

    if needleType == threadType then
        return self:getItemOfType(self.items.ITEMS, needleType) ~= nil
    end

    local needle = self:getItemOfType(self.items.ITEMS, needleType)
    local thread = self:getItemOfType(self.items.ITEMS, threadType)

    return needle ~= nil and thread ~= nil
end

function StitchCutWoundHandler:perform(previousAction, needleType, threadType)
    if needleType == threadType then
        local needle = self:getItemOfType(self.items.ITEMS, needleType)
        previousAction = self:toPlayerInventory(needle, previousAction)
        local action = ISStitch:new(self:getDoctor(), self:getPatient(), needle, self.bodyPart, true)
        ISTimedActionQueue.addAfter(previousAction, action)
    else
        local needle = self:getItemOfType(self.items.ITEMS, needleType)
        local thread = self:getItemOfType(self.items.ITEMS, threadType)
        previousAction = self:toPlayerInventory(needle, previousAction)
        previousAction = self:toPlayerInventory(thread, previousAction)
        local action = ISStitch:new(self:getDoctor(), self:getPatient(), thread, self.bodyPart, true)
        ISTimedActionQueue.addAfter(previousAction, action)
    end
end