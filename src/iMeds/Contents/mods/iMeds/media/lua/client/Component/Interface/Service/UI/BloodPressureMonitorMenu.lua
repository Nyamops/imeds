require 'ISUI/ISPanel'
require 'ISUI/ISRichTextPanel'
require 'ISUI/ISButton'

--TODO ISRadioWindow / RWMPower / ISRadioAction / DeviceInspector
BloodPressureMonitorMenu = ISPanel:derive('BloodPressureMonitorMenu')

local defaultPadding = 6
local opacity = 0.2
local isPinned = false
local bigIndicatorPosition = {
    { x = 1, y = 0, width = 17, height = 4 },
    { x = 15, y = 3, width = 4, height = 15 },
    { x = 15, y = 21, width = 4, height = 15 },
    { x = 1, y = 34, width = 17, height = 4 },
    { x = 0, y = 21, width = 4, height = 15 },
    { x = 0, y = 3, width = 4, height = 15 },
    { x = 2, y = 17, width = 15, height = 5 },
}
--[[
    1
  6   2
    7
  5   3
    4
]]
local segmentsByNumber = {
    { 2, 3 },
    { 1, 2, 4, 5, 7 },
    { 1, 2, 3, 4, 7 },
    { 2, 3, 6, 7 },
    { 1, 3, 4, 6, 7 },
    { 1, 3, 4, 5, 6, 7 },
    { 1, 2, 3 },
    { 1, 2, 3, 4, 5, 6, 7 },
    { 1, 2, 3, 4, 6, 7 },
}
segmentsByNumber[0] = { 1, 2, 3, 4, 5, 6 }
local bigIndicatorWidth = 19
local bigIndicatorHeight = 38
local bigIndicatorRowWidth = 61
local bigIndicatorRowHeight = 38

function BloodPressureMonitorMenu:initialise()
    ISPanel.initialise(self)
end

function BloodPressureMonitorMenu:render()
    if not Survivor:isInitialized() or isPinned then
        return false
    end

    self.backgroundColor.a = opacity
end

function BloodPressureMonitorMenu:onMouseMove(x, y)
    opacity = 1
end

function BloodPressureMonitorMenu:onMouseMoveOutside(x, y)
    if not isPinned then
        opacity = 0.2
    end
end

function BloodPressureMonitorMenu:onMouseDown(x, y)
    isPinned = not isPinned
end

---@return BloodPressureMonitorMenu
function BloodPressureMonitorMenu:new(positionX, positionY, width, height)
    ---@class BloodPressureMonitorMenu
    local public = {}

    public = ISPanel:new(positionX, positionY, width, height)
    setmetatable(public, self)
    self.__index = self
    public.borderColor = { r = 0, g = 1, b = 0, a = 0 }
    public.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    public.onMouseMove = self.onMouseMove
    public.onMouseMoveOutside = self.onMouseMoveOutside
    public.positionX = positionX
    public.positionY = positionY
    public.width = width
    public.height = height
    public.resizable = false

    return public
end

function BloodPressureMonitorMenu:addSystolicRow()
    self.systolicRow = ISPanel:new(46, 18, bigIndicatorRowWidth, bigIndicatorRowHeight)
    self.systolicRow:noBackground()
    self.systolicRow:initialise()
    self.systolicRow.indicators = {}
    self.displayBackground:addChild(self.systolicRow)

    local bigIndicatorPositionX = 0
    for i = 1, 3 do
        self.systolicRow.indicators[i] = ISPanel:new(bigIndicatorPositionX, 0, bigIndicatorWidth, bigIndicatorHeight)
        self.systolicRow.indicators[i].backgroundColor = { r = 146 / 255, g = 155 / 255, b = 152 / 255, a = 1 }
        self.systolicRow.indicators[i].borderColor = { r = 0, g = 0, b = 0, a = 0 }
        self.systolicRow.indicators[i]:initialise()
        self.systolicRow.indicators[i].segments = {}
        self.systolicRow:addChild(self.systolicRow.indicators[i])

        for j = 1, 7 do
            self.systolicRow.indicators[i].segments[j] = ISPanel:new(bigIndicatorPosition[j].x, bigIndicatorPosition[j].y, bigIndicatorPosition[j].width, bigIndicatorPosition[j].height)
            self.systolicRow.indicators[i].segments[j].backgroundColor = { r = 0, g = 0, b = 0, a = 1 }
            self.systolicRow.indicators[i].segments[j].borderColor = { r = 0, g = 0, b = 0, a = 0 }
            self.systolicRow.indicators[i].segments[j]:initialise()
            self.systolicRow.indicators[i].segments[j]:setVisible(false)
            self.systolicRow.indicators[i]:addChild(self.systolicRow.indicators[i].segments[j])
        end

        bigIndicatorPositionX = bigIndicatorPositionX + bigIndicatorWidth + 2
    end
