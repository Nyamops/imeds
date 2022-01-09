IsBloodSystemActiveHandler = {}

---@return IsBloodSystemActiveHandler
function IsBloodSystemActiveHandler:new()
    ---@class IsBloodSystemActiveHandler
    local public = {}
    public.alias = 'IsBloodSystemActive'
    public.page = 'BloodSystem'

    BooleanSandboxOption.new(getSandboxOptions(), public.alias, true)
    getSandboxOptions():getOptionByName(public.alias):setPageName(public.page)

    function public:getOption()
        return getSandboxOptions():getOptionByName(self.alias)
    end

    function public:getType()
        return 'checkbox'
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'IsBloodSystemActiveHandler'

    return public
end

ZCore:getContainer():register(
    require 'Component/Configurator/Entity/ConfiguratorHandlerDecorator',
    'imeds.configurator.sandbox.blood_system.handler.is_blood_system_active',
    {
        IsBloodSystemActiveHandler:new()
    },
    'imeds.configurator.sandbox.handler'
)