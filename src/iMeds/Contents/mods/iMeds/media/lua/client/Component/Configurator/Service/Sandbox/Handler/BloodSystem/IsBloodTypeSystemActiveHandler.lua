IsBloodTypeSystemActiveHandler = {}

---@return IsBloodTypeSystemActiveHandler
function IsBloodTypeSystemActiveHandler:new()
    ---@class IsBloodTypeSystemActiveHandler
    local public = {}
    public.alias = 'IsBloodTypeSystemActive'
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
    self.__metatable = 'IsBloodTypeSystemActiveHandler'

    return public
end

ZCore:getContainer():register(
    require 'Component/Configurator/Entity/ConfiguratorHandlerDecorator',
    'imeds.configurator.sandbox.blood_system.handler.is_blood_type_system_active',
    {
        IsBloodTypeSystemActiveHandler:new()
    },
    'imeds.configurator.sandbox.handler'
)