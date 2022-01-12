UnknownPackHandler = {}

function UnknownPackHandler:supports(item, player)
    if player:getPerkLevel(Perks.Doctor) < 3 and not player:HasTrait(Pharmacist.alias) then
        return false
    end

    if item:getFullType() == UnknownPack.fullType then
        self.item = item
    end

    return self.item ~= nil
end

function UnknownPackHandler:getActionTitle()
    return getText('UI_ContextMenu_Take')
end

function UnknownPackHandler:addSubMenu(player, subMenu)
    subMenu:addOption('1', self.item, self.action, player, 1)
end

UnknownPackHandler.action = function(item, player, count)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(TakeOneFromUnknownPackAction:new(player, item, count))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.unknown_pack_handler',
    {
        UnknownPackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)