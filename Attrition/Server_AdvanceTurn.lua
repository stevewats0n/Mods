-- player id 587980

function Server_AdvanceTurn_End (Game, addNewOrder)

    require("Functions")

    function Printa (num, standing, t_id, arm, iyi)
        local iyi = iyi or false
        if iyi then print(standing.OwnerPlayerID .. " controls "..Game.Map.Territories[t_id].Name) end
        print("Print"..num..": "..arm)
    end


    for t_id, standing in pairs(Game.ServerGame.LatestTurnStanding.Territories) do
        if standing.OwnerPlayerID ~= WL.PlayerID.Neutral then

            -- apply all attrition to the territory here
            local armies_num = standing.NumArmies.NumArmies
            local armies_to_remove = 0

            -- base calculation
            local base = 0
            local additional = 0
            if Mod.Settings.Additional_StartsAt == 0 then
                base = armies_num 
                base = base * Mod.Settings.Base_Percent / 100 + Mod.Settings.Base_Armies
            else
                base = Unnegative(math.min(armies_num, Mod.Settings.Additional_StartsAt))
                base = base * Mod.Settings.Base_Percent / 100 + Mod.Settings.Base_Armies

            -- additional calculation
                additional = Unnegative(armies_num - Mod.Settings.Additional_StartsAt)
                if additional > 0 then
                    additional = additional * (Mod.Settings.Base_Percent + Mod.Settings.Additional_Percent) / 100 + 
                                            (Mod.Settings.Base_Armies + Mod.Settings.Additional_Armies)
                else additional = 0 end
            end

            armies_to_remove = armies_to_remove + base + additional

if standing.OwnerPlayerID == 587980 then Printa(2, standing, t_id, armies_to_remove, true) end
            -- may be less attrition on cities
            local armies_to_recover = 0
            if standing.Structures ~= nil then
                local cities_num = standing.Structures[WL.StructureType.City]
                if cities_num ~= nil then
                    -- this works by working out how many armies to recover/refund and then subtracting that from the overall armies_to_remove
                    armies_to_recover = (Mod.Settings.City_Armies * cities_num) + (Mod.Settings.City_Percent / 100 * cities_num * armies_num)
                    -- with a third of an army, do not destroy it
                end
            end
if standing.OwnerPlayerID == 587980 then Printa(4, standing, t_id, armies_to_remove) end
            armies_to_remove = armies_to_remove - armies_to_recover
            armies_to_remove = Unnegative(armies_to_remove)
if standing.OwnerPlayerID == 587980 then Printa(5, standing, t_id, armies_to_remove) end

if standing.OwnerPlayerID == 587980 then Printa(3, standing, t_id, armies_to_remove) end
            if armies_to_remove ~= 0 and armies_num ~= 0 then
                local terrMod = WL.TerritoryModification.Create(t_id)
                terrMod.AddArmies = -math.floor(armies_to_remove)
                addNewOrder ( WL.GameOrderEvent.Create(standing.OwnerPlayerID,
                    armies_to_remove .. " armies lost to attrition at " .. Game.Map.Territories[t_id].Name,
                    {}, {terrMod} ) )
            end
        end
    end
end

