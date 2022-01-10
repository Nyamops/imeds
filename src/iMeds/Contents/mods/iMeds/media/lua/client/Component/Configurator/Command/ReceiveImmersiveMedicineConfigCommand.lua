---@class ReceiveImmersiveMedicineConfigCommand
ReceiveImmersiveMedicineConfigCommand = {
    defaultName = 'receiveImmersiveMedicineConfig',
}

if not isClient() then
    return
end

ReceiveImmersiveMedicineConfigCommand.execute = function(module, command, package)
    ImmersiveMedicineData = ModData.getOrCreate('ImmersiveMedicineData')

    ---@type ConfiguratorHandlerDecorator[]
    local handlers = ZCore:getContainer():getByTag('imeds.configurator.sandbox.handler')
    for _, handler in pairs(handlers) do
        ImmersiveMedicineData[handler:getShortName()] = package[handler:getShortName()]
        SandboxVars[handler:getShortName()] = package[handler:getShortName()]
    end
end

Events.OnServerCommand.Add(
    function(module, command, package)
        if module == 'configurator' and command == ReceiveImmersiveMedicineConfigCommand.defaultName then
            ReceiveImmersiveMedicineConfigCommand.execute(module, command, package)
        end
    end
)

