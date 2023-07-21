Class Ext_T_HealthRegHelp extends Info
	transient;

var ExtHumanPawn PawnOwner;
var byte RegCount;

function PostBeginPlay()
{
	PawnOwner = ExtHumanPawn(Owner);
	if (PawnOwner==None)
		Destroy();
	else SetTimer(9+FRand(),true);
}

function Timer()
{
	if (PawnOwner==None || PawnOwner.Health<=0)
		Destroy();
	else if (PawnOwner.Health<PawnOwner.HealthMax)
	{
		PawnOwner.Health = Min(PawnOwner.Health+RegCount,PawnOwner.HealthMax);
	}
}

defaultproperties
{

}