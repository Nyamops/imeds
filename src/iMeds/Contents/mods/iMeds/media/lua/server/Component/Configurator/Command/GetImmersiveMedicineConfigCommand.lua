---@class GetImmersiveMedicineConfigCommand
GetImmersiveMedicineConfigCommand = {
    defaultName = 'getImmersiveMedicineConfig',
}

if isClient() then
    return
end

GetImmersiveMedicineConfigCommand.execute = function(player, args)
    local onlinePlayer
    if type(args) == 'table' and args.id ~= nil then
        onlinePlayer = getPlayerByOnlineID(args.id)
    end

    ImmersiveMedicineData = ModData.getOrCreate('ImmersiveMedicineData')

    local reader = getFileReader(getServerName() .. '_ImmersiveMedicine.ini', true)
    while true do
        local line = reader:readLine()
        if not line then
            reader:close()
            break
        end

        local config = line:trim()

        if luautils.stringStarts(config, "IsBloodSystemActive=") then
            ImmersiveMedicineData.IsBloodSystemActive = string.split(config, '=')[2] == 'TRUE'
        end

        if luautils.stringStarts(config, "IsBloodTypeSystemActive=") then
            ImmersiveMedicineData.IsBloodTypeSystemActive = string.split(config, '=')[2] == 'TRUE'
        end
    end

    if onlinePlayer ~= nil then
        print('Player ' .. onlinePlayer:getUsername() .. ' requested Immersive Medicine configs')
        sendServerCommand(onlinePlayer, 'configurator', 'receiveImmersiveMedicineConfig', ImmersiveMedicineData)
    else
        print('Immersive Medicine configuration sent by ' .. player:getUsername() .. ' to all players')
        sendServerCommand('configurator', 'receiveImmersiveMedicineConfig', ImmersiveMedicineData)
    end
end

Events.OnClientCommand.Add(
    function(module, command, player, args)
        if module == 'configurator' and command == GetImmersiveMedicineConfigCommand.defaultName then
            GetImmersiveMedicineConfigCommand.execute(player, args)
        end
    end
)

