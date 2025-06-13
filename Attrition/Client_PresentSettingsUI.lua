

function Client_PresentSettingsUI (rootParent)

    UI.CreateLabel(rootParent).SetText("Base Armies lost per turn: "..Mod.Settings.Base_Armies)
    UI.CreateLabel(rootParent).SetText("Base Percentage of armies lost per turn: "..Mod.Settings.Base_Percent)

    if Mod.Settings.Additional_StartsAt > 0 then
        UI.CreateLabel(rootParent).SetText("\nAdditional armies lost per turn above "..Mod.Settings.Additional_StartsAt.." armies: "..Mod.Settings.Additional_Armies)
        UI.CreateLabel(rootParent).SetText("Additional percentage of armies lost per turn above "..Mod.Settings.Additional_StartsAt.." armies: "..
            Mod.Settings.Additional_Percent)
    end

    UI.CreateLabel(rootParent).SetText("\nArmies recovered from attrition by city: "..Mod.Settings.City_Armies)
    UI.CreateLabel(rootParent).SetText("City can recover what percentage of armies from attrition: "..Mod.Settings.City_Percent)


end