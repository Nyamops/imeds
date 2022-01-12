HemoStopPackHandler = {}

function HemoStopPackHandler:supports(item, player)
    if item:getFullType() == HemoStopPack.fullType then
        self.item = item
    end

    return self.item ~= nil
end

function HemoStopPackHandler:getActionTitle()
    return getText('UI_ContextMenu_Take')
end

function HemoStopPackHandler:addSubMenu(player, subMenu)
    for i = 1, round(self.item:getDrainableUsesFloat()) do
        subMenu:addOption(i .. '', self.item, self.action, player, i)
    end
end

HemoStopPackHandler.action = function(item, player, count)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromHemoStopPackAction:new(player, item, count))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.hemo_stop_pack_handler',
    {
        HemoStopPackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)