end

function BloodPressureMonitorMenu:addDiastolicRow()
    self.diastolicRow = ISPanel:new(46, 62, bigIndicatorRowWidth, bigIndicatorRowHeight)
    self.diastolicRow:noBackground()
    self.diastolicRow:initialise()
    self.diastolicRow.indicators = {}
    self.displayBackground:addChild(self.diastolicRow)

    local bigIndicatorPositionX = 0
    for i = 1, 3 do
        self.diastolicRow.indicators[i] = ISPanel:new(bigIndicatorPositionX, 0, bigIndicatorWidth, bigIndicatorHeight)
        self.diastolicRow.indicators[i].backgroundColor = { r = 146 / 255, g = 155 / 255, b = 152 / 255, a = 1 }
        self.diastolicRow.indicators[i].borderColor = { r = 0, g = 0, b = 0, a = 0 }
        self.diastolicRow.indicators[i]:initialise()
        self.diastolicRow.indicators[i].segments = {}
        self.diastolicRow:addChild(self.diastolicRow.indicators[i])

        for j = 1, 7 do
            self.diastolicRow.indicators[i].segments[j] = ISPanel:new(bigIndicatorPosition[j].x, bigIndicatorPosition[j].y, bigIndicatorPosition[j].width, bigIndicatorPosition[j].height)
            self.diastolicRow.indicators[i].segments[j].backgroundColor = { r = 0, g = 0, b = 0, a = 1 }
            self.diastolicRow.indicators[i].segments[j].borderColor = { r = 0, g = 0, b = 0, a = 0 }
            self.diastolicRow.indicators[i].segments[j]:initialise()
            self.diastolicRow.indicators[i].segments[j]:setVisible(false)
            self.diastolicRow.indicators[i]:addChild(self.diastolicRow.indicators[i].segments[j])
        end

        bigIndicatorPositionX = bigIndicatorPositionX + bigIndicatorWidth + 2
    end
end

function BloodPressureMonitorMenu:show()
    local width = 150
    local height = 200
    local rightPadding = 81 + defaultPadding * 2
    local topPadding = 100

    local menu = self:new(getCore():getScreenWidth() - rightPadding - width, topPadding, width, height)
    menu:addToUIManager()
    menu:setVisible(true)

    local displayBackgroundWidth = 112
    local displayBackgroundHeight = 128
    menu.displayBackground = ISPanel:new(19, 21, displayBackgroundWidth, displayBackgroundHeight)
    menu.displayBackground.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.displayBackground.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.displayBackground:initialise()
    menu:addChild(menu.displayBackground)

    self.addSystolicRow(menu)
    self.addDiastolicRow(menu)

    menu.display = ISImage:new(0, 0, width, height, getTexture('media/ui/BloodPressureMonitor/Display.png'))
    menu.display:initialise()
    menu.display.parent = menu
    menu:addChild(menu.display)

    local buttonPositionX = 7
    local buttonPositionY = 167
    local buttonWidth = 138
    local buttonHeight = 33

    menu.display.button = ISButton:new(buttonPositionX, buttonPositionY, buttonWidth, buttonHeight, '', menu, self.checkBloodPressure)
    menu.display.button.internal = "CLOSE"
    menu.display.button.anchorLeft = false
    menu.display.button.anchorRight = true
    menu.display.button.anchorTop = false
    menu.display.button.anchorBottom = true
    menu.display.button:initialise()
    menu.display.button:instantiate()
    menu.display.button.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.display.button.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    menu.display.button.backgroundColorMouseOver.a = 0
    menu.display.button.parent = menu.display
    menu.display:addChild(menu.display.button)

    self.instance = menu
    self = menu
