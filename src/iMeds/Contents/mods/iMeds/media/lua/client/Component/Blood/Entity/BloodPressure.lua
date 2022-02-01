---@class BloodPressure
BloodPressure = {}

BloodPressure.systolic = {
    normal = 120,
    min = 36, -- -70%
    max = 180, -- +50%
}
BloodPressure.diastolic = {
    normal = 80,
    min = 24, -- -70%
    max = 120, -- +50%
}

---@return number
function BloodPressure:getSystolic()
    if getPlayer():getModData().survivor.blood.pressure.systolic == nil then
        getPlayer():getModData().survivor.blood.pressure.systolic = self.systolic.normal
    end

    return getPlayer():getModData().survivor.blood.pressure.systolic
end

---@param value number
---@return void
function BloodPressure:setSystolic(value)
    getPlayer():getModData().survivor.blood.pressure.systolic = value
end

---@return number
function BloodPressure:getDiastolic()
    if getPlayer():getModData().survivor.blood.pressure.diastolic == nil then
        getPlayer():getModData().survivor.blood.pressure.diastolic = self.diastolic.normal
    end

    return getPlayer():getModData().survivor.blood.pressure.diastolic
end

---@param value number
---@return void
function BloodPressure:setDiastolic(value)
    getPlayer():getModData().survivor.blood.pressure.diastolic = value
end

return BloodPressure
