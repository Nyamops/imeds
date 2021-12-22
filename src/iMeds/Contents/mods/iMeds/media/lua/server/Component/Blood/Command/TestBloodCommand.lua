---@class TestBloodCommand
TestBloodCommand = {
    defaultName = 'TestBlood',
}

if isClient() then
    return
end

TestBloodCommand.execute = function(player, args)
    local otherPlayer = getPlayerByOnlineID(args.id)
    if otherPlayer then
        local bloodTester = InventoryItemFactory.CreateItem('iMeds.BloodTester')

        otherPlayer:sendObjectChange('addItem', { item = bloodTester })
    end
end

Events.OnClientCommand.Add(
    function(module, command, player, args)
        if module == 'blood' and command == TestBloodCommand.defaultName then
            local argStr = ''
            for k, v in pairs(args) do
                argStr = argStr .. ' ' .. k .. '=' .. tostring(v)
            end

            TestBloodCommand.execute(player, args)
        end
    end
)

