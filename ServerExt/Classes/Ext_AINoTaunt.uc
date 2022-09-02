class Ext_AINoTaunt extends KFSM_PlaySingleAnim;

function SpecialMoveStarted(bool bForced, Name PrevMove)
{
	KFPOwner.EndSpecialMove();
}

function SpecialMoveEnded(Name PrevMove, Name NextMove)
{
}

defaultproperties
{
	Handle=KFSM_Taunt
	bDisableMovement=true
	bDisablesWeaponFiring=true
}