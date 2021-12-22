require 'Component/Trait/Entity/Pharmacist'

ExamineDrugHandler = {}

function ExamineDrugHandler:supports(item, player)
    self.items = {}

    if player:getPerkLevel(Perks.Doctor) < 3 or not player:HasTrait(Pharmacist.alias) then
        return false
    end

    if item:getModule() == 'iMeds' and not string.contains(item:getFullType(), 'Pack') then
        table.insert(self.items, item)
    end

    return tableLength(self.items) > 0
end

function ExamineDrugHandler:getActionTitle()
    return getText('UI_ContextMenu_ExamineDrug')
end

function ExamineDrugHandler:addSubMenu(player, subMenu)
    for _, item in ipairs(self.items) do
        subMenu:addOption(item:getName(), item, self.action, player)
    end
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