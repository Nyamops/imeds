NaloxonPackHandler = {}

function NaloxonPackHandler:supports(item, player)
    if item:getFullType() == NaloxonPack.fullType then
        self.item = item
    end

    return self.item ~= nil
end

function NaloxonPackHandler:getActionTitle()
    return getText('UI_ContextMenu_Take')
end

function NaloxonPackHandler:addSubMenu(player, subMenu)
    for i = 1, round(self.item:getDrainableUsesFloat()) do
        subMenu:addOption(i .. '', self.item, self.action, player, i)
    end
end

NaloxonPackHandler.action = function(item, player, count)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromNaloxonPackAction:new(player, item, count))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.naloxon_pack_handler',
    {
        NaloxonPackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)