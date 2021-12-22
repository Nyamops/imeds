local isHealthPanelProxy = require 'Component/Interface/Service/ContextMenu/Proxy/ISHealthPanelProxy'
local private = {}

private.dropItemsOnBodyPart = isHealthPanelProxy.dropItemsOnBodyPart
private.doBodyPartContextMenu = isHealthPanelProxy.doBodyPartContextMenu

function ISHealthPanel:dropItemsOnBodyPart(bodyPart, items)
    private.dropItemsOnBodyPart(self, bodyPart, items)

    local handlers = {}
    ---@param handler HandlerDecorator
    for _, handler in pairs(ZCore:getContainer():getByTag('imeds.context_menu.health_panel.handler')) do
        table.insert(handlers, handler:getInstance():new(self, bodyPart))
    end

    for _, handler in ipairs(handlers) do
        for _, item in ipairs(items) do
            handler:checkItem(item)
        end

        if handler:dropItems(items) then
            break
        end
    end
end

function ISHealthPanel:doBodyPartContextMenu(bodyPart, x, y)
    local handlers = {}
    local context = private.doBodyPartContextMenu(self, bodyPart, x, y)

    ---@param handler HandlerDecorator
    for _, handler in pairs(ZCore:getContainer():getByTag('imeds.context_menu.health_panel.handler')) do
        table.insert(handlers, handler:getInstance():new(self, bodyPart))
    end

    self:checkItems(handlers)

    for _, handler in ipairs(handlers) do
        handler:addToMenu(context)
    end

    if self.blockingMessage or context:isEmpty() then
        context:setVisible(false);
    end

    local playerNum = self.otherPlayer and self.otherPlayer:getPlayerNum() or self.character:getPlayerNum()
    if JoypadState.players[playerNum + 1] and context:getIsVisible() then
        context.mouseOver = 1
        context.origin = self
        JoypadState.players[playerNum + 1].focus = context
        updateJoypadFocus(JoypadState.players[playerNum + 1])
    end
end

function ISHealthPanel:getDamagedParts()
    local result = {}

    local bodyParts = self:getPatient():getBodyDamage():getBodyParts()
    if isClient() and not self:getPatient():isLocalPlayer() then
        bodyParts = self:getPatient():getBodyDamageRemote():getBodyParts()
    end

    for i=1,bodyParts:size() do
        table.insert(result,  bodyParts:get(i-1))
    end

    return result
end