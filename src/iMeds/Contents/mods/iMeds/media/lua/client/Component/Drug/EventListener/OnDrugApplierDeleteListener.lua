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

        if DosageForm.Oral[dosageForm] ~= nil then
            local dose = drug:getSingleDose()
            if drug:getAlias() == Morphine.alias then
                dose = round(dose / 6, 2)
            end

            Survivor:getBlood():addDrug(drug, dosageForm, dose)
        elseif DosageForm.Parenteral[dosageForm] ~= nil then
            Survivor:getBlood():addDrug(drug, dosageForm, data.drug.dose)
        elseif DosageForm.Topical[dosageForm] ~= nil then
            if drug:getAlias() == HemoStop.alias then
                local bodyPart = BodyPartType.FromString(data.drug.bodyPartType)
                Survivor:getBodyPartByType(bodyPart):setBleeding(false)
                Survivor:getBodyPartByType(bodyPart):setBleedingTime(0)
            end

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