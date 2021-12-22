ButamiratePackHandler = {}

function ButamiratePackHandler:supports(item, player)
    self.items = {}

    if item:getFullType() == ButamiratePack.fullType then
        table.insert(self.items, item)
    end

    return tableLength(self.items) > 0
end

function ButamiratePackHandler:getActionTitle()
    return getText('UI_ContextMenu_TakeOne')
end

function ButamiratePackHandler:addSubMenu(player, subMenu)
    for _, item in ipairs(self.items) do
        subMenu:addOption(item:getName(), item, self.action, player)
    end
end

ButamiratePackHandler.action = function(item, player)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromButamiratePackAction:new(player, item))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.butamirate_pack_handler',
    {
        ButamiratePackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)