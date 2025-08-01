

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
		Current_debt = UI.CreateLabel(box).SetText("Amount of debt: "..Mod.PublicGameData.Army_Debt[Game.Us.ID])
	Select_box = UI.CreateButton(box).SetText("Remove Armies").SetColor("#6C73D1").SetOnClick(Choose_territory)
	Select_instructions = UI.CreateLabel(box).SetText("")
	UI.CreateLabel(box).SetText("Number of armies to remove")
	Armies_slider = UI.CreateNumberInputField(box).SetSliderMinValue(0).SetSliderMaxValue(0).SetInteractable(false)
	Territory_chosen_label = UI.CreateLabel(box).SetText("")
	Confirm_box = UI.CreateButton(box).SetText("Confirm").SetInteractable(false)
	Confirmation_text = UI.CreateLabel(box).SetText("").SetColor("#009933")
end

function Choose_territory ()
        UI.InterceptNextTerritoryClick(Get_selected)
        Select_instructions.SetText("Choose territory to remove armies from. Move this dialog box out the way if necessary.")
        Select_box.SetInteractable(false)
    end

function Get_selected (terr_details)
    if UI.IsDestroyed(Select_box) then return WL.CancelClickIntercept; end;
    Select_box.SetInteractable(true);
    Territory_chosen_label.SetText("Territory chosen: "..Game.Map.Territories[terr_details.ID].Name)

    Terr_details = terr_details
    if (Game.LatestStanding.Territories[terr_details.ID].OwnerPlayerID ~= Game.Us.ID) then 
		UI.Alert("Not your territory.") return;
    elseif Game.LatestStanding.Territories[terr_details.ID].NumArmies.NumArmies == 0 then UI.Alert("Not any armies here."); return;
    else Armies_slider.SetInteractable(true).SetSliderMaxValue(Game.LatestStanding.Territories[terr_details.ID].NumArmies.NumArmies)
        Confirm_box.SetInteractable(true).SetOnClick(Validate_armies_input)
    end
end


function Validate_armies_input ()
	if Armies_slider.GetValue() < 0 then UI.Alert("Armies to remove must be positive.")
	else To_server() end
end

function To_server()
    local armies_removed = Armies_slider.GetValue()
    local order = WL.GameOrderCustom.Create(
        Game.Us.ID, "Remove "..armies_removed.." armies from "..Game.Map.Territories[Terr_details.ID].Name ,
        "armyRM"..Terr_details.ID..","..armies_removed)

    local orders = Game.Orders;
	table.insert(orders, order);
	Game.Orders = orders;

    Select_instructions.SetText("") ; Territory_chosen_label.SetText("") ; Armies_slider.SetValue(0) ;
	Confirmation_text.SetText("Will remove "..armies_removed.." armies on "..Game.Map.Territories[Terr_details.ID].Name)

end
