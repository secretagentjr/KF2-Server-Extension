class ExtWeap_Pistol_MedicS extends KFWeap_Pistol_Medic;

defaultproperties
{
	bCanThrow=false

	SpareAmmoCapacity[0]=-1
	InitialSpareMags[0]=0
	bInfiniteSpareAmmo=True

	// Remove weight bcs of replacing 9mm
	InventorySize=0

	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'ExtDT_Ballistic_Pistol_Medic'

	WeaponUpgrades[1]=(Stats=((Stat=EWUS_Damage0, Scale=1.7f), (Stat=EWUS_HealFullRecharge, Scale=0.9f)))
	WeaponUpgrades[2]=(Stats=((Stat=EWUS_Damage0, Scale=2.0f), (Stat=EWUS_HealFullRecharge, Scale=0.8f)))
	WeaponUpgrades[3]=(Stats=((Stat=EWUS_Damage0, Scale=2.55f), (Stat=EWUS_HealFullRecharge, Scale=0.7f)))
	WeaponUpgrades[4]=(Stats=((Stat=EWUS_Damage0, Scale=3.0f), (Stat=EWUS_HealFullRecharge, Scale=0.6f)))
}

simulated static function bool AllowedForAllPerks()
{
	return true;
}

simulated function ConsumeAmmo(byte FireModeNum)
{
	if (FireModeNum == ALTFIRE_FIREMODE)
		super.ConsumeAmmo(FireModeNum);
}

simulated static event class<KFPerk> GetWeaponPerkClass(class<KFPerk> InstigatorPerkClass)
{
	if (InstigatorPerkClass != None)
		return InstigatorPerkClass;

	return default.AssociatedPerkClasses[0];
}

simulated function KFPerk GetPerk()
{
	if (KFPlayer != None)
		return KFPlayer.GetPerk();
	return super.GetPerk();
}
