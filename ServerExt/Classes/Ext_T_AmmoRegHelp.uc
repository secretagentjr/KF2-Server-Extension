Class Ext_T_AmmoRegHelp extends Info
	transient;

var Pawn PawnOwner;
var float RegCount;

function PostBeginPlay()
{
	PawnOwner = Pawn(Owner);
	if( PawnOwner==None )
		Destroy();
	else SetTimer(29+FRand(),true);
}
function Timer()
{
	local KFWeapon W;
	local byte i;
	local int ExtraAmmo;

	if( PawnOwner==None || PawnOwner.Health<=0 || PawnOwner.InvManager==None )
		Destroy();
	else
	{
		foreach PawnOwner.InvManager.InventoryActors(class'KFWeapon',W)
		{
			for( i=0; i<2; ++i )
			{
				if( W.SpareAmmoCount[i] < W.SpareAmmoCapacity[i] )
				{
					ExtraAmmo = Min(FMax(float(W.SpareAmmoCapacity[i])*RegCount,1.f),W.SpareAmmoCapacity[i]);
					if ( i==0 )
					{
						W.AddAmmo(ExtraAmmo);
					}
					else
					{
						W.AddSecondaryAmmo(ExtraAmmo);
					}
					W.bNetDirty = true;
				}
			}
		}
	}
}

defaultproperties
{
}
