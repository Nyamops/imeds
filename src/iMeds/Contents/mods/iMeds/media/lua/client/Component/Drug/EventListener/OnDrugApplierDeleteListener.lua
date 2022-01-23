OnDrugApplierDeleteListener = {}

---@return OnDrugApplierDeleteListener
function OnDrugApplierDeleteListener:new()
    ---@class OnDrugApplierDeleteListener
    local public = {}

    function public:update(data)
        local dosageForm = data.drug.dosageForm
        ---@type DrugStorage
        local drugStorage = ZCore:getContainer():get('imeds.drug.storage.drug_storage')
        local drug = drugStorage:getByFullType(data.drug.fullType)

        local dose
        if DosageForm.Oral[dosageForm] ~= nil then
            dose = drug:getSingleDose()
        elseif DosageForm.Parenteral[dosageForm] ~= nil then
            dose = data.drug.dose
        end

        if getPlayer():HasTrait(OpioidAddiction.alias) then
            if drug:getAlias() == Morphine.alias then
                dose = round(dose * 0.6, 2)
            end
        end

        if DosageForm.Oral[dosageForm] ~= nil then
            if drug:getAlias() == Morphine.alias then
                dose = round(dose / 6, 2)
            end

            Survivor:getBlood():addDrug(drug, dosageForm, dose)

            return
        end

        if DosageForm.Parenteral[dosageForm] ~= nil then
            Survivor:getBlood():addDrug(drug, dosageForm, dose)

            return
        end

        if DosageForm.Topical[dosageForm] ~= nil then
            if drug:getAlias() == HemoStop.alias then
                local bodyPart = BodyPartType.FromString(data.drug.bodyPartType)
                Survivor:getBodyPartByType(bodyPart):setBleeding(false)
                Survivor:getBodyPartByType(bodyPart):setBleedingTime(0)
            end

            return
        end

        if DosageForm.Intranasal[dosageForm] ~= nil then
            Survivor:getBlood():addDrug(drug, dosageForm, drug:getSingleDose())

            return
        end
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OnDrugApplierDeleteListener'

    return public
end

Events.OnGameBoot.Add(
    function()
        ---@type EventDispatcher
        local eventDispatcher = ZCore:getContainer():get('imeds.event.event_dispatcher')
        eventDispatcher:subscribe('onDrugApplierDelete', OnDrugApplierDeleteListener:new())
    end
)