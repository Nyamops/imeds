SyringePackHandler = {}

function SyringePackHandler:supports(item, player)
    if item:getFullType() == SyringePack.fullType then
        self.item = item
    end

    return self.item ~= nil
end

function SyringePackHandler:getActionTitle()
    return getText('UI_ContextMenu_Take')
end

function SyringePackHandler:addSubMenu(player, subMenu)
    for i = 1, round(self.item:getDrainableUsesFloat()) do
        subMenu:addOption(i .. '', self.item, self.action, player, i)
    end
end

SyringePackHandler.action = function(item, player, count)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromSyringePackAction:new(player, item, count))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.syringe_pack_handler',
    {
        SyringePackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)