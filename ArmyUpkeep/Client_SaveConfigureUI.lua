
function Client_SaveConfigureUI (alert)
  Mod.Settings.armyCost = armyCostInput.GetValue()
  Mod.Settings.destroyArmies = destroyArmiesInput.GetIsChecked()
  Mod.Settings.setZeroArmiesNeutral = setZeroArmiesNeutral.GetIsChecked()
  Mod.Settings.Version = 1
end
