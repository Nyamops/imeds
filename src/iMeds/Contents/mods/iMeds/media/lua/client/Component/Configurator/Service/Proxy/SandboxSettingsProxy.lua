SandboxSettingsProxy = {}

---@return SandboxSettingsProxy
function SandboxSettingsProxy:new()
    ---@class SandboxSettingsProxy
    local public = {}
    local private = {}

    ---@type ConfiguratorHandlerDecorator[]
    private.handlers = ZCore:getContainer():getByTag('imeds.configurator.sandbox.handler')

    public.alias = 'ImmersiveMedicine'
    public.title = 'Immersive Medicine'

    private.ServerSettingsScreenProxy = {}
    private.ServerSettingsScreenProxy.getSandboxSettingsTable = ServerSettingsScreen.getSandboxSettingsTable

    function ServerSettingsScreen.getSandboxSettingsTable()
        local settings = private.ServerSettingsScreenProxy.getSandboxSettingsTable(self)

        local SandboxSettingsProxy = {
            name = public.alias,
            settings = {}
        }

        for _, handler in pairs(private.handlers) do
            table.insert(SandboxSettingsProxy.settings, handler:toTable())
        end

        table.insert(settings, SandboxSettingsProxy)

        return settings
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'SandboxSettingsProxy'

    return public
end

return SandboxSettingsProxy