OpioidAddiction = {
    alias = 'OpioidAddiction',
    name = getText('UI_SideEffect_OpioidAddiction_Name'),
    description = {
        getText('UI_SideEffect_OpioidAddiction_Lvl_1_Description'),
        getText('UI_SideEffect_OpioidAddiction_Lvl_2_Description'),
        getText('UI_SideEffect_OpioidAddiction_Lvl_3_Description'),
    },
    maxLevel = 3,
    isDurationEnabled = false,
    duration = 0,
    exclusives = {},
}

ZCore:getContainer():register(
    require 'Component/SideEffect/Entity/SideEffect',
    'imeds.side_effect.entity.opioid_addiction',
    {
        OpioidAddiction,
    },
    'imeds.side_effect.entity'
)

Events.OnTick.Add(
    function()
        if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
            return false
        end

        local sideEffect = Survivor:getSideEffects()[OpioidAddiction.alias]
        if sideEffect == nil then
            return false
        end

        if not sideEffect.isActive then
            return false
        end
    end
)