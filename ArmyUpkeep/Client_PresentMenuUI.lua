

 function Client_PresentMenuUI (rootParent, setMaxSize, setScrollable, Game, close)
    setMaxSize(450, 280);
    ClientGame = Game
    Close = close

    if (ClientGame.LatestStanding == nil) then
		UI.CreateLabel(vert).SetText("Cannot use until game has begun");
		return;
	end
    if (ClientGame.Us == nil) then
		UI.CreateLabel(vert).SetText("You cannot destroy armies since you're not in the game");
		return;
	end

    if Mod.Settings.allowRemoveArmies then
	    local box = UI.CreateVerticalLayoutGroup(rootParent);
	    Select_box = UI.CreateButton(box).SetText("Remove Armies").SetColor("#6C73D1").SetOnClick(Choose_territory)
	    Select_instructions = UI.CreateLabel(box).SetText("")
	    UI.CreateLabel(box).SetText("Number of armies to remove")
	    Armies_slider = UI.CreateNumberInputField(box).SetSliderMinValue(0).SetSliderMaxValue(0).SetInteractable(false)
	    Confirm_box = UI.CreateButton(box).SetText("Confirm").SetInteractable(false)
	end

end

function Choose_territory ()
        UI.InterceptNextTerritoryClick(Get_selected)
        Select_instructions.SetText("Choose territory to remove armies from. Move this dialog box out the way if necessary.")
        Select_box.SetInteractable(false)
    end

function Get_selected (terr_details)
    if UI.IsDestroyed(Select_box) then return WL.CancelClickIntercept; end;
    Select_box.SetInteractable(true);
    local standing_info = ClientGame.LatestStanding.Territories[terr_details.ID]

    Terr_details = terr_details
    if standing_info.OwnerPlayerID ~= ClientGame.Us.ID then UI.Alert("Not your territory.") return;
    elseif standing_info.NumArmies.NumArmies == 0 then UI.Alert("Not any armies here."); return;
    else Armies_slider.SetInteractable(true).SetSliderMaxValue(standing_info.NumArmies.NumArmies)
        Confirm_box.SetInteractable(true).SetOnClick(To_server)
    end
end

function To_server()
    local order = WL.GameOrderCustom.Create(
        ClientGame.Us.ID, "Remove "..Armies_slider.GetValue().." armies from "..ClientGame.Map.Territories[Terr_details.ID].Name,
        "armyRM"..Terr_details.ID..","..Armies_slider.GetValue())

    local orders = ClientGame.Orders;
	table.insert(orders, order);
	ClientGame.Orders = orders;

    Close()
end
