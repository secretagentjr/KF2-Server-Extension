Class UI_PrestigeNote extends UI_ResetWarning;

var localized string WindowTitleText;
var localized string PrestigeButtonToolTip;
var localized string InfoLabelTextPart1;
var localized string InfoLabelTextPart2;

function InitMenu()
{
	Super.InitMenu();
	YesButton.ToolTip=PrestigeButtonToolTip;
}

function SetupTo(Ext_PerkBase P)
{
	PerkToReset = P.Class;
	WindowTitle = WindowTitleText$" "$P.PerkName;
	InfoLabel.SetText(InfoLabelTextPart1$P.PrestigeSPIncrease$InfoLabelTextPart2);
}

defaultproperties
{
	bIsPrestige=true

	Begin Object Name=YesButten
	End Object
}