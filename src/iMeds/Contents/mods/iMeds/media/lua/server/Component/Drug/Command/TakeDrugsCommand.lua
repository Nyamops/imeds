---@class TakeDrugsCommand
TakeDrugsCommand = {
    defaultName = 'takeDrugs',
}

if isClient() then
    return
end

TakeDrugsCommand.execute = function(player, args)
    local otherPlayer = getPlayerByOnlineID(args.id)
    if otherPlayer then
        print(player:getSteamID() .. ' injects ' .. args.item:getModData().drug.fullType .. ' to ' .. otherPlayer:getSteamID())
        otherPlayer:sendObjectChange('addItem', { item = args.item })
    end
end

Events.OnClientCommand.Add(
    function(module, command, player, args)
        if module == 'drug' and command == TakeDrugsCommand.defaultName then
            TakeDrugsCommand.execute(player, args)
        end
    end
)

