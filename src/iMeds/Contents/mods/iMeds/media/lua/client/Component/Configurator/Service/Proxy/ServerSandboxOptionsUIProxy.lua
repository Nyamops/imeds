ServerSandboxOptionsUIProxy = {}

---@return ServerSandboxOptionsUIProxy
function ServerSandboxOptionsUIProxy:new()
    ---@class ServerSandboxOptionsUIProxy
    local public = {}
    local private = {}

    private.ISServerSandboxOptionsUI = {}
    private.ISServerSandboxOptionsUI.onButtonApply = ISServerSandboxOptionsUI.onButtonApply

    function ISServerSandboxOptionsUI:onButtonApply()
        private.ISServerSandboxOptionsUI.onButtonApply(self)

        sendClientCommand(getPlayer(), 'configurator', 'getImmersiveMedicineConfig', {})
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'ServerSandboxOptionsUIProxy'

    return public
end

return ServerSandboxOptionsUIProxy