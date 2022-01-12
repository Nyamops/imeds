AlkaginPackHandler = {}

function AlkaginPackHandler:supports(item, player)
    if item:getFullType() == AlkaginPack.fullType then
        self.item = item
    end

    return self.item ~= nil
end

function AlkaginPackHandler:getActionTitle()
    return getText('UI_ContextMenu_Take')
end

function AlkaginPackHandler:addSubMenu(player, subMenu)
    for i = 1, round(self.item:getDrainableUsesFloat()) do
        subMenu:addOption(i .. '', self.item, self.action, player, i)
    end
end

AlkaginPackHandler.action = function(item, player, count)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromAlkaginPackAction:new(player, item, count))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.alkagin_pack_handler',
    {
        AlkaginPackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)