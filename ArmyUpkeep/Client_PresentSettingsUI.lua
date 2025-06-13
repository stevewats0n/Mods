
function Client_PresentSettingsUI(rootParent)
    UI.CreateLabel(rootParent).SetText("Army cost per turn: "..Mod.Settings.armyCost)
    UI.CreateLabel(rootParent).SetText("Armies destroyed if not enough gold? "..Mod.Settings.destroyArmies)

end
