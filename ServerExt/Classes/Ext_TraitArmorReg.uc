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
	NumLevels=5
	DefLevelCosts(0)=10
	DefLevelCosts(1)=20
	DefLevelCosts(2)=30
	DefLevelCosts(3)=40
	DefLevelCosts(4)=40
	RegenValues.Add(5)
	RegenValues.Add(10)
	RegenValues.Add(15)
	RegenValues.Add(20)
	RegenValues.Add(25)
}