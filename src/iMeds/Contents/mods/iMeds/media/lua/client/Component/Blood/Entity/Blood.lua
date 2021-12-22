---@class Blood
Blood = {}

Blood.maxVolume = 5000
Blood.minVolume = 2000

---@return number
function Blood:getVolume()
    return getPlayer():getModData().survivor.blood.volume
end

---@param value number
---@return void
function Blood:setVolume(value)
    getPlayer():getModData().survivor.blood.volume = value
end

---@param value number
---@return void
function Blood:addVolume(value)
    getPlayer():getModData().survivor.blood.volume = getPlayer():getModData().survivor.blood.volume + value
end

---@param value number
---@return void
function Blood:reduceVolume(value)
    getPlayer():getModData().survivor.blood.volume = getPlayer():getModData().survivor.blood.volume - value
end

---@return BloodGroup
function Blood:getGroup()
    ---@type BloodGroupStorage
    local bloodGroupStorage = ZCore:getContainer():get('imeds.blood.storage.blood_group_storage')

    return bloodGroupStorage:getById(getPlayer():getModData().survivor.blood.group)
end

---@param id number
---@return void
function Blood:setGroup(id)
    getPlayer():getModData().survivor.blood.group = id
end

---@return table<string, table>
function Blood:getDrugs()
    return getPlayer():getModData().survivor.blood.drugs or {}
end

---@param drug Drug
---@param dosageForm string
---@param dose number
---@return void
function Blood:addDrug(drug, dosageForm, dose)
    if getPlayer():getModData().survivor.blood.drugs[drug:getAlias()] == nil then
        getPlayer():getModData().survivor.blood.drugs[drug:getAlias()] = {}

        getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].maxDose = drug:getMaxDose()
        getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].dose = 0
        getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].duration = 0
        getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].onset = 0
    end

    getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].dose = getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].dose + dose

    local onset = drug:getOnsetByDosageForm(dosageForm)
    local duration = drug:getDurationByDosageForm(dosageForm) * TimeHandler.modifier
    if getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].dose > 1 then
        duration = duration / 2
        onset = 0
    end

    getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].onset = onset
    getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].duration = getPlayer():getModData().survivor.blood.drugs[drug:getAlias()].duration + duration


end

return Blood