Class Ext_TraitAmmoReg extends Ext_TraitBase;

var array<float> RegenValues;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_AmmoRegHelp H;

	H = Player.Spawn(class'Ext_T_AmmoRegHelp',Player);
	if (H!=None)
		H.RegCount = Default.RegenValues[Level-1];
}

static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_AmmoRegHelp H;

	foreach Player.ChildActors(class'Ext_T_AmmoRegHelp',H)
		H.Destroy();
}

defaultproperties
{
	TraitGroup=class'Ext_TGroupRegen'
	NumLevels=5
	DefLevelCosts(0)=10
	DefLevelCosts(1)=20
	DefLevelCosts(2)=40
	DefLevelCosts(3)=60
	DefLevelCosts(4)=80
	RegenValues.Add(0.05)
	RegenValues.Add(0.1)
	RegenValues.Add(0.2)
	RegenValues.Add(0.35)
	RegenValues.Add(0.4)
}