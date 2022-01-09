ServerScreenSettingsProxy = {}

---@return ServerScreenSettingsProxy
function ServerScreenSettingsProxy:new()
    ---@class ServerScreenSettingsProxy
    local public = {}
    local private = {}

    ---@type ConfiguratorHandlerDecorator[]
    private.handlers = ZCore:getContainer():getByTag('imeds.configurator.sandbox.handler')

    ---@type ConfigurationReader
    private.configurationReader = ZCore:getContainer():get('imeds.configurator.service.configuration_reader')
    ---@type ConfigurationWriter
    private.configurationWriter = ZCore:getContainer():get('imeds.configurator.service.configuration_writer')

    private.ServerSettingsScreenProxy = {}
    private.ServerSettingsScreenProxy.create = ServerSettingsScreen.create

    local SettingsTable

    function ServerSettingsScreen:create()
        private.ServerSettingsScreenProxy.create(self)

        for _, category in ipairs(SettingsTable) do
            self.pageEdit.controls[category.name] = {}
            self.pageEdit.groupBox[category.name] = {}

            local item = {}
            item.category = category
            self.pageEdit.listbox:addItem(category.name, item)
            for _, page in ipairs(category.pages) do
                if not page.steamOnly or getSteamModeActive() then
                    item = {}
                    item.page = page
                    item.panel = self.pageEdit:createPanel(category, page)
                    self.pageEdit.listbox:addItem(page.name, item)
                end
            end
        end

        local this = {}

        this.pageEdit = self.pageEdit
        this.onSave = self.pageEdit.buttonAccept.onclick

        self.pageEdit.buttonAccept.onclick = function()
            local writer = private.configurationWriter:getWriter(this.pageEdit.settings:getName())

            for _, handler in pairs(private.handlers) do
                local value = this.pageEdit.controls.ImmersiveMedicine[handler:getShortName()].selected[1] and 'TRUE' or 'FALSE'
                writer:writeln(handler:getShortName() .. '=' .. value)
            end

            writer:close()

            this.onSave(this.pageEdit)
        end

        this.aboutToShow = self.pageEdit.aboutToShow

        function self.pageEdit:aboutToShow()
            this.aboutToShow(self)

            local reader = private.configurationReader:getReader(self.settings:getName())
            while true do
                local line = reader:readLine()
                if not line then
                    reader:close()
                    break
                end

                local config = line:trim()
                for _, handler in pairs(private.handlers) do
                    local configName = handler:getShortName() .. '='
                    if luautils.stringStarts(config, configName) then
                        self.controls.ImmersiveMedicine[handler:getShortName()].selected[1] = string.split(config, '=')[2] == 'TRUE'
                    end
                end
            end
        end
    end

    SettingsTable = {
        {
            name = 'ImmersiveMedicine',
            pages = {},
        },
    }

    local addedPages = {}
    for _, handler in pairs(private.handlers) do
        if addedPages[handler:getOption():getPageName()] == nil then
            table.insert(SettingsTable[1].pages, { name = handler:getOption():getPageName(), settings = {} })
            addedPages[handler:getOption():getPageName()] = true
        end
    end

    for _, handler in pairs(private.handlers) do
        for i, pageData in ipairs(SettingsTable[1].pages) do
            if pageData.name == handler:getOption():getPageName() then
                table.insert(SettingsTable[1].pages[i].settings, { name = handler:getShortName() })
            end
        end
    end

    ---Duplicated block
    if true then
        local serverOptions = ServerOptions:new()
        local missedSettings = {}
        for i = 1, serverOptions:getNumOptions() do
            missedSettings[serverOptions:getOptionByIndex(i - 1):getName()] = true
        end

        local pageByName = {}
        for _, page in ipairs(SettingsTable[1].pages) do
            local pageName = page.title or page.name
            pageByName[pageName] = page
        end

        for i = 1, getSandboxOptions():getNumOptions() do
            local option = getSandboxOptions():getOptionByIndex(i - 1)
            if option:isCustom() and option:getPageName() ~= nil then
                local page = pageByName[option:getPageName()]
                if not page then
                    page = {}
                    page.name = option:getPageName()
                    page.settings = {}
                    table.insert(SettingsTable[1].pages, page)
                    pageByName[page.name] = page
                end
                table.insert(page.settings, { name = option:getName() })
            end
            missedSettings[option:getName()] = true
        end

        for _, page in ipairs(SettingsTable[1].pages) do
            page.name = page.title or getText("Sandbox_" .. page.name)
            for _, setting in ipairs(page.settings) do
                local option = getSandboxOptions():getOptionByName(setting.name)
                if not option then
                    error('unknown sandbox option "' .. setting.name .. "'")
                end
                --		option = option:asConfigOption()
                setting.translatedName = option:getTranslatedName()
                setting.tooltip = option:getTooltip()
                if option:getType() == "boolean" then
                    setting.type = "checkbox"
                    setting.default = option:getDefaultValue()
                elseif option:getType() == "double" then
                    setting.type = "entry"
                    setting.text = option:getValueAsString()
                    setting.onlyNumbers = false -- TODO: UITextBox2 handle floating-point
                elseif option:getType() == "enum" then
                    setting.type = "enum"
                    setting.values = {}
                    for k = 1, option:getNumValues() do
                        if setting.name == "StartYear" then
                            table.insert(setting.values, tostring(getSandboxOptions():getFirstYear() + k - 1))
                        elseif setting.name == "StartDay" then
                            table.insert(setting.values, tostring(k))
                        else
                            table.insert(setting.values, option:getValueTranslationByIndex(k))
                        end
                    end
                    setting.default = option:getDefaultValue();
                elseif option:getType() == "integer" then
                    setting.type = "entry"
                    setting.text = option:getValueAsString()
                    setting.onlyNumbers = true
                elseif option:getType() == "string" then
                    setting.type = "string"
                    setting.text = option:getValue()
                elseif option:getType() == "text" then
                    setting.type = "text"
                    setting.text = option:getValue()
                else
                    error("unknown sandbox option type " .. tostring(option:getType()))
                end
                missedSettings[option:getName()] = nil
            end
        end

        for key, value in pairs(missedSettings) do
            print('MISSING in SettingsTable: ' .. key)
        end
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'ServerScreenSettingsProxy'

    return public
end

return ServerScreenSettingsProxy