
require("Functions")

function Client_SaveConfigureUI (alert)
  -- to resolve if user enters figure not to 0 or 1 dp
  local armyCost = Round( armyCostInput.GetValue() * 10 )
  armyCost = armyCost / 10
  Mod.Settings.armyCost = armyCost
  Mod.Settings.allowRemoveArmies = allowRemoveArmies.GetIsChecked()
  Mod.Settings.destroyArmies = destroyArmiesInput.GetIsChecked()
  Mod.Settings.setZeroArmiesNeutral = setZeroArmiesNeutral.GetIsChecked()
  Mod.Settings.Version = 1
end
