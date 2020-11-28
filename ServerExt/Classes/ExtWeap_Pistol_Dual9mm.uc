class ExtWeap_Pistol_Dual9mm extends KFWeap_Pistol_Dual9mm;

defaultproperties
{
	SpareAmmoCapacity[0]=-1
	InitialSpareMags[0]=0
	
	bInfiniteSpareAmmo=True

	SingleClass=class'ExtWeap_Pistol_9mm'

	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'ExtDT_Ballistic_9mm' // KFDT_Ballistic_9mm
}

simulated static function bool AllowedForAllPerks()
{
	return true;
}

simulated function ConsumeAmmo(byte FireModeNum)
{
	
}

simulated static event class<KFPerk> GetWeaponPerkClass(class<KFPerk> InstigatorPerkClass)
{
	if (InstigatorPerkClass != None)
		return InstigatorPerkClass;

	return default.AssociatedPerkClasses[0];
}