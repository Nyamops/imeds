TimeHandler = {}

TimeHandler.initializeModifier = function()
    local modifier = 0
    local tenMinutesInSeconds = 600
    if SandboxVars.DayLength == 1 then
        -- 1 real minute = 96 in game minutes; 6.25 real seconds = 10 in game minutes
        modifier = 5
    elseif SandboxVars.DayLength == 2 then
        modifier = 5
    elseif SandboxVars.DayLength == 3 then
        modifier = 2
    elseif SandboxVars.DayLength == 4 then
        modifier = 2
    else
        local inGameMinuteByOneRealMinute = 24 / (SandboxVars.DayLength - 2)
        local inGameTenMinutesByOneRealSecond = tenMinutesInSeconds / inGameMinuteByOneRealMinute
        modifier = tenMinutesInSeconds / inGameTenMinutesByOneRealSecond
        if modifier > 2 then
            modifier = 2
        end
    end

    TimeHandler.modifier = modifier
end

Events.OnGameStart.Add(TimeHandler.initializeModifier)