end

function BloodPressureMonitorMenu:checkBloodPressure()
    ISTimedActionQueue.add(CheckBloodPressureAction:new(getPlayer(), BloodPressureMonitorMenu.instance.item))
end

function BloodPressureMonitorMenu:disable()
    BloodPressureMonitorMenu.instance:removeFromUIManager()
    BloodPressureMonitorMenu.instance = nil
end

function BloodPressureMonitorMenu:resize(oldWidth, oldHeight, newWidth, newHeight)
    self:disable()
    self:show()
end

function BloodPressureMonitorMenu:getDigitsFromNumber(number)
    number = tostring(number)

    local values = {}
    if string.len(number) == 3 then
        values[1], values[2], values[3] = string.match(number, '(%d+)(%d+)(%d+)')
    else
        values[1] = nil
        values[2], values[3] = string.match(number, '(%d+)(%d+)')
    end

    return values
end

function BloodPressureMonitorMenu:updateSystolicBloodPressure()
    self:resetSystolicIndicators()
    local digits = self:getDigitsFromNumber(Survivor:getBlood():getPressure():getSystolic())
    for i = 3, 1, -1 do
        if digits[i] ~= nil then
            for _, segmentId in ipairs(segmentsByNumber[tonumber(digits[i])]) do
                self.instance.systolicRow.indicators[i].segments[segmentId]:setVisible(true)
            end
        end
    end
end

function BloodPressureMonitorMenu:updateDiastolicBloodPressure()
    self:resetDiastolicIndicators()
    local digits = self:getDigitsFromNumber(Survivor:getBlood():getPressure():getDiastolic())
    for i = 3, 1, -1 do
        if digits[i] ~= nil then
            for _, segmentId in ipairs(segmentsByNumber[tonumber(digits[i])]) do
                self.instance.diastolicRow.indicators[i].segments[segmentId]:setVisible(true)
            end
        end
    end
end

function BloodPressureMonitorMenu:resetSystolicIndicators()
    for i = 1, 3 do
        for j = 1, 7 do
            self.instance.systolicRow.indicators[i].segments[j]:setVisible(false)
        end
    end
end

function BloodPressureMonitorMenu:resetDiastolicIndicators()
    for i = 1, 3 do
        for j = 1, 7 do
            self.instance.diastolicRow.indicators[i].segments[j]:setVisible(false)
        end
    end
end

function BloodPressureMonitorMenu:updateUI()
    local wristMonitor
    for i = 0, getPlayer():getInventory():getItems():size() - 1 do
        local item = getPlayer():getInventory():getItems():get(i)
        if in_table(item:getFullType(), { BloodPressureMonitorRight.alias, BloodPressureMonitorLeft.alias }) and getPlayer():isEquipped(item) then
            wristMonitor = item
        end
    end

    if wristMonitor == nil then
        if self.instance ~= nil then
            self:disable()
        end

        return false
    end

    if self.instance == nil then
        self:show()
        self.instance.item = wristMonitor
    end
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'Moodle' then
        Events.OnResolutionChange.Add(BloodPressureMonitorMenu.resize)
        Events.OnPlayerDeath.Add(BloodPressureMonitorMenu.disable)
        Events.OnTick.Add(function()
            BloodPressureMonitorMenu:updateUI()
        end)
    end
end)
