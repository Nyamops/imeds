require 'ISUI/ISPanel'
require 'ISUI/ISRichTextPanel'
require 'ISUI/ISButton'

--TODO ISRadioWindow / RWMPower / ISRadioAction / DeviceInspector
HeartRateMonitorMenu = ISPanel:derive('HeartRateMonitorMenu')

local defaultPadding = 6
local opacity = 0.2
local isPinned = false

function HeartRateMonitorMenu:initialise()
    ISPanel.initialise(self)
end

function HeartRateMonitorMenu:render()
    if not Survivor:isInitialized() or isPinned then
        return false
    end

    self.backgroundColor.a = opacity
    self.display.backgroundColor.a = opacity
    self.display.secondPanel.heartRate:setVisible(opacity == 1 and true or false)
end

function HeartRateMonitorMenu:onMouseMove(x, y)
    opacity = 1
end

function HeartRateMonitorMenu:onMouseMoveOutside(x, y)
    if not isPinned then
        opacity = 0.2
    end
end

function HeartRateMonitorMenu:onMouseDown(x, y)
    isPinned = not isPinned
end

---@return HeartRateMonitorMenu
function HeartRateMonitorMenu:new(positionX, positionY, width, height)
    ---@class HeartRateMonitorMenu
    local public = {}

    public = ISPanel:new(positionX, positionY, width, height)
    setmetatable(public, self)
    self.__index = self
    public.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    public.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    public.onMouseMove = HeartRateMonitorMenu.onMouseMove
    public.onMouseMoveOutside = HeartRateMonitorMenu.onMouseMoveOutside
    public.positionX = positionX
    public.positionY = positionY
    public.width = width
    public.height = height
    public.resizable = false

    return public
end

function HeartRateMonitorMenu:show()
    local width = 150
    local height = 96
    local rightPadding = 81 + defaultPadding * 2
    local topPadding = 300 + defaultPadding

    local menu = self:new(getCore():getScreenWidth() - rightPadding - width, topPadding, width, height)
    menu:addToUIManager()
    menu:setVisible(true)

    local panelWidth = width - 40
    local panelHeight = 24

    menu.display = ISImage:new(0, 0, width, height, getTexture('media/ui/HeartRateMonitor/Display.png'))
    menu.display:initialise()
    menu.display.parent = menu
    menu:addChild(menu.display)

    local panelPositionX = (width - panelWidth) / 2
    local panelPositionY = height / 2 - panelHeight

    menu.display.firstPanel = ISPanel:new(panelPositionX, panelPositionY - 2, panelWidth, panelHeight)
    menu.display.firstPanel.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.display.firstPanel.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.display.firstPanel.onMouseDown = self.onMouseDown
    menu.display.firstPanel:initialise()
    menu.display.firstPanel.parent = menu.display
    menu.display:addChild(menu.display.firstPanel)

    panelPositionY = panelPositionY + panelPositionY

    menu.display.secondPanel = ISPanel:new(panelPositionX, panelPositionY + 2, panelWidth, panelHeight)
    menu.display.secondPanel.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.display.secondPanel.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.display.secondPanel.onMouseDown = self.onMouseDown
    menu.display.secondPanel:initialise()
    menu.display.secondPanel.parent = menu.display
    menu.display:addChild(menu.display.secondPanel)

    local heartWidth = 15
    local heartHeight = 14
    local heartPositionX = panelWidth / 2 - heartWidth
    local heartPositionY = (panelHeight - heartHeight) / 2

    menu.display.secondPanel.heart = ISImage:new(heartPositionX, heartPositionY, heartWidth, heartHeight, getTexture('media/ui/HeartRateMonitor/Heart.png'))
    menu.display.secondPanel.heart.onMouseDown = self.onMouseDown
    menu.display.secondPanel.heart:initialise()
    menu.display.secondPanel.heart.parent = menu.display.secondPanel
    menu.display.secondPanel:addChild(menu.display.secondPanel.heart)

    local fontHeight = getTextManager():getFontHeight(UIFont.Small)
    local heartRateWidth = 30
    local heartRateWidthPositionX = heartPositionX
    local heartRateWidthPositionY = heartPositionY

    menu.display.secondPanel.heartRate = ISRichTextPanel:new(heartRateWidthPositionX, heartRateWidthPositionY, heartRateWidth, fontHeight)
    menu.display.secondPanel.heartRate.onMouseDown = self.onMouseDown
    menu.display.secondPanel.heartRate:initialise()
    menu.display.secondPanel.heartRate:noBackground()
    menu.display.secondPanel.heartRate:ignoreHeightChange()
    menu.display.secondPanel.heartRate.autosetheight = false
    menu.display.secondPanel.heartRate.marginTop = 0
    menu.display.secondPanel:addChild(menu.display.secondPanel.heartRate)

    self.instance = menu
    self = menu
end

function HeartRateMonitorMenu:disable()
    HeartRateMonitorMenu.instance:removeFromUIManager()
    HeartRateMonitorMenu.instance = nil
end

function HeartRateMonitorMenu:resize(oldWidth, oldHeight, newWidth, newHeight)
    self:disable()
    self:show()
end

local heartbeatDelta = Blood.pulse.max
local ticks = 0
function HeartRateMonitorMenu:updateHeartbeat()
    if self.instance == nil then
        return false
    end

    self.instance.display.secondPanel.heart.backgroundColor.a = self.instance.display.secondPanel.heart.backgroundColor.a - 0.0175
    if ticks % heartbeatDelta == 0 then
        local pulse = round(Survivor:getBlood():getPulse())
        self.instance.display.secondPanel.heart.backgroundColor.a = opacity
        heartbeatDelta = Survivor:getBlood():getHeartbeatDelta(pulse)

        self.instance.display.secondPanel.heartRate.text = pulse
        local textWidth = getTextManager():MeasureStringX(UIFont.Small, tostring(pulse)) + 30
        self.instance.display.secondPanel.heartRate:setWidth(textWidth)
        self.instance.display.secondPanel.heartRate:paginate()

        ticks = 0
    end

    ticks = ticks + 1
end

function HeartRateMonitorMenu:isEquipped()
    for i = 0, getSpecificPlayer(0):getInventory():getItems():size() - 1 do
        local item = getSpecificPlayer(0):getInventory():getItems():get(i)
        if in_table(item:getFullType(), { HeartRateMonitorRight.fullType, HeartRateMonitorLeft.fullType }) and getSpecificPlayer(0):isEquipped(item) then
            return true
        end
    end

    return false
end

function HeartRateMonitorMenu:updateUI()
    if not self:isEquipped() then
        if self.instance ~= nil then
            self:disable()
        end

        return false
    end

    if self.instance == nil then
        self:show()
    end
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'Moodle' then
        Events.OnResolutionChange.Add(HeartRateMonitorMenu.resize)
        Events.OnTick.Add(function()
            if not getSpecificPlayer(0) or getSpecificPlayer(0):isDead() or not Survivor:isInitialized() then
                if HeartRateMonitorMenu.instance ~= nil then
                    HeartRateMonitorMenu:disable()
                end

                return false
            end

            HeartRateMonitorMenu:updateHeartbeat()
            HeartRateMonitorMenu:updateUI()
        end)
    end
end)
