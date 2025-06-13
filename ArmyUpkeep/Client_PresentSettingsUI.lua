
function Client_PresentSettingsUI(rootParent)
    UI.CreateLabel(rootParent).SetText("Army cost per turn: "..Mod.Settings.armyCost)
    local destroy = Mod.Settings.destroyArmies
    if destroy then destroy = "true" else destroy = "false"
    UI.CreateLabel(rootParent).SetText("Armies destroyed if not enough gold? "..destroy)

end
