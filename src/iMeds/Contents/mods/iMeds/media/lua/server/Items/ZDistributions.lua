require 'Items/SuburbsDistributions'
require 'Items/ProceduralDistributions'

local suburbsDistribution = {
    all = {
        inventoryfemale = {
            items = {
                "iMeds.BismuthSubsalicylatePack", 0.001,
                "iMeds.AlkaginPack", 0.001,
                "iMeds.UmifenovirPack", 0.001,
                "iMeds.UnknownPack", 0.001,
                "iMeds.ButamiratePack", 0.001,
                "iMeds.HemoStopPack", 0.001,
                "iMeds.SyringePack", 0.001,
                "iMeds.NeedlePack", 0.001,
                "iMeds.BloodTestingKit", 0.001,
            }
        },
        inventorymale = {
            items = {
                "Pills", 0,
                "PillsAntiDep", 0.1,
                "PillsBeta", 0.1,
                "PillsVitamins", 0,
                "iMeds.HemoStopPack", 0.001,
                "iMeds.BismuthSubsalicylatePack", 0.001,
                "iMeds.AlkaginPack", 0.001,
                "iMeds.UmifenovirPack", 0.001,
                "iMeds.UnknownPack", 0.001,
                "iMeds.ButamiratePack", 0.001,
                "iMeds.HemoStopPack", 0.001,
                "iMeds.SyringePack", 0.001,
                "iMeds.NeedlePack", 0.001,
                "iMeds.BloodTestingKit", 0.001,
            }
        },
        medicine = {
            items = {
                "iMeds.BismuthSubsalicylatePack", 0.03,
                "iMeds.AlkaginPack", 0.05,
                "iMeds.UmifenovirPack", 0.03,
                "iMeds.MorphinePack", 0.03,
                "iMeds.UnknownPack", 2,
                "iMeds.ButamiratePack", 0.05,
                "iMeds.BismuthSubsalicylatePack", 0.05,
                "iMeds.HemoStopPack", 0.03,
                "iMeds.PeripheralVenousCatheter", 1,
                "iMeds.EmptyBloodBag", 1,
                "iMeds.BloodTestingKit", 4,
            },
        },
    },

    Bag_BigHikingBag = {
        items = {
            "iMeds.BismuthSubsalicylatePack", 0.03,
            "iMeds.AlkaginPack", 0.05,
            "iMeds.UmifenovirPack", 0.03,
            "iMeds.UnknownPack", 0.03,
            "iMeds.ButamiratePack", 0.05,
            "iMeds.BismuthSubsalicylatePack", 0.05,
            "iMeds.HemoStopPack", 0.03,
            "iMeds.SyringePack", 0.03,
            "iMeds.NeedlePack", 0.03,
        },
    },

    Bag_NormalHikingBag = {
        items = {
            "iMeds.BismuthSubsalicylatePack", 0.03,
            "iMeds.AlkaginPack", 0.05,
            "iMeds.UmifenovirPack", 0.03,
            "iMeds.UnknownPack", 0.03,
            "iMeds.ButamiratePack", 0.05,
            "iMeds.BismuthSubsalicylatePack", 0.05,
            "iMeds.HemoStopPack", 0.03,
            "iMeds.SyringePack", 0.03,
            "iMeds.NeedlePack", 0.03,
        },
    },

    Bag_SurvivorBag = {
        items = {
            "iMeds.BismuthSubsalicylatePack", 0.03,
            "iMeds.AlkaginPack", 0.05,
            "iMeds.UmifenovirPack", 0.03,
            "iMeds.UnknownPack", 0.03,
            "iMeds.ButamiratePack", 0.05,
            "iMeds.BismuthSubsalicylatePack", 0.05,
            "iMeds.HemoStopPack", 0.03,
            "iMeds.PeripheralVenousCatheter", 0.03,
            "iMeds.EmptyBloodBag", 0.03,
            "iMeds.BloodTestingKit", 0.03,
            "iMeds.SyringePack", 0.03,
            "iMeds.NeedlePack", 0.03,
        },
    },

    FirstAidKit = {
        rolls = 1,
        items = {
            "iMeds.UnknownPack", 0.03,
            "iMeds.UnknownPack", 0.03,
            "iMeds.UnknownPack", 0.03,
            "iMeds.ButamiratePack", 0.05,
            "iMeds.BismuthSubsalicylatePack", 0.05,
            "iMeds.HemoStopPack", 0.03,
            "iMeds.PeripheralVenousCatheter", 0.03,
            "iMeds.PeripheralVenousCatheter", 0.03,
            "iMeds.PeripheralVenousCatheter", 0.03,
            "iMeds.PeripheralVenousCatheter", 0.03,
            "iMeds.AlkaginPack", 0.05,
            "iMeds.AlkaginPack", 0.05,
            "iMeds.UmifenovirPack", 0.03,
            "iMeds.BloodTestingKit", 0.03,
            "iMeds.BloodTestingKit", 0.03,
            "iMeds.BloodTestingKit", 0.03,
            "iMeds.BloodTestingKit", 0.03,
            "iMeds.SyringePack", 0.5,
            "iMeds.SyringePack", 0.5,
            "iMeds.NeedlePack", 0.5,
            "iMeds.NeedlePack", 0.5,
        },
    },
}

