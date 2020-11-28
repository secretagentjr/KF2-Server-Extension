Class UI_MidGameMenu extends KFGUI_FloatingWindow;
	
var KFGUI_SwitchMenuBar PageSwitcher;
var array< class<KFGUI_Base> > Pages;

var KFGUI_Button AdminButton,SpectateButton,SkipTraderButton;

var transient KFGUI_Button PrevButton;
var transient int NumButtons,NumButtonRows;
var transient bool bInitSpectate,bOldSpectate;

var localized string MapVoteButtonText;
var localized string MapVoteButtonToolTip;
var localized string SettingsButtonText;
var localized string SettingsButtonToolTip;
var localized string SkipTraderButtonText;
var localized string SkipTraderButtonToolTip;
var localized string SpectateButtonText;
var localized string SpectateButtonToolTip;
var localized string CloseButtonText;
var localized string CloseButtonToolTip;
var localized string DisconnectButtonText;
var localized string DisconnectButtonToolTip;
var localized string ExitButtonText;
var localized string ExitButtonToolTip;
var localized string JoinButtonText;
var localized string JoinButtonToolTip;

function InitMenu()
{
	local int i;
	local KFGUI_Button B;

	PageSwitcher = KFGUI_SwitchMenuBar(FindComponentID('Pager'));
	Super(KFGUI_Page).InitMenu();
	
	AddMenuButton('Mapvote',MapVoteButtonText,MapVoteButtonToolTip);
	AddMenuButton('Settings',SettingsButtonText,SettingsButtonToolTip);
	SkipTraderButton = AddMenuButton('SkipTrader',SkipTraderButtonText,SkipTraderButtonToolTip);
	SpectateButton = AddMenuButton('Spectate',SpectateButtonText,SpectateButtonToolTip);
	AddMenuButton('Close',CloseButtonText,CloseButtonToolTip);
	AddMenuButton('Disconnect',DisconnectButtonText,DisconnectButtonToolTip);
	AddMenuButton('Exit',ExitButtonText,ExitButtonToolTip);
	
	for(i=0; i<Pages.Length; ++i)
	{
		PageSwitcher.AddPage(Pages[i],B).InitMenu();
		if(Pages[i]==Class'UIP_AdminMenu')
			AdminButton = B;
	}
}

function Timer()
{
	local PlayerReplicationInfo PRI;
	
	PRI = GetPlayer().PlayerReplicationInfo;
	if(PRI==None)
		return;
	AdminButton.SetDisabled(!PRI.bAdmin && PRI.WorldInfo.NetMode==NM_Client);
	SkipTraderButton.SetDisabled(!SkipTraderIsAviable(PRI));
	if(!bInitSpectate || bOldSpectate!=PRI.bOnlySpectator)
	{
		bInitSpectate = true;
		bOldSpectate = PRI.bOnlySpectator;
		SpectateButton.ButtonText = (bOldSpectate ? JoinButtonText : SpectateButtonText);
		SpectateButton.ChangeToolTip(bOldSpectate ? JoinButtonToolTip : SpectateButtonToolTip);
	}
}

function bool SkipTraderIsAviable(PlayerReplicationInfo PRI)
{
	local KFGameReplicationInfo KFGRI;
	local KFPlayerReplicationInfo KFPRI;

	KFPRI = KFPlayerReplicationInfo(PRI);
	KFGRI = KFGameReplicationInfo(KFPRI.WorldInfo.GRI);
	
	if (KFGRI == none || KFPRI == none)
		return false;
	
	return KFGRI.bMatchHasBegun && KFGRI.bTraderIsOpen && KFPRI.bHasSpawnedIn && !KFPRI.bVotedToSkipTraderTime;
}

function ShowMenu()
{
	Super.ShowMenu();
	AdminButton.SetDisabled(true);
	SkipTraderButton.SetDisabled(false);
	if(GetPlayer().WorldInfo.GRI!=None)
		WindowTitle = GetPlayer().WorldInfo.GRI.ServerName;
	
	// Update spectate button info text.
	Timer();
	SetTimer(0.5,true);
}
function CloseMenu()
{
	Super.CloseMenu();
}
function ButtonClicked(KFGUI_Button Sender)
{
	switch(Sender.ID)
	{
	case 'Mapvote':
		OpenUpMapvote();
		break;
	case 'Settings':
		DoClose();
		KFPlayerController(GetPlayer()).MyGFxManager.OpenMenu(UI_OptionsSelection);
		break;
	case 'Disconnect':
		GetPlayer().ConsoleCommand("DISCONNECT");
		break;
	case 'Close':
		DoClose();
		break;
	case 'Exit':
		GetPlayer().ConsoleCommand("EXIT");
		break;
	case 'Spectate':
		ExtPlayerController(GetPlayer()).ChangeSpectateMode(!bOldSpectate);
		DoClose();
		break;
	case 'SkipTrader':
		KFPlayerController(GetPlayer()).RequestSkipTrader();
		SkipTraderButton.SetDisabled(true);
		break;
	}
}
final function OpenUpMapvote()
{
	local xVotingReplication R;
	
	foreach GetPlayer().DynamicActors(class'xVotingReplication',R)
		R.ClientOpenMapvote();
}

final function KFGUI_Button AddMenuButton(name ButtonID, string Text, optional string ToolTipStr)
{
	local KFGUI_Button B;
	
	B = new (Self) class'KFGUI_Button';
	B.ButtonText = Text;
	B.ToolTip = ToolTipStr;
	B.OnClickLeft = ButtonClicked;
	B.OnClickRight = ButtonClicked;
	B.ID = ButtonID;
	B.XPosition = 0.05+NumButtons*0.1;
	B.XSize = 0.099;
	B.YPosition = 0.92+NumButtonRows*0.04;
	B.YSize = 0.0399;

	if(NumButtons>0 && PrevButton!=None)
		PrevButton.ExtravDir = 1;
	PrevButton = B;
	if(++NumButtons>8)
	{
		++NumButtonRows;
		NumButtons = 0;
	}
	AddComponent(B);
	return B;
}

defaultproperties
{
	WindowTitle="RPG"
	XPosition=0.1
	YPosition=0.1
	XSize=0.8
	YSize=0.8
	
	Pages.Add(Class'UIP_News')
	Pages.Add(Class'UIP_PerkSelection')
	Pages.Add(Class'UIP_Settings')
	Pages.Add(Class'UIP_PlayerSpecs')
	Pages.Add(Class'UIP_AdminMenu')
	Pages.Add(Class'UIP_About')
	Pages.Add(Class'UIP_MiniGame')

	Begin Object Class=KFGUI_SwitchMenuBar Name=MultiPager
		ID="Pager"
		XPosition=0.01
		YPosition=0.08
		XSize=0.98
		YSize=0.775
		BorderWidth=0.04
		ButtonAxisSize=0.08
	End Object
	
	Components.Add(MultiPager)
}