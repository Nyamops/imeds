## BaseHandlerProxy

Copy local table without changes from **ISHealthPanel** into **BaseHandlerProxy**
```lua
local BaseHandler = ISBaseObject:derive("BaseHandler")

function BaseHandler:new(panel, bodyPart)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.panel = panel
    o.bodyPart = bodyPart
    o.items = {}
    return o
end
```

## ISHealthPanelProxy
Copy full content of the **ISHealthPanel** into **ISHealthPanelProxy** and add return to the end of function
```lua
function ISHealthPanel:doBodyPartContextMenu(bodyPart, x, y)
    ...
    
    return context
end 
```