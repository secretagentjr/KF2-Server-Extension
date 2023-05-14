Class Ext_TraitMedicPistol extends Ext_TraitBase;

static function AddDefaultInventory(KFPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local int i;
	i = Player.DefaultInventory.Find(class'ExtWeap_Pistol_9mm');
	if (i != -1)
		Player.DefaultInventory[i] = class'ExtWeap_Pistol_MedicS';
}

static function ApplyEffectOn(KFPawn_Human Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Inventory Inv;

	Inv = Player.FindInventoryType(class'ExtWeap_Pistol_9mm');
	if (Inv!=None)
		Inv.Destroy();

	if (Player.FindInventoryType(class'ExtWeap_Pistol_MedicS')==None)
	{
		Inv = Player.CreateInventory(class'ExtWeap_Pistol_MedicS',Player.Weapon!=None);
		if (KFWeapon(Inv)!=None)
			KFWeapon(Inv).bGivenAtStart = true;
	}
}

defaultproperties
{
	DefLevelCosts(0)=20
}