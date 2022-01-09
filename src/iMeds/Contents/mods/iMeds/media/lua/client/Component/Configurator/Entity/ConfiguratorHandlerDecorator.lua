ConfiguratorHandlerDecorator = {}

---@return ConfiguratorHandlerDecorator
function ConfiguratorHandlerDecorator:new(handler)
    ---@class ConfiguratorHandlerDecorator
    local public = {}
    local private = {}

    private.handler = handler

    function public:getDefaultValue()
        return private.handler:getOption():getDefaultValue()
    end

    function public:getOption()
        return private.handler:getOption()
    end

    function public:getShortName()
        return private.handler:getOption():getShortName()
    end

    function public:getTranslatedName()
        return getText('Sandbox_' .. self:getShortName())
    end

    function public:getType()
        return private.handler:getType()
    end

    function public:toTable()
        return {
            type = self:getType(),
            default = self:getDefaultValue(),
            name = self:getShortName(),
            translatedName = self:getTranslatedName(),
        }
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'ConfiguratorHandlerDecorator'

    return public
end

return ConfiguratorHandlerDecorator