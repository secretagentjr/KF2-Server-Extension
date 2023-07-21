Class Ext_TraitUnCloak extends Ext_TraitBase;

var array<float> RadiusValues;

static function ApplyEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_UnCloakHelper H;

	H = Player.Spawn(class'Ext_T_UnCloakHelper',Player);
	if (H!=None)
		H.HandleRadius = Default.RadiusValues[Level-1];
}

static function CancelEffectOn(ExtHumanPawn Player, Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data)
{
	local Ext_T_UnCloakHelper H;

	foreach Player.ChildActors(class'Ext_T_UnCloakHelper',H)
		H.Destroy();
}

defaultproperties
{
	NumLevels=5
	DefLevelCosts(0)=5
	DefLevelCosts(1)=7
	DefLevelCosts(2)=10
	DefLevelCosts(3)=15
	DefLevelCosts(4)=25
	RadiusValues.Add(300)
	RadiusValues.Add(500)
	RadiusValues.Add(700)
	RadiusValues.Add(1000)
	RadiusValues.Add(1500)
}