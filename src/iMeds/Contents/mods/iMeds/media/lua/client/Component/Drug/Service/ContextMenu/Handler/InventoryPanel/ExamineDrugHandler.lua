require 'Component/Trait/Entity/Pharmacist'

ExamineDrugHandler = {}

function ExamineDrugHandler:supports(item, player)
    if player:getPerkLevel(Perks.Doctor) < 3 or not player:HasTrait(Pharmacist.alias) then
        return false
    end

    return item:getModule() == 'iMeds' and not string.contains(item:getFullType(), 'Pack')
end

function ExamineDrugHandler:getActionTitle()
    return getText('UI_ContextMenu_ExamineDrug')
end

function ExamineDrugHandler:addSubMenu(subMenu, player, item)
    subMenu:addOption(item:getName(), item, self.action, player)
end

ExamineDrugHandler.action = function(item, player)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(ExamineDrugAction:new(player, item))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.examine_drug_handler',
    {
        ExamineDrugHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)