
function Client_PresentSettingsUI(rootParent)
    UI.CreateLabel(rootParent).setText("Army cost per turn: "..Mod.Settings.armyCost)
    --UI.CreateLabel(rootParent).setText("Armies destroyed if not enough gold? "..Mod.Settings.destroyArmies)

end
