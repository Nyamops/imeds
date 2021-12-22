---@class DonateBloodCommand
DonateBloodCommand = {
    defaultName = 'DonateBlood',
}

if isClient() then
    return
end

DonateBloodCommand.execute = function(player, args)
    local otherPlayer = getPlayerByOnlineID(args.id)
    if otherPlayer then
        local bloodVolumeReducer = InventoryItemFactory.CreateItem('iMeds.BloodVolumeReducer')
        otherPlayer:sendObjectChange('addItem', { item = bloodVolumeReducer })
    end
end

Events.OnClientCommand.Add(
    function(module, command, player, args)
        if module == 'blood' and command == DonateBloodCommand.defaultName then
            local argStr = ''
            for k, v in pairs(args) do
                argStr = argStr .. ' ' .. k .. '=' .. tostring(v)
            end

            DonateBloodCommand.execute(player, args)
        end
    end
)

