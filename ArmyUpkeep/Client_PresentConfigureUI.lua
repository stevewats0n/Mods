

function Client_PresentConfigureUI(rootParent)

    local initial_armyCost = Mod.Settings.armyCost;
    if initial_armyCost == nil then
        initial_armyCost = 1;
    end

    local initial_destroyArmies = Mod.Settings.destroyArmies;
    if initial_destroyArmies == nil then initial_destroyArmies = true end;

    local initial_allowRemoveArmies = Mod.Settings.allowRemoveArmies;
    if initial_allowRemoveArmies == nil then initial_allowRemoveArmies = true end;

    local initial_setZeroArmiesNeutral = Mod.Settings.setZeroArmiesNeutral;
    if initial_destroyArmies == nil then initial_setZeroArmiesNeutral = false end;

    local select = UI.CreateVerticalLayoutGroup(rootParent);
    UI.CreateLabel(select).SetText('Army cost per turn')
    armyCostInput = UI.CreateNumberInputField(select)
        .SetSliderMinValue(0)
        .SetSliderMaxValue(4)
        .SetValue(initial_armyCost)
        .SetWholeNumbers(false)

    select = UI.CreateVerticalLayoutGroup(rootParent);
    allowRemoveArmies = UI.CreateCheckBox(select).SetText("Allow players to remove armies?")
        .SetIsChecked(initial_allowRemoveArmies)
    
    select = UI.CreateVerticalLayoutGroup(rootParent);
    destroyArmiesInput = UI.CreateCheckBox(select).SetText("Destroy armies if not enough gold?")
        .SetIsChecked(initial_destroyArmies)

    select = UI.CreateVerticalLayoutGroup(rootParent);
    setZeroArmiesNeutral = UI.CreateCheckBox(select).SetText("Set territories with 0 armies (and no special units) at end of the turn to neutral?")
        .SetIsChecked(initial_setZeroArmiesNeutral)



end
