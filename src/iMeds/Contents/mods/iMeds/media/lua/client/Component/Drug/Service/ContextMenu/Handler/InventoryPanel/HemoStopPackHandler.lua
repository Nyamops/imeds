HemoStopPackHandler = {}

function HemoStopPackHandler:supports(item, player)
    self.items = {}

    if item:getFullType() == HemoStopPack.fullType then
        table.insert(self.items, item)
    end

    return tableLength(self.items) > 0
end

function HemoStopPackHandler:getActionTitle()
    return getText('UI_ContextMenu_TakeOne')
end

function HemoStopPackHandler:addSubMenu(player, subMenu)
    for _, item in ipairs(self.items) do
        subMenu:addOption(item:getName(), item, self.action, player)
    end
end

HemoStopPackHandler.action = function(item, player)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromHemoStopPackAction:new(player, item))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.hemo_stop_pack_handler',
    {
        HemoStopPackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)