
function Client_SaveConfigureUI (alert, addCard)

    function Validate(value, min, max)
        if value < min or value > max then
            alert(value .. " must be between " .. min .. " and " .. max)
        end
    end

    Mod.Settings.Base_Armies = Base_Armies.GetValue()
    Validate(Mod.Settings.Base_Armies, -10000, 10000)

    Mod.Settings.Base_Percent = Base_Percent.GetValue()
    Validate(Mod.Settings.Base_Percent, -100, 100)

    Mod.Settings.Additional_StartsAt = Additional_StartsAt.GetValue()
    Validate(Mod.Settings.Additional_StartsAt, 0, 1000)

    Mod.Settings.Additional_Armies = Additional_Armies.GetValue()
    Validate(Mod.Settings.Additional_Armies, -10000, 10000)

    Mod.Settings.Additional_Percent = Additional_Percent.GetValue()
    Validate(Mod.Settings.Additional_Percent, -100, 100)

    Mod.Settings.City_Armies = City_Armies.GetValue()
    Validate(Mod.Settings.City_Armies, -10000, 10000)

    Mod.Settings.City_Percent = City_Percent.GetValue()
    Validate(Mod.Settings.City_Percent, -100, 100)

    Mod.Settings.Version = 1


  --  Validate(Base_Armies.GetValue(), "Base_Armies", -10000, 10000)
  --  Validate(Base_Percent.GetValue(), "Base_Percent", -10000, 10000)
  --  Validate(Additional_StartsAt.GetValue(), "Additional_StartsAt", 0, 10000)
  --  Validate(Additional_Armies.GetValue(), "Additional_Armies", -10000, 10000)
  --  Validate(Additional_Percent.GetValue(), "Additional_Percent", -10000, 10000)
  --  Validate(City_Armies.GetValue(), "City_Armies", -10000, 10000)
  --  Validate(City_Percent.GetValue(), "City_Percent", -10000, 10000)



end