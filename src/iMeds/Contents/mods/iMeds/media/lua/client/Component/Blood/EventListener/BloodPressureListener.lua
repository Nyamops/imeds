local incrementValue = 0.04
local bloodPressurePenaltyPercentage = { 0.9, 0.75, 0.5, 0.3 }

local updateBloodPressure = function()
    if not getPlayer() or getPlayer():isDead() or not Survivor:isInitialized() then
        return false
    end

    local requestedBloodPressurePercentage = 1
    local bloodLoss = Blood.maxVolume - Survivor:getBlood():getVolume()
    if bloodLoss > 250 and bloodLoss <= 1000 then
        requestedBloodPressurePercentage = bloodPressurePenaltyPercentage[1]
    elseif bloodLoss > 1000 and bloodLoss <= 2000 then
        requestedBloodPressurePercentage = bloodPressurePenaltyPercentage[2]
    elseif bloodLoss > 2000 and bloodLoss <= 3500 then
        requestedBloodPressurePercentage = bloodPressurePenaltyPercentage[3]
    elseif bloodLoss > 3500 and bloodLoss <= 3600 then
        requestedBloodPressurePercentage = bloodPressurePenaltyPercentage[4]
    end

    local systolicPressure = BloodPressure.systolic.normal
    local requestedSystolicBloodPressure = BloodPressure.systolic.normal * requestedBloodPressurePercentage
    if Survivor:getBlood():getPressure():getSystolic() < requestedSystolicBloodPressure then
        systolicPressure = Survivor:getBlood():getPressure():getSystolic() + incrementValue * getGameTime():getMultiplier()
    elseif requestedBloodPressurePercentage < 1 then
        systolicPressure = Survivor:getBlood():getPressure():getSystolic() - incrementValue * getGameTime():getMultiplier()
    end

    Survivor:getBlood():getPressure():setSystolic(systolicPressure)

    local diastolicPressure = BloodPressure.diastolic.normal
    local requestedDiastolicBloodPressure = BloodPressure.diastolic.normal * requestedBloodPressurePercentage
    if Survivor:getBlood():getPressure():getDiastolic() < requestedDiastolicBloodPressure then
        diastolicPressure = Survivor:getBlood():getPressure():getDiastolic() + incrementValue * getGameTime():getMultiplier()
    else
        diastolicPressure = Survivor:getBlood():getPressure():getDiastolic() - incrementValue * getGameTime():getMultiplier()
    end

    Survivor:getBlood():getPressure():setDiastolic(diastolicPressure)

    if Survivor:getBlood():getPressure():getSystolic() < BloodPressure.systolic.min then
        Survivor:getBlood():getPressure():setSystolic(BloodPressure.systolic.min)
    end

    if Survivor:getBlood():getPressure():getSystolic() > BloodPressure.systolic.max then
        Survivor:getBlood():getPressure():setSystolic(BloodPressure.systolic.max)
    end

    if Survivor:getBlood():getPressure():getDiastolic() < BloodPressure.diastolic.min then
        Survivor:getBlood():getPressure():setDiastolic(BloodPressure.diastolic.min)
    end

    if Survivor:getBlood():getPressure():getDiastolic() > BloodPressure.diastolic.max then
        Survivor:getBlood():getPressure():setDiastolic(BloodPressure.diastolic.max)
    end

    print('getDiastolic: ' .. Survivor:getBlood():getPressure():getDiastolic())
    print('getSystolic: ' .. Survivor:getBlood():getPressure():getSystolic())
end

Events[ImmersiveMedicineEvent.iMedsSurvivorCreated].Add(function(module)
    if module == 'Blood' then
        Events.OnTick.Add(updateBloodPressure)
    end
end)