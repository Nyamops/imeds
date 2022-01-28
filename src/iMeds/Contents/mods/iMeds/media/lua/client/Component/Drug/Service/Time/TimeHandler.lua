TimeHandler = {}

local modifiers = {
    { duration = 5, onset = 1 }, -- 15
    { duration = 5, onset = 1 }, -- 30
    { duration = 2, onset = 1 }, -- 1
    { duration = 2, onset = 0 }, -- 2
    { duration = 1.5, onset = 0 }, -- 3
    { duration = 1.5, onset = 0 }, -- 4
    { duration = 1, onset = 0 }, -- 5
    { duration = 1, onset = 0 }, -- 6
    { duration = 0.5, onset = 0 }, -- 7
    { duration = 0.5, onset = 0 }, -- 8
    { duration = 0.25, onset = 0 }, -- 9
    { duration = 0.25, onset = 0 }, -- 10
    { duration = 0.125, onset = 0 }, -- 11
    { duration = 0.125, onset = 0 }, -- 12
    { duration = 0.120, onset = 0 }, -- 13
    { duration = 0.120, onset = 0 }, -- 14
    { duration = 0.115, onset = 0 }, -- 15
    { duration = 0.115, onset = 0 }, -- 16
    { duration = 0.1, onset = 0 }, -- 17
    { duration = 0.1, onset = 0 }, -- 18
    { duration = 0.095, onset = 0 }, -- 19
    { duration = 0.095, onset = 0 }, -- 20
    { duration = 0.09, onset = 0 }, -- 21
    { duration = 0.09, onset = 0 }, -- 22
    { duration = 0.083, onset = 0 }, -- 23
    { duration = 0.083, onset = 0 }, -- 24
}

TimeHandler.initializeModifier = function()
    TimeHandler.durationModifier = modifiers[SandboxVars.DayLength].duration
    TimeHandler.onset = modifiers[SandboxVars.DayLength].onset
end

Events.OnGameStart.Add(TimeHandler.initializeModifier)