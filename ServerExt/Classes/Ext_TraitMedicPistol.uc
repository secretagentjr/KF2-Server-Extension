Class Ext_TraitMedicPistol extends Ext_TraitBase;

static function AddDefaultInventory( KFPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data )
{
	Player.DefaultInventory.RemoveItem(class'ExtWeap_Pistol_9mm');
	Player.DefaultInventory.AddItem(class'ExtWeap_Pistol_MedicS');
}

static function ApplyEffectOn( KFPawn_Human Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data )
{
	local Inventory Inv;

	Inv = Player.FindInventoryType(class'ExtWeap_Pistol_9mm');
	if( Inv!=None )
		Inv.Destroy();
			
	if( Player.FindInventoryType(class'ExtWeap_Pistol_MedicS')==None )
	{
		Inv = Player.CreateInventory(class'ExtWeap_Pistol_MedicS',Player.Weapon!=None);
		if ( KFWeapon(Inv)!=None )
         	KFWeapon(Inv).bGivenAtStart = true;
	}
}

defaultproperties
{
	TraitName="Medic Pistol"
	DefLevelCosts(0)=20
	Description="Spawn with a medic pistol instead of standard 9mm."
}