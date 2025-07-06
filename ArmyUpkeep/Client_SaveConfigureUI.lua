
function Client_SaveConfigureUI (alert)
  if (armyCostInput.GetValue() * 100) % 1 ~= 0 then alert("Army cost should be a whole number or to one decimal place") end
  Mod.Settings.armyCost = armyCostInput.GetValue()
  Mod.Settings.allowRemoveArmies = allowRemoveArmies.GetIsChecked()
  Mod.Settings.destroyArmies = destroyArmiesInput.GetIsChecked()
  Mod.Settings.setZeroArmiesNeutral = setZeroArmiesNeutral.GetIsChecked()
  Mod.Settings.Version = 1
end
