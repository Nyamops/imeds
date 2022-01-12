ButamiratePackHandler = {}

function ButamiratePackHandler:supports(item, player)
    if item:getFullType() == ButamiratePack.fullType then
        self.item = item
    end

    return self.item ~= nil
end

function ButamiratePackHandler:getActionTitle()
    return getText('UI_ContextMenu_Take')
end

function ButamiratePackHandler:addSubMenu(player, subMenu)
    for i = 1, round(self.item:getDrainableUsesFloat()) do
        subMenu:addOption(i .. '', self.item, self.action, player, i)
    end
end

ButamiratePackHandler.action = function(item, player, count)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromButamiratePackAction:new(player, item, count))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.butamirate_pack_handler',
    {
        ButamiratePackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)