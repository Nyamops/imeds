NeedlePackHandler = {}

function NeedlePackHandler:supports(item, player)
    self.items = {}

    if item:getFullType() == NeedlePack.fullType then
        table.insert(self.items, item)
    end

    return tableLength(self.items) > 0
end

function NeedlePackHandler:getActionTitle()
    return getText('UI_ContextMenu_TakeOne')
end

function NeedlePackHandler:addSubMenu(player, subMenu)
    for _, item in ipairs(self.items) do
        subMenu:addOption(item:getName(), item, self.action, player)
    end
end

NeedlePackHandler.action = function(item, player)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromNeedlePackAction:new(player, item))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.needle_pack_handler',
    {
        NeedlePackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)