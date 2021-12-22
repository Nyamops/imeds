EventDispatcher = {}

---@return EventDispatcher
function EventDispatcher:new()
    ---@class EventDispatcher
    local public = {}
    local private = {}

    private.listeners = {}
    ---@type Logger
    private.logger = ZCore:getContainer():get('imeds.logger.default')

    function public:subscribe(eventType, listener)
        if private.listeners[eventType] == nil then
            private.listeners[eventType] = {}
        end

        table.insert(private.listeners[eventType], listener)
    end

    function public:unsubscribe(eventType, listener)
        for index, subscribedListener in ipairs(private.listeners[eventType]) do
            if (getmetatable(subscribedListener) == getmetatable(listener)) then
                private.listeners[eventType][index] = nil
            end
        end
    end

    function public:dispatch(eventType, data)
        if private.listeners[eventType] == nil then
            private.logger:warning(eventType .. ' event doesn\'t exist', data)

            return
        end

        for _, listener in ipairs(private.listeners[eventType]) do
            listener:update(data)
        end
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'EventDispatcher'

    return public
end

return EventDispatcher