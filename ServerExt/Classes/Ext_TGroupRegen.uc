class Ext_TGroupRegen extends Ext_TGroupBase;

var localized string GroupDescription;

function string GetUIInfo(Ext_PerkBase Perk)
{
	return Default.GroupInfo@"("$MaxText@GetMaxLimit(Perk)$")";
}

function string GetUIDesc()
{
	return Super.GetUIDesc()$"|"$GroupDescription;
}

static function bool GroupLimited(Ext_PerkBase Perk, class<Ext_TraitBase> Trait)
{
	local int i;
	local byte n;

	n = GetMaxLimit(Perk);
	for (i=0; i<Perk.PerkTraits.Length; ++i)
		if (Perk.PerkTraits[i].CurrentLevel>0 && Perk.PerkTraits[i].TraitType!=Trait && Perk.PerkTraits[i].TraitType.Default.TraitGroup==Default.Class && --n==0)
			return true;
	return false;
}

static final function byte GetMaxLimit(Ext_PerkBase Perk)
{
	if (Perk.CurrentPrestige<1)
		return 1;
	else if (Perk.CurrentPrestige<2)
		return 2;
	else if (Perk.CurrentPrestige<3)
		return 3;
	else
		return 3;
}

defaultproperties
{

}