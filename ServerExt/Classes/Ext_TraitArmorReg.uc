Class Ext_TraitArmorReg extends Ext_TraitBase;

var array<byte> RegenValues;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_ArmorRegHelp H;

	H = Player.Spawn(class'Ext_T_ArmorRegHelp',Player);
	if (H!=None)
		H.RegCount = Default.RegenValues[Level-1];
}

static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_ArmorRegHelp H;

	foreach Player.ChildActors(class'Ext_T_ArmorRegHelp',H)
		H.Destroy();
}

defaultproperties
{
	TraitGroup=class'Ext_TGroupRegen'
	NumLevels=3
	DefLevelCosts(0)=10
	DefLevelCosts(1)=20
	DefLevelCosts(2)=40
	RegenValues.Add(7)
	RegenValues.Add(12)
	RegenValues.Add(25)
}