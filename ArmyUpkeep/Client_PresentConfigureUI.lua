

function Client_PresentConfigureUI(rootParent)

    local initial_armyCost = Mod.Settings.armyCost;
    if initial_armyCost == nil then
        initial_armyCost = 1;
    end

    local initial_destroyArmies = Mod.Settings.destroyArmies;
    if initial_destroyArmies == nil then initial_destroyArmies = true end

    local select = UI.CreateVerticalLayoutGroup(rootParent);
    UI.CreateLabel(select).SetText('Army cost per turn')
    armyCostInput = UI.CreateNumberInputField(select)
        .SetSliderMinValue(1)
        .SetSliderMaxValue(4)
        .SetValue(initial_armyCost)
        .SetWholeNumbers(false)

    select = UI.CreateVerticalLayoutGroup(rootParent);
    destroyArmiesInput = UI.CreateCheckBox(select).SetText("Destroy armies if not enough gold?")
        .SetIsChecked(true)

    select = UI.CreateVerticalLayoutGroup(rootParent);
    setZeroArmiesNeutral = UI.CreateCheckBox(select).SetText("Set territories with 0 armies (and no special units) at end of the turn to neutral?")
        .SetIsChecked(false)



end
