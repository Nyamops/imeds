Events.OnGameBoot.Add(
    function()
        local container = ZCore:getContainer()

        container:register(
            require 'Component/Configurator/Service/Configuration/ConfigurationReader',
            'imeds.configurator.service.configuration_reader',
            {}
        )

        container:register(
            require 'Component/Configurator/Service/Configuration/ConfigurationWriter',
            'imeds.configurator.service.configuration_writer',
            {}
        )

        container:register(
            require 'Component/Configurator/Service/Proxy/SandboxSettingsProxy',
            'imeds.configurator.service.sandbox_settings_proxy',
            {}
        )

        container:register(
            require 'Component/Configurator/Service/Proxy/ServerScreenSettingsProxy',
            'imeds.configurator.service.server_screen_settings_proxy',
            {}
        )

        container:register(
            require 'Component/Configurator/Service/Proxy/ServerSandboxOptionsUIProxy',
            'imeds.configurator.service.server_sandbox_options_ui_proxy',
            {}
        )

        local logger = container:get('imeds.logger.default')
        logger:info('Immersive Medicine Configurator component successfully loaded!')
    end
)