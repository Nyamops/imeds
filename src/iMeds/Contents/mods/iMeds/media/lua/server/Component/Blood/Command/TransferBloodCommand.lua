---@class TransferBloodCommand
TransferBloodCommand = {
    defaultName = 'TransferBlood',
}

if isClient() then
    return
end

TransferBloodCommand.execute = function(player, args)
    local otherPlayer = getPlayerByOnlineID(args.id)
    if otherPlayer then
        otherPlayer:sendObjectChange('addItem', { item = args.item })
    end
end

Events.OnClientCommand.Add(
    function(module, command, player, args)
        if module == 'blood' and command == TransferBloodCommand.defaultName then
            local argStr = ''
            for k, v in pairs(args) do
                argStr = argStr .. ' ' .. k .. '=' .. tostring(v)
            end

            TransferBloodCommand.execute(player, args)
        end
    end
)

