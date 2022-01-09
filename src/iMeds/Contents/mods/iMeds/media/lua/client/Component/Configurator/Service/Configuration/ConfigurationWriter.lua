ConfigurationWriter = {}

---@return ConfigurationWriter
function ConfigurationWriter:new()
    ---@class ConfigurationWriter
    local public = {}

    function public:getWriter(serverName)
        return getFileWriter(serverName .. '_ImmersiveMedicine.ini', true, false)
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'ConfigurationWriter'

    return public
end

return ConfigurationWriter