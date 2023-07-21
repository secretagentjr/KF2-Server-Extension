Class Ext_TraitBunnyHop extends Ext_TraitBase;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	if (Player!=None)
		Player.bHasBunnyHop = true;
}

static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	if (Player!=None)
		Player.bHasBunnyHop = false;
}

defaultproperties
{
	DefLevelCosts(0)=50
	DefMinLevel=100
}