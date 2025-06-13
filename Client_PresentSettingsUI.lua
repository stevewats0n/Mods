
function Client_PresentSettingsUI(rootParent)
 -- user sees this in settings for mod
    UI.CreateLabel(rootParent).setText("Army cost per turn: "..Mod.Settings.armyCost)

end