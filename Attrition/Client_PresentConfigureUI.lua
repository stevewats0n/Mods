



function Client_PresentConfigureUI (rootParent)

    function CreateHorz (text, min, max, name)
        local horz = UI.CreateHorizontalLayoutGroup(rootParent)
        UI.CreateLabel(horz).SetText(text)
        local Prepop = 0
        if Mod.Settings[name] ~= nil then Prepop = Mod.Settings[name] end
        Value = UI.CreateNumberInputField(horz)
            .SetValue(Prepop).SetSliderMinValue(min).SetSliderMaxValue(max)
        return(Value)
    end

    function QuickVert ()
        Vert = UI.CreateVerticalLayoutGroup(rootParent)
    end
    

    QuickVert()
    UI.CreateLabel(Vert).SetText("Set number/percentage of armies to lose on each territory. You can also set additional attrition above a certain army number, and separate rules for cities.")
        Base_Armies = CreateHorz("Armies to lose per turn to attrition", 0, 10, "Base_Armies")
        Base_Percent = CreateHorz("Percentage of armies to lose to attrition", 0, 20, "Base_Percent")

    QuickVert()
    UI.CreateLabel(Vert).SetText("\n Keep the following three boxes as 0 if you don't want more attrition rules.")
        Additional_StartsAt = CreateHorz("Extra attrition starts over how many armies (non-inclusive)?", 0, 20, "Additional_StartsAt")
        Additional_Armies = CreateHorz("Additional armies to lose per turn to attrition", 0, 10, "Additional_Armies")
        Additional_Percent = CreateHorz("Additional percentage of armies to lose to attrition", 0, 20, "Additional_Percent")

    QuickVert()
    UI.CreateLabel(Vert).SetText(" \n City bonus - for example set percentage to 100 to cause no attrition on any cities")
        City_Armies = CreateHorz("Each city on a territory recovers how many armies from attrition", 0, 10, "City_Armies")
        City_Percent = CreateHorz("In addition, each city on a territory recovers what percentage of armies from attrition", 0, 20, "City_Percent") 

end
