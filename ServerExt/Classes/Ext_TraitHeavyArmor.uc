Class Ext_TraitHeavyArmor extends Ext_TraitBase;

static function TraitActivate(Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.bHeavyArmor = true;
}

static function TraitDeActivate(Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	Perk.bHeavyArmor = false;
}

static function ApplyEffectOn(KFPawn_Human Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	if (Level <= 1)
		return;

	Level == 2 ? Player.AddArmor(50) : Player.AddArmor(Player.MaxArmor);
}

defaultproperties
{
	NumLevels=3
	DefLevelCosts(0)=50
	DefLevelCosts(1)=20
	DefLevelCosts(2)=60
	DefMinLevel=50
}