---@class TakeOneCommand
TakeOneCommand = {
    defaultName = 'TakeOne',
}

if isClient() then
    return
end

TakeOneCommand.execute = function(player, args)
    local otherPlayer = getPlayerByOnlineID(args.id)
    if otherPlayer then
        otherPlayer:sendObjectChange('addItem', { item = args.item })
    end
end

Events.OnClientCommand.Add(
    function(module, command, player, args)
        if module == 'drug' and command == TakeOneCommand.defaultName then
            local argStr = ''
            for k, v in pairs(args) do
                argStr = argStr .. ' ' .. k .. '=' .. tostring(v)
            end

            TakeOneCommand.execute(player, args)
        end
    end
)

