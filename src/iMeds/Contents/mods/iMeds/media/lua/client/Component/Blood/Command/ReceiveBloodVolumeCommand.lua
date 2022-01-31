---@class ReceiveBloodVolumeCommand
ReceiveBloodVolumeCommand = {
    defaultName = 'receiveBloodVolume',
}

if not isClient() then
    return
end

ReceiveBloodVolumeCommand.execute = function(package)
    local patient = getPlayerByOnlineID(package.patientOnlineId)
    if package.bloodVolume ~= nil and patient ~= nil then
        BloodVolumeWindow:showBloodVolume(package.bloodVolume, self.character, self.otherPlayer)
        BloodVolumeWindow:setVisible(true)
    end
end

Events.OnServerCommand.Add(
    function(module, command, package)
        if module == 'blood' and command == ReceiveBloodVolumeCommand.defaultName then
            ReceiveBloodVolumeCommand.execute(package)
        end
    end
)
