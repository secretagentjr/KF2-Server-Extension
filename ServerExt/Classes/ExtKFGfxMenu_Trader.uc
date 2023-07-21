class ExtKFGfxMenu_Trader extends KFGFxMenu_Trader;

//==============================================================
// Trader Functions
//==============================================================
function OneSecondLoop()
{
	local ExtHumanPawn KFP;

	if( GameInfoContainer != none )
	{
	 	GameInfoContainer.UpdateTraderTimer();
	}

	// update armor amount if pawn gains armor while in trader (e.g. from medic heal skills)
	KFP = ExtHumanPawn( MyKFPC.Pawn );
	if( KFP != none && PrevArmor != KFP.NewArmor )
	{
		MyKFPC.GetPurchaseHelper().ArmorItem.SpareAmmoCount = KFP.NewArmor;
		PrevArmor = KFP.NewArmor;

		RefreshItemComponents();
	}
}