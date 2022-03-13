Preparation = {}

function Preparation:washHands(doctor, cleaningItem)
    for _, bodyPart in ipairs({ BodyPartType.Hand_R, BodyPartType.Hand_L, BodyPartType.ForeArm_R, BodyPartType.ForeArm_L }) do
        local bloodBodyPart = BloodBodyPartType.FromIndex(BodyPartType.ToIndex(bodyPart))
        if doctor:getHumanVisual():getBlood(bloodBodyPart) > 0 and cleaningItem ~= nil and round(cleaningItem:getDrainableUsesFloat()) > 0 then
            cleaningItem:Use()
            doctor:getHumanVisual():setBlood(bloodBodyPart, 0)
        end
    end
end

function Preparation:cleanSurgicalInstrument(instrument, cleaningItem)
    if cleaningItem ~= nil and round(cleaningItem:getDrainableUsesFloat()) > 0 and instrument ~= nil and instrument:getBloodLevel() > 0 then
        cleaningItem:Use()
        instrument:setBloodLevel(0)
    end
end

function Preparation:cleanSurgicalEquipment(equipment, cleaningItem)
    if cleaningItem ~= nil and round(cleaningItem:getDrainableUsesFloat()) > 0 and equipment ~= nil and equipment:getBloodLevel() > 0 then
        cleaningItem:Use()
        equipment:setBloodLevel(0)
    end
end