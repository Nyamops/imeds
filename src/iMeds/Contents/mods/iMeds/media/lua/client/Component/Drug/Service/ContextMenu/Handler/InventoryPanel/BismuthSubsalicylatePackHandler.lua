BismuthSubsalicylatePackHandler = {}

function BismuthSubsalicylatePackHandler:supports(item, player)
    if item:getFullType() == BismuthSubsalicylatePack.fullType then
        self.item = item
    end

    return self.item ~= nil
end

function BismuthSubsalicylatePackHandler:getActionTitle()
    return getText('UI_ContextMenu_Take')
end

function BismuthSubsalicylatePackHandler:addSubMenu(player, subMenu)
    for i = 1, round(self.item:getDrainableUsesFloat()) do
        subMenu:addOption(i .. '', self.item, self.action, player, i)
    end
end

BismuthSubsalicylatePackHandler.action = function(item, player, count)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromBismuthSubsalicylatePackAction:new(player, item, count))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.bismuth_subsalicylate_pack_handler',
    {
        BismuthSubsalicylatePackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)