ConfigurationReader = {}

---@return ConfigurationReader
function ConfigurationReader:new()
    ---@class ConfigurationReader
    local public = {}

    function public:getReader(serverName)
        return getFileReader(serverName .. '_ImmersiveMedicine.ini', true)
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'ConfigurationReader'

    return public
end

return ConfigurationReader