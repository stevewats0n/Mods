
function Client_PresentSettingsUI(rootParent)
    for k,v in pairs(Mod.Settings) do print (k) end
    print(Mod.Settings.armyCost)
    UI.CreateLabel(rootParent).setText("Army cost per turn: "..Mod.Settings.armyCost)
    --UI.CreateLabel(rootParent).setText("Armies destroyed if not enough gold? "..Mod.Settings.destroyArmies)

end
