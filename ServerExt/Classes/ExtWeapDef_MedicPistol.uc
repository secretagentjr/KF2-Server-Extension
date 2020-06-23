class ExtWeapDef_MedicPistol extends KFWeapDef_MedicPistol
	abstract;

DefaultProperties
{
	// Unsellable weapon
	BuyPrice=0

	// Free ammo
	AmmoPricePerMag=0

	WeaponClassPath="ServerExt.ExtWeap_Pistol_MedicS"

	// Unsellable upgrades
	UpgradeSellPrice[0] = 0
	UpgradeSellPrice[1] = 0
	UpgradeSellPrice[2] = 0
	UpgradeSellPrice[3] = 0
}