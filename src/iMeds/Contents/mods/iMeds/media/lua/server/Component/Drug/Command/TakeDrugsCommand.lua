---@class TakeDrugsCommand
TakeDrugsCommand = {
    defaultName = 'TakeDrugs',
}

if isClient() then
    return
end

TakeDrugsCommand.execute = function(player, args)
    local otherPlayer = getPlayerByOnlineID(args.id)
    if otherPlayer then
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

