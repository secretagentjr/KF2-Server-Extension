class ExtSM_Siren_Scream extends KFSM_Siren_Scream;

function SpawnProjectileShield()
{
	return;
}

defaultproperties
{
	ExplosionActorClass=class'ExtExplosion_SirenScream'
	
	// explosion
	Begin Object Name=ExploTemplate0
		ActorClassToIgnoreForDamage=class'KFPawn_ZedSirenX'
	End Object
}