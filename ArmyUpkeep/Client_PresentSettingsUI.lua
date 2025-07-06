
function Client_PresentSettingsUI(rootParent)
    UI.CreateLabel(rootParent).SetText("Army cost per turn: "..Mod.Settings.armyCost)
    local destroy = Mod.Settings.destroyArmies
    if destroy then destroy = "true" else destroy = "false" end
    UI.CreateLabel(rootParent).SetText("Armies destroyed if not enough gold? "..destroy)
    local setZeroArmiesNeutral = Mod.Settings.setZeroArmiesNeutral
    if setZeroArmiesNeutral then setZeroArmiesNeutral = "true" else setZeroArmiesNeutral = "false" end
    UI.CreateLabel(rootParent).SetText("Territory set to neutral if there are 0 armies (or special units) on it at the end of the turn? "..setZeroArmiesNeutral)

end
