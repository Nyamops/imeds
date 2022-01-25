---@class BloodPressure
BloodPressure = {}

BloodPressure.systolic = {
    normal = 100,
    min = 50,
    max = 180
}
BloodPressure.diastolic = {
    normal = 60,
    min = 10,
    max = 110,
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
