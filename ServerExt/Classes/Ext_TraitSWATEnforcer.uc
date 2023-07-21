Class Ext_TraitSWATEnforcer extends Ext_TraitBase;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	if (Player!=None)
		Player.bMovesFastInZedTime = true;
}

static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	if (Player!=None)
		Player.bMovesFastInZedTime = false;
}

static function TraitActivate(Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.bHasSWATEnforcer = true;
}

static function TraitDeActivate(Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.bHasSWATEnforcer = false;
}

defaultproperties
{
	TraitGroup=class'Ext_TGroupZEDTime'
	DefLevelCosts(0)=50
}