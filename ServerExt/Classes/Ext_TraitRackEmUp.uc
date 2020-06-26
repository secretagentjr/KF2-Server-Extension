Class Ext_TraitRackEmUp extends Ext_TraitBase;

var array<byte> ComboSize;

static function TraitActivate( Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data )
{
	Ext_PerkRhythmPerkBase(Perk).SetMaxRhythm(Default.ComboSize[Level-1]);
}
static function TraitDeActivate( Ext_PerkBase Perk, byte Level, optional Ext_TraitDataStore Data )
{
	Ext_PerkRhythmPerkBase(Perk).ResetRhythm();
}

defaultproperties
{
	SupportedPerk=class'Ext_PerkRhythmPerkBase'
	DefLevelCosts(0)=10
	DefLevelCosts(1)=15
	DefLevelCosts(2)=20
	DefLevelCosts(3)=30
	DefLevelCosts(4)=50
	ComboSize.Add(4)
	ComboSize.Add(8)
	ComboSize.Add(12)
	ComboSize.Add(16)
	ComboSize.Add(28)
	NumLevels=5
}