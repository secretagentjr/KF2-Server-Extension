#!/bin/bash

# Requirements: git-bash
# https://git-scm.com/download/win

function winpath2unix () # $1: win path
{
	echo "$*" | \
	sed -r 's|^(.):|\\\1|' | \
	sed 's|\\|/|g'
}

function unixpath2win () # $1: unix path
{
	echo "$*" | \
	sed -r 's|^/(.)|\1:|' | \
	sed 's|/|\\|g'
}

function reg_readkey () # $1: path, $2: key
{
	winpath2unix $(
	reg query "$1" //v "$2" | \
	grep -F "$2"            | \
	awk '{ print $3 }' )
}

function show_help ()
{
	echo "$ScriptName"
	echo "Usage:"
	echo "${ScriptName} OPTION"
	echo "Options:"
	echo "  -c, --compile"
	echo "  -b, --brew"
	echo " -bu, --brew-unpublished"
	echo "  -u, --upload"
	echo "  -t, --test"
	echo "  -h, --help"
}

function compile ()
{
	rm -f "$MutBinUnpublish/ServerExt.u" "$MutBinUnpublish/ServerExtMut.u"
	CMD //C $(unixpath2win "$KFEditor") make -useunpublished &
	local PID="$!"
	while ps -p "$PID" &> /dev/null
	do
		if [[ -e "$MutBinUnpublish/ServerExt.u"    ]] &&
		   [[ -e "$MutBinUnpublish/ServerExtMut.u" ]]; then
			kill "$PID"; break
		fi
		sleep 2
	done
}

function brew ()
{
	echo "brew command is broken. Use --brew-unpublished or brew from WorkshopUploadToolGUI instead of this."
	# CMD //C $(unixpath2win "$KFEditor") brewcontent -platform=PC ServerExt ServerExtMut -useunpublished
}

function brew_unpublished ()
{
	rm -rf "$MutPublish"
	if  ! [[ -e "$MutBinUnpublish/ServerExt.u"    ]] ||
		! [[ -e "$MutBinUnpublish/ServerExtMut.u" ]]; then
		compile
	fi
	cp -rf "$MutUnpublish" "$MutPublish"
}

function prepare_package_dir () # $1: package dir
{
	mkdir -p "$1/Localization/INT"
	cp -rf "$MutPublish"/* "$1"
	cp -f "$MutSource/Localization/INT/ServerExt.int" "$1/Localization/INT"
}

function generate_wsinfo () # $1: package dir
{
	local Description=$(cat "$MutPubContent/description.txt")
	local Title=$(cat "$MutPubContent/title.txt")
	local Preview=$(unixpath2win "$MutPubContent/preview.png")
	local Tags=$(cat "$MutPubContent/tags.txt")
	local PackageDir=$(unixpath2win "$1")
	echo "\$Description \"$Description\"
\$Title \"$Title\"
\$PreviewFile \"$Preview\"
\$Tags \"$Tags\"
\$MicroTxItem \"false\"
\$PackageDirectory \"$PackageDir\"
" > "$MutWsInfo"
}

function upload ()
{
	PackageDir=$(mktemp -d -u -p "$KFDoc")
	prepare_package_dir "$PackageDir"
	generate_wsinfo "$PackageDir"
	CMD //C $(unixpath2win "$KFWorkshop") "$MutWsInfoName"
	rm -rf "$PackageDir"
	rm -f "$MutWsInfo"
}

function create_default_testing_ini ()
{
echo "Map=\"KF-Nuked\"
Game=\"KFGameContent.KFGameInfo_Survival\"
Difficulty=\"0\"
GameLength=\"0\"
Mutators=\"ServerExtMut.ServerExtMut\"
Args=\"\"" > "$MutTestingIni"
}

function game_test ()
{
	if ! [[ -r "$MutTestingIni" ]]; then
		create_default_testing_ini
	fi
	source "$MutTestingIni"
	CMD //C $(unixpath2win "$KFGame") ${Map}?Difficulty=${Difficulty}?GameLength=${GameLength}?Game=${Game}?Mutator=${Mutators}?${Args} -useunpublished -log
}

ScriptFullname=$(readlink -e "$0")
ScriptName=$(echo "$ScriptFullname" | awk -F '/' '{print $NF;}')

SteamPath=$(reg_readkey "HKCU\Software\Valve\Steam" "SteamPath")
DocumentsPath=$(reg_readkey "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "Personal")

KFPath="$SteamPath/steamapps/common/killingfloor2"
KFBin="$KFPath/Binaries"
KFEditor="$KFBin/Win64/KFEditor.exe"
KFGame="$KFBin/Win64/KFGame.exe"
KFWorkshop="$KFBin/WorkshopUserTool.exe"

KFDoc="$DocumentsPath/My Games/KillingFloor2"
MutSource="$KFDoc/KFGame/src"
MutUnpublish="$KFDoc/KFGame/Unpublished"
MutPublish="$KFDoc/KFGame/Published"
MutBinUnpublish="$MutUnpublish/BrewedPC/Script"
MutBinPublish="$MutPublish/BrewedPC/Script"
MutTestingIni="$MutSource/testing.ini"
MutWsInfoName="wsinfo_serverext.txt"
MutWsInfo="$KFDoc/$MutWsInfoName"
MutPubContent="$MutSource/PublicationContent"

if [[ $# -eq 0 ]]; then show_help; exit 0; fi
case $1 in
	  -h|--help             ) show_help        ; ;;
	  -c|--compile          ) compile          ; ;;
	  -b|--brew             ) brew             ; ;;
	 -bu|--brew-unpublished ) brew_unpublished ; ;;
	  -u|--upload           ) upload           ; ;;
	  -t|--test             ) game_test        ; ;;
	    *                   ) echo "Command not recognized: $1"; exit 1;;
esac
