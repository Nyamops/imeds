DrugPackStorage = {}

---@return DrugPackStorage
function DrugPackStorage:new()
    ---@class DrugPackStorage
    local public = {}
    local private = {}

    ---@type Pack[]
    private.packs = ZCore:getContainer():getByTag('imeds.drug.entity.drug.pack')

    ---@return Pack
    function public:getOneByRandom()
        local indexedDrugs = {}
        for _, drug in pairs(private.packs) do
            table.insert(indexedDrugs, drug)
        end

        return indexedDrugs[ZombRand(1, #indexedDrugs)]
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'DrugPackStorage'

    return public
end

return DrugPackStorage