local proceduralDistributions = {
    list = {
        ArmyStorageMedical = {
            items = {
                "iMeds.BismuthSubsalicylatePack", 2,

                "iMeds.AlkaginPack", 2,

                "iMeds.UmifenovirPack", 2,

                "iMeds.MorphinePack", 0.5,

                "iMeds.UnknownPack", 0.5,
                "iMeds.UnknownPack", 0.5,
                "iMeds.UnknownPack", 0.5,
                "iMeds.UnknownPack", 0.5,

                "iMeds.ButamiratePack", 2,

                "iMeds.BismuthSubsalicylatePack", 2,

                "iMeds.HemoStopPack", 0.5,
                "iMeds.HemoStopPack", 0.5,

                "iMeds.PeripheralVenousCatheter", 0.5,
                "iMeds.PeripheralVenousCatheter", 0.5,
                "iMeds.PeripheralVenousCatheter", 0.5,
                "iMeds.PeripheralVenousCatheter", 0.5,

                "iMeds.EmptyBloodBag", 0.5,
                "iMeds.EmptyBloodBag", 0.5,
                "iMeds.EmptyBloodBag", 0.5,
                "iMeds.EmptyBloodBag", 0.5,

                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,

                "iMeds.SyringePack", 2,
                "iMeds.SyringePack", 2,

                "iMeds.NeedlePack", 2,
                "iMeds.NeedlePack", 2,

                "iMeds.ErythrocyteSuspensionBagABN", 0.5,
                "iMeds.ErythrocyteSuspensionBagABN", 0.5,
                "iMeds.ErythrocyteSuspensionBagABN", 0.5,
                "iMeds.ErythrocyteSuspensionBagABP", 0.5,
                "iMeds.ErythrocyteSuspensionBagABP", 0.5,
                "iMeds.ErythrocyteSuspensionBagABP", 0.5,
                "iMeds.ErythrocyteSuspensionBagAN", 0.5,
                "iMeds.ErythrocyteSuspensionBagAN", 0.5,
                "iMeds.ErythrocyteSuspensionBagAN", 0.5,
                "iMeds.ErythrocyteSuspensionBagAP", 0.5,
                "iMeds.ErythrocyteSuspensionBagAP", 0.5,
                "iMeds.ErythrocyteSuspensionBagAP", 0.5,
                "iMeds.ErythrocyteSuspensionBagBN", 0.5,
                "iMeds.ErythrocyteSuspensionBagBN", 0.5,
                "iMeds.ErythrocyteSuspensionBagBN", 0.5,
                "iMeds.ErythrocyteSuspensionBagBP", 0.5,
                "iMeds.ErythrocyteSuspensionBagBP", 0.5,
                "iMeds.ErythrocyteSuspensionBagBP", 0.5,
                "iMeds.ErythrocyteSuspensionBagON", 0.5,
                "iMeds.ErythrocyteSuspensionBagON", 0.5,
                "iMeds.ErythrocyteSuspensionBagON", 0.5,
                "iMeds.ErythrocyteSuspensionBagOP", 0.5,
                "iMeds.ErythrocyteSuspensionBagOP", 0.5,
                "iMeds.ErythrocyteSuspensionBagOP", 0.5,

                "iMeds.PlasmaBagABN", 0.5,
                "iMeds.PlasmaBagABN", 0.5,
                "iMeds.PlasmaBagABN", 0.5,
                "iMeds.PlasmaBagABP", 0.5,
                "iMeds.PlasmaBagABP", 0.5,
                "iMeds.PlasmaBagABP", 0.5,
                "iMeds.PlasmaBagAN", 0.5,
                "iMeds.PlasmaBagAN", 0.5,
                "iMeds.PlasmaBagAN", 0.5,
                "iMeds.PlasmaBagAP", 0.5,
                "iMeds.PlasmaBagAP", 0.5,
                "iMeds.PlasmaBagAP", 0.5,
                "iMeds.PlasmaBagBN", 0.5,
                "iMeds.PlasmaBagBN", 0.5,
                "iMeds.PlasmaBagBN", 0.5,
                "iMeds.PlasmaBagBP", 0.5,
                "iMeds.PlasmaBagBP", 0.5,
                "iMeds.PlasmaBagBP", 0.5,
                "iMeds.PlasmaBagON", 0.5,
                "iMeds.PlasmaBagON", 0.5,
                "iMeds.PlasmaBagON", 0.5,
                "iMeds.PlasmaBagOP", 0.5,
                "iMeds.PlasmaBagOP", 0.5,
                "iMeds.PlasmaBagOP", 0.5,
            },
        },

        BathroomCounterNoMeds = {
            items = {
                "iMeds.UnknownPack", 0.03,
                "iMeds.UnknownPack", 0.03,
                "iMeds.SyringePack", 0.5,
                "iMeds.NeedlePack", 0.5,
            },
        },

        MedicalClinicDrugs = {
            items = {
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.MorphinePack", 5,
                "iMeds.MorphinePack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.ButamiratePack", 2,
                "iMeds.ButamiratePack", 2,
                "iMeds.ButamiratePack", 2,
                "iMeds.ButamiratePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.HemoStopPack", 5,
                "iMeds.HemoStopPack", 5,
                "iMeds.HemoStopPack", 5,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
            },
        },

        MedicalClinicOutfit = {
            items = {
                "iMeds.UnknownPack", 5,
                "iMeds.EmptyBloodBag", 1,
                "iMeds.EmptyBloodBag", 1,
                "iMeds.BloodTestingKit", 4,
                "iMeds.BloodTestingKit", 4,
                "iMeds.SyringePack", 5,
                "iMeds.NeedlePack", 5,
            },
        },

        MedicalClinicTools = {
            items = {
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
            },
        },

        MedicalStorageDrugs = {
            items = {
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.MorphinePack", 5,
                "iMeds.MorphinePack", 5,
                "iMeds.MorphinePack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.ButamiratePack", 2,
                "iMeds.ButamiratePack", 2,
                "iMeds.ButamiratePack", 2,
                "iMeds.ButamiratePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.HemoStopPack", 5,
                "iMeds.HemoStopPack", 5,

                "iMeds.ErythrocyteSuspensionBagABN", 0.5,
                "iMeds.ErythrocyteSuspensionBagABN", 0.5,
                "iMeds.ErythrocyteSuspensionBagABN", 0.5,
                "iMeds.ErythrocyteSuspensionBagABP", 0.5,
                "iMeds.ErythrocyteSuspensionBagABP", 0.5,
                "iMeds.ErythrocyteSuspensionBagABP", 0.5,
                "iMeds.ErythrocyteSuspensionBagAN", 0.5,
                "iMeds.ErythrocyteSuspensionBagAN", 0.5,
                "iMeds.ErythrocyteSuspensionBagAN", 0.5,
                "iMeds.ErythrocyteSuspensionBagAP", 0.5,
                "iMeds.ErythrocyteSuspensionBagAP", 0.5,
                "iMeds.ErythrocyteSuspensionBagAP", 0.5,
                "iMeds.ErythrocyteSuspensionBagBN", 0.5,
                "iMeds.ErythrocyteSuspensionBagBN", 0.5,
                "iMeds.ErythrocyteSuspensionBagBN", 0.5,
                "iMeds.ErythrocyteSuspensionBagBP", 0.5,
                "iMeds.ErythrocyteSuspensionBagBP", 0.5,
                "iMeds.ErythrocyteSuspensionBagBP", 0.5,
                "iMeds.ErythrocyteSuspensionBagON", 0.5,
                "iMeds.ErythrocyteSuspensionBagON", 0.5,
                "iMeds.ErythrocyteSuspensionBagON", 0.5,
                "iMeds.ErythrocyteSuspensionBagOP", 0.5,
                "iMeds.ErythrocyteSuspensionBagOP", 0.5,
                "iMeds.ErythrocyteSuspensionBagOP", 0.5,

                "iMeds.PlasmaBagABN", 0.5,
                "iMeds.PlasmaBagABN", 0.5,
                "iMeds.PlasmaBagABN", 0.5,
                "iMeds.PlasmaBagABP", 0.5,
                "iMeds.PlasmaBagABP", 0.5,
                "iMeds.PlasmaBagABP", 0.5,
                "iMeds.PlasmaBagAN", 0.5,
                "iMeds.PlasmaBagAN", 0.5,
                "iMeds.PlasmaBagAN", 0.5,
                "iMeds.PlasmaBagAP", 0.5,
                "iMeds.PlasmaBagAP", 0.5,
                "iMeds.PlasmaBagAP", 0.5,
                "iMeds.PlasmaBagBN", 0.5,
                "iMeds.PlasmaBagBN", 0.5,
                "iMeds.PlasmaBagBN", 0.5,
                "iMeds.PlasmaBagBP", 0.5,
                "iMeds.PlasmaBagBP", 0.5,
                "iMeds.PlasmaBagBP", 0.5,
                "iMeds.PlasmaBagON", 0.5,
                "iMeds.PlasmaBagON", 0.5,
                "iMeds.PlasmaBagON", 0.5,
                "iMeds.PlasmaBagOP", 0.5,
                "iMeds.PlasmaBagOP", 0.5,
                "iMeds.PlasmaBagOP", 0.5,
            },
        },

        MedicalStorageTools = {
            items = {
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.PeripheralVenousCatheter", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.EmptyBloodBag", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.BloodTestingKit", 2,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.SyringePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
                "iMeds.NeedlePack", 4,
            },
        },

        StoreShelfMedical = {
            items = {
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.AlkaginPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UmifenovirPack", 2,
                "iMeds.UnknownPack", 5,
                "iMeds.UnknownPack", 5,
                "iMeds.ButamiratePack", 2,
                "iMeds.ButamiratePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.BismuthSubsalicylatePack", 2,
                "iMeds.HemoStopPack", 5,
                "iMeds.HemoStopPack", 5,
                "iMeds.SyringePack", 2,
                "iMeds.SyringePack", 2,
                "iMeds.NeedlePack", 2,
                "iMeds.NeedlePack", 2,
            },
        },
    }
}

for location, data in pairs(suburbsDistribution.all) do
    for _, value in ipairs(data.items) do
        table.insert(SuburbsDistributions['all'][location].items, value);
    end
end

for location, data in pairs(proceduralDistributions.list) do
    for _, value in ipairs(data.items) do
        table.insert(ProceduralDistributions['list'][location].items, value);
    end
end
