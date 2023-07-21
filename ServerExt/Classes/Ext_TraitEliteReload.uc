Class Ext_TraitEliteReload extends Ext_TraitBase;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.bTacticalReload = true;
}

static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.bTacticalReload = false;
}

defaultproperties
{
	DefLevelCosts(0)=50
	DefMinLevel=50
}