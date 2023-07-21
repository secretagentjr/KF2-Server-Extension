Class Ext_TraitGrenadeCap extends Ext_TraitCarryCap;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data);
static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data);

static function TraitActivate(Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.PerkManager.SetGrenadeCap(Default.CarryAdds[Level-1]);
}

static function TraitDeActivate(Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.PerkManager.SetGrenadeCap(0);
}

defaultproperties
{
	DefLevelCosts(0)=40
	DefLevelCosts(1)=55
	DefLevelCosts(2)=70
	DefLevelCosts(3)=90
	DefLevelCosts(4)=150
	CarryAdds(0)=1
	CarryAdds(1)=2
	CarryAdds(2)=3
	CarryAdds(3)=5
	CarryAdds(4)=8
}