

 function Client_PresentMenuUI (rootParent, setMaxSize, setScrollable, game, close)
    setMaxSize(450, 280);
    Game = game
    Close = close
    RootParent = rootParent;

    if (Game.LatestStanding == nil) then
		UI.CreateLabel(vert).SetText("Cannot use until game has begun");
		return;
	end
    if (Game.Us == nil) then
		UI.CreateLabel(vert).SetText("You cannot destroy armies since you're not in the game");
		return;
	end

    if Mod.Settings.allowRemoveArmies then
	MainUI()
	end

end

function MainUI ()
	local box = UI.CreateVerticalLayoutGroup(RootParent);
	Select_box = UI.CreateButton(box).SetText("Remove Armies").SetColor("#6C73D1").SetOnClick(Choose_territory)
	Select_instructions = UI.CreateLabel(box).SetText("")
	UI.CreateLabel(box).SetText("Number of armies to remove")
	Armies_slider = UI.CreateNumberInputField(box).SetSliderMinValue(0).SetSliderMaxValue(0).SetInteractable(false)
	Confirm_box = UI.CreateButton(box).SetText("Confirm").SetInteractable(false)
end

function Choose_territory ()
        UI.InterceptNextTerritoryClick(Get_selected)
        Select_instructions.SetText("Choose territory to remove armies from. Move this dialog box out the way if necessary.")
        Select_box.SetInteractable(false)
    end

function Get_selected (terr_details)
    if UI.IsDestroyed(Select_box) then return WL.CancelClickIntercept; end;
    if terr_details == nil then UI.Destroy(box); MainUI() ; end ;
    Select_box.SetInteractable(true);
    local standing_info = Game.LatestStanding.Territories[terr_details.ID]

    Terr_details = terr_details
    if standing_info.OwnerPlayerID ~= Game.Us.ID then UI.Alert("Not your territory.") return;
    elseif standing_info.NumArmies.NumArmies == 0 then UI.Alert("Not any armies here."); return;
    else Armies_slider.SetInteractable(true).SetSliderMaxValue(standing_info.NumArmies.NumArmies)
        Confirm_box.SetInteractable(true).SetOnClick(To_server)
    end
end

function To_server()
    local armies_removed = Armies_slider.GetValue()
    local order = WL.GameOrderCustom.Create(
        Game.Us.ID, "Remove "..armies_removed.." armies from "..Game.Map.Territories[Terr_details.ID].Name  .."armyRM"..Terr_details.ID..","..armies_removed,
        "armyRM"..Terr_details.ID..","..armies_removed)

    local orders = Game.Orders;
	table.insert(orders, order);
	Game.Orders = orders;

    Choose_territory ()
end
