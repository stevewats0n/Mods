

require("Functions")

function Server_AdvanceTurn_Order (Game, Order, Result, skipThisOrder, addNewOrder)
    if (Order.proxyType == "GameOrderCustom" and string.sub(Order.Payload, 1, 6) == "armyRM") then
        print (Order.Payload);
        local ind = string.find(Order.Payload, ",")
        local t_id = string.sub(Order.Payload, 7, ind-1)
        -- the actual count of armies
        local army_count = Game.ServerGame.LatestTurnStanding.Territories[t_id].NumArmies.NumArmies
        -- how much user requested to remove
        local army_rm = string.sub(Order.Payload, ind+1)
        -- but if the army count has reduced, we cannot have player ending with negative armies
        --if army_rm > army_count then army_rm = army_count; end;
        -- this is if they try to give themselves extra armies;
--        if army_rm < 0 then army_rm = 0; end;
--    addNewOrder(WL.GameOrderEvent.Create(Order.PlayerID, "Debug ind: "..ind.." t_id: "..t_id.." army count: "..army_count.." and army to remove: "..army_rm, {}, nil) )

        local terr_mod = WL.TerritoryModification.Create(t_id)
        terr_mod.AddArmies = -army_rm
        local terr_mod_annotation = WL.TerritoryAnnotation.Create("Remove "..army_rm, 8)
        local order = WL.GameOrderEvent.Create(Order.PlayerID, "Removed armies from "..Game.Map.Territories[t_id].Name,
            {}, {terr_mod})
        order.TerritoryAnnotationsOpt = {[t_id] = terr_mod_annotation}
        addNewOrder(order);
        skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);


    end
end


function Server_AdvanceTurn_End(Game, addNewOrder)


    -- to fund army upkeep, first of all take from income. second, take form gold reserves. third, take from armies on field

    local army_cost = Mod.Settings.armyCost
    local army_debt = {}
    print("Army cost = " .. army_cost)



    for player_id, player_info in pairs(Game.Game.PlayingPlayers) do
        -- reset global variables
        Gold_mod = nil
        Income_mod = nil
        -- number of armies which each player has
        local all_terrs = {}
        for t_id, standing in pairs(Game.ServerGame.LatestTurnStanding.Territories) do
            if standing.OwnerPlayerID == player_id then
                all_terrs[t_id] = standing.NumArmies.NumArmies
            end
        end
        if Mod.PublicGameData.Attrition ~= nil then
            for t_id, armies_lost in pairs(Mod.PublicGameData.Attrition) do
                all_terrs[t_id] = all_terrs[t_id] - math.floor(armies_lost)
            end
        end
        -- how much gold is required to maintain this many armies
        local gold_required = Sum(all_terrs) * Mod.Settings.armyCost
        print(gold_required)
        if gold_required == nil then gold_required = 0 end
        -- this is just overwriting gold_required for turns after 1 to include debt carried over from previous turns
        
        if Game.Game.TurnNumber > 1 then gold_required = gold_required + Mod.PublicGameData.Army_Debt[player_id] end
        print(gold_required)
        local gold_required_initially = math.floor(gold_required)

        -- while loop so that we can break out of it
        while gold_required > 0 do
        -- first try to reduce income
            local income = player_info.Income(0,Game.ServerGame.LatestTurnStanding,false,false).Total

            Income_mod = WL.IncomeMod.Create(player_id, - math.floor(math.min(income, gold_required)), "Army cost")
            gold_required = gold_required - math.floor(math.min(income, gold_required))
            if gold_required < 1 then print(gold_required) break end
        -- then remove gold reserves
            local gold_has = Game.ServerGame.LatestTurnStanding.Resources[player_id][WL.ResourceType.Gold]
            Gold_mod = {}
                Gold_mod[player_id] = {}
                    Gold_mod[player_id][WL.ResourceType.Gold] = -math.floor(math.min(gold_has, gold_required))
            
            gold_required = gold_required - math.floor( math.min(gold_has, gold_required) )
            if gold_required < 1 then break end
        -- finally remove armies
            if Mod.Settings.destroyArmies == true then
                local final_army_number = {}
                local t_ids_list = {}
                for t_id, armies in pairs(all_terrs) do
                    final_army_number[t_id] = armies
                    table.insert(t_ids_list, t_id)
                end

                local i = 1
                Debt = gold_required
                while Debt >= 1 do
                    if final_army_number[t_ids_list[i]] > 0 then
                        final_army_number[t_ids_list[i]] = final_army_number[t_ids_list[i]] - 1
                        Debt = Debt - Mod.Settings.armyCost
                    end

                    i = i + 1
                    if i > Table_length(final_army_number) then i = 1 end
                end

            Terrmod = {}
                for t_id, armies in pairs(all_terrs) do
                    local x = armies - final_army_number[t_id]

                    if x > 0 then
                        local mod = WL.TerritoryModification.Create(t_id)
                        mod.AddArmies = -x
                        table.insert(Terrmod, mod)
                        addNewOrder(WL.GameOrderEvent.Create(player_id,x.." armies at "..Game.Map.Territories[t_id].Name.." desert from the army",
                            {},{mod} ))
                    end
                end
            end
            break
        
        end -- end of the while loop


    if Terrmod == nil then Terrmod = {} end

    local order = WL.GameOrderEvent.Create(player_id, "Payment for armies: "..gold_required_initially, nil, nil, nil, nil)
    if Income_mod ~= nil then order.IncomeMods = {Income_mod} end;
    if Gold_mod ~= nil then order.AddResourceOpt = Gold_mod end

    Debt = Debt or gold_required
    army_debt[player_id] = Debt -- any gold (normally between 0 and 1) not paid this turn due to decimal amounts

    addNewOrder(order)
    end -- end of the player loop

    local publicgamedata = Mod.PublicGameData;
    if Game.Game.TurnNumber > 0 then
        publicgamedata.Army_Debt = army_debt
    else
        army_debt = {}
        for player_id, player_info in pairs(Game.Game.PlayingPlayers) do
            army_debt[player_id] = 0
        end
        publicgamedata.Army_Debt = army_debt
    end

    if Mod.Settings.setZeroArmiesNeutral then
        for t_id, standing in pairs(Game.ServerGame.LatestTurnStanding.Territories) do
            if standing.IsNeutral == false then
                if standing.NumArmies.IsEmpty then
                    local terrMod = WL.TerritoryModification.Create(t_id)
                    terrMod.SetOwnerOpt = WL.PlayerID.Neutral
                    addNewOrder(WL.GameOrderEvent.Create(standing.OwnerPlayerID, Game.Map.Territories[t_id].Name.." has no armies - turning to neutral", 
                            {}, {terrMod}, nil, nil) )
                end
            end
        end
    end

    Mod.PublicGameData = publicgamedata

end
