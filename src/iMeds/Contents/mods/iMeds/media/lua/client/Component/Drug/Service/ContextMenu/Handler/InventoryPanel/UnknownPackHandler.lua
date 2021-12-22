UnknownPackHandler = {}

function UnknownPackHandler:supports(item, player)
    self.items = {}

    if player:getPerkLevel(Perks.Doctor) < 3 and not player:HasTrait(Pharmacist.alias) then
        return false
    end

    if item:getFullType() == UnknownPack.fullType then
        table.insert(self.items, item)
    end

    return tableLength(self.items) > 0
end

function UnknownPackHandler:getActionTitle()
    return getText('UI_ContextMenu_TakeOne')
end

function UnknownPackHandler:addSubMenu(player, subMenu)
    for _, item in ipairs(self.items) do
        subMenu:addOption(item:getName(), item, self.action, player)
    end
end

UnknownPackHandler.action = function(item, player)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromUnknownPackAction:new(player, item))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.unknown_pack_handler',
    {
        UnknownPackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)