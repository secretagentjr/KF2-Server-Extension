Class Ext_TraitAutoFire extends Ext_TraitBase;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_AutoFireHelper H;

	H = Player.Spawn(class'Ext_T_AutoFireHelper',Player);
	H.AssociatedPerkClass = Perk.BasePerk;
}

static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_AutoFireHelper H;

	foreach Player.ChildActors(class'Ext_T_AutoFireHelper',H)
		H.Destroy();
}

defaultproperties
{
	DefLevelCosts(0)=50
}