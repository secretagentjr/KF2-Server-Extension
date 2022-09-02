class ExtDT_Ballistic_Pistol_Medic extends KFDT_Ballistic_Pistol_Medic
	abstract
	hidedropdown;

defaultproperties
{
	ModifierPerkList(0) = class'KFPerk_Sharpshooter'
	ModifierPerkList(1) = class'KFPerk_Gunslinger'
}