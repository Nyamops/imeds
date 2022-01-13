-- TODO Remove it with the next update
Events.OnTick.Add(function()
    if getPlayer():HasTrait(UniversalDonor.alias) and Survivor:getBlood():getGroup():getId() == BloodGroup.ABP then
        Survivor:getBlood():setGroup(BloodGroup.ON)
    elseif getPlayer():HasTrait(UniversalRecipient.alias) and Survivor:getBlood():getGroup():getId() == BloodGroup.ON then
        Survivor:getBlood():setGroup(BloodGroup.ABP)
    end
end)