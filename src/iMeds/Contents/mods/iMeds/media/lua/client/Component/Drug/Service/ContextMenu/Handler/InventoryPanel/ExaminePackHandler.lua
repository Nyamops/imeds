ExaminePackHandler = {}

function ExaminePackHandler:supports(item, player)
    self.items = {}

    if item:getModule() == 'iMeds'
        and item:getFullType() ~= UnknownPack.fullType
        and string.contains(item:getFullType(), 'Pack')
    then
        table.insert(self.items, item)
    end

    return tableLength(self.items) > 0
end

function ExaminePackHandler:getActionTitle()
    return getText('UI_ContextMenu_ExaminePack')
end

function ExaminePackHandler:addSubMenu(player, subMenu)
    for _, item in ipairs(self.items) do
        subMenu:addOption(item:getName(), item, self.action, player)
    end
end

ExaminePackHandler.action = function(item, player)
    if luautils.haveToBeTransfered(player, item) then
        ISTimedActionQueue.add(
            ISInventoryTransferAction:new(player, item, item:getContainer(), player:getInventory())
        )
    end

    ISTimedActionQueue.add(ExamineDrugAction:new(player, item))
end

ZCore:getContainer():register(
    require 'Component/Interface/Service/ContextMenu/Handler/HandlerDecorator',
    'imeds.drug.context_menu.handler.examine_pack_handler',
    {
        ExaminePackHandler
    },
    'imeds.context_menu.inventory_panel.handler'
)