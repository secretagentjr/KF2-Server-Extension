class ExtWeap_Pistol_MedicS extends KFWeap_Pistol_Medic;

defaultproperties
{
	bCanThrow=false
	
	SpareAmmoCapacity[0]=-1
	InitialSpareMags[0]=0
	
	bInfiniteSpareAmmo=True

	InstantHitDamageTypes(DEFAULT_FIREMODE)=class'ExtDT_Ballistic_Pistol_Medic'
}

simulated static function bool AllowedForAllPerks()
{
    return true;
}

simulated function ConsumeAmmo( byte FireModeNum )
{
	if(FireModeNum == ALTFIRE_FIREMODE)
		super.ConsumeAmmo(FireModeNum);
}

simulated static event class<KFPerk> GetWeaponPerkClass( class<KFPerk> InstigatorPerkClass )
{
	if(InstigatorPerkClass != None)
		return InstigatorPerkClass;

	return default.AssociatedPerkClasses[0];
}