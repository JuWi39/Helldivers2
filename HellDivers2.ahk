SetWorkingDir %A_ScriptDir%
#SingleInstance force
#MaxThreadsPerHotkey 1

version = 1.13
;TO DO - #IfWinActive [WinTitle, WinText] 

;list of Deparment Stratagems
departments=General|Offensive|Supply|Defensive
stratagemOffensive = Eagle 110mm Rocket Pods|Eagle 500kg Bomb|Eagle Airstrike|Eagle Cluster Bomb|Eagle Napalm Airstrike|Eagle Smoke Strike|Eagle Strafing Run|Orbital 120mm HE Barrage|Orbital 380mm HE Barrage|Orbital Airburst Strike|Orbital EMS Strike|Orbital Gas Strike|Orbital Gatling Barrage|Orbital Laser|Orbital Napalm Barrage|Orbital Precision Strike|Orbital Railcannon Strike|Orbital Smoke Strike|Orbital Walking Barrage
stratagemSupply = Airburst Rocket Launcher|Anti-Materiel Rifle|Arc Thrower|Autocannon|Ballistic Shield Backpack|Commando|Directional Shield|Dog Breath|Emancipator Exosuit|Expendable Anti-Tank|Flamethrower|Grenade Launcher|Guard Dog Rover|Guard Dog|Heavy Machine Gun|Jump Pack|Laser Cannon|Machine Gun|Patriot Exosuit|Quasar Cannon|Railgun|Recoilless Rifle|Shield Generator Pack|Spear|Stalwart|Sterilizer|Supply Pack
stratagemDefensive = Anti-Personnel Minefield|Anti-Tank Emplacement|Anti-Tank Mines|Autocannon Sentry|EMS Mortar Sentry|Flame Sentry|Gatling Sentry|HMG Emplacement|Incendiary Mines|Machine Gun Sentry|Mortar Sentry|Rocket Sentry|Shield Generator Relay|Tesla Tower
stratagemGeneralList = Lorem Ipsum|Eagle Rearm|Hellbomb|Reinforce|Resupply|SEAF Artillery

;global variable chosen stratagem on key press
stratagem =

;list of hotkeynames
controls = Zero,Comma,One,Two,Three,Four,Five,Six,Seven,Eight,Nine,Add,Divide,Multiply,Subtract,OneKey,TwoKey,ThreeKey,FourKey

;dial button variable
cPressed = 0

;global list of controls per choice
NumPadChoiceKeys = Zero,Comma,One,Two,Three,Four,Five,Six,Seven,Eight,Nine,Add,Divide,Multiply,Subtract
LongPressChoiceKeys = OneKey,TwoKey,ThreeKey,FourKey

;global list of scriptnamehotkeys
NumPadChoiceHotKeys = *NumpadDiv,NumpadUp,NumPad8,NumpadHome,NumPad7,NumpadPgUp,NumPad9,*NumPadMult,*NumPadSub,*NumPadAdd,NumpadLeft,NumPad4,NumpadClear,NumPad5,NumpadRight,NumPad6,NumpadEnd,NumPad1,NumpadDown,NumPad2,NumpadPgDn,NumPad3,NumpadDel,NumPadDot,NumpadIns,NumPad0
LongPressChoiceHotKeys = ~*1,~*2,~*3,~*4

;doublepress variables
OneKeyPressed = TwoKeyPressed = ThreeKeyPressed = FourKeyPressed = 0

{
Gui, HD2:New
Gui, HD2:Default
Gui, HD2:Color, 6F6F6F

gui, HD2:add, Text, x520 y380 w30 h20, %version%
gui, HD2:add, Button, x470 y380 w45 h15 gUpdate, Update

gui, HD2:add, Picture,  x80 y50 w50 h50 vDivide gDivide, /
gui, HD2:add, Text, w0 h0 vDivide2,

gui, HD2:add, Picture, x140 y50 w50 h50 vMultiply gMultiply, *
gui, HD2:add, Text, w0 h0 vMultiply2,

gui, HD2:add, Picture, x200 y50 w50 h50 vSubtract gSubtract, -
gui, HD2:add, Text, w0 h0 vSubtract2,

gui, HD2:add, Picture, x200 y140 w50 h50 vAdd gAdd, +
gui, HD2:add, Text, x0 y0 w0 h0 vAdd2,

gui, HD2:add, Picture, x20 y110 w50 h50 vSeven gSeven, 7
gui, HD2:add, Text, x0 y0 w0 h0 vSeven2,

gui, HD2:add, Picture, x80 y110 w50 h50 vEight gEight, 8
gui, HD2:add, Text, x0 y0 w0 h0 vEight2,

gui, HD2:add, Picture, x140 y110 w50 h50 vNine gNine, 9
gui, HD2:add, Text, x0 y0 w0 h0 vNine2,

gui, HD2:add, Picture, x20 y170 w50 h50 vFour gFour, 4
gui, HD2:add, Text, x0 y0 w0 h0 vFour2,

gui, HD2:add, Picture, x80 y170 w50 h50 vFive gFive, 5
gui, HD2:add, Text, x0 y0 w0 h0 vFive2,

gui, HD2:add, Picture, x140 y170 w50 h50 vSix gSix, 6
gui, HD2:add, Text, x0 y0 w0 h0 vSix2,

gui, HD2:add, Picture, x20 y230 w50 h50 vOne gOne, 1
gui, HD2:add, Text, x0 y0 w0 h0 vOne2,

gui, HD2:add, Picture, x80 y230 w50 h50 vTwo gTwo, 2
gui, HD2:add, Text, x0 y0 w0 h0 vTwo2,

gui, HD2:add, Picture, x140 y230 w50 h50 vThree gThree, 3
gui, HD2:add, Text, x0 y0 w0 h0 vThree2,

gui, HD2:add, Picture, x50 y290 w50 h50 vZero gZero, 0
gui, HD2:add, Text, x0 y0 w0 h0 vZero2,

gui, HD2:add, Picture, x140 y290 w50 h50 vComma gComma, ,
gui, HD2:add, Text, x0 y0 w0 h0 vComma2,

gui, HD2:add, Picture, x310 y50 w50 h50 vOneKey gOneKey, 1
gui, HD2:add, Text, x0 y0 w0 h0 vOneKey2,

gui, HD2:add, Picture, x370 y50 w50 h50 vTwoKey gTwoKey, 2
gui, HD2:add, Text, x0 y0 w0 h0 vTwoKey2,

gui, HD2:add, Picture, x430 y50 w50 h50 vThreeKey gThreeKey, 3
gui, HD2:add, Text, x0 y0 w0 h0 vThreeKey2,

gui, HD2:add, Picture, x490 y50 w50 h50 vFourKey gFourKey, 4
gui, HD2:add, Text, x0 y0 w0 h0 vFourKey2,

gui, HD2:add, DropDownList, x20 y10 w200 vDepartment gselectDepartment,%departments%
gui, HD2:add, DropDownList, x250 y10 w200 vStratagemChoice,

gui, HD2:add, Text, x300 y220 r1, Place Stratagem 1 on
gui, HD2:add, DropDownList, x410 y220 w100 vStratagem1Place gStratagem1Place,
gui, HD2:add, Text, x300 y250 r1, Place Stratagem 2 on
gui, HD2:add, DropDownList, x410 y250 w100 vStratagem2Place gStratagem2Place,
gui, HD2:add, Text, x300 y280 r1, Place Stratagem 3 on
gui, HD2:add, DropDownList, x410 y280 w100 vStratagem3Place gStratagem3Place,
gui, HD2:add, Text, x300 y310 r1, Place Stratagem 4 on
gui, HD2:add, DropDownList, x410 y310 w100 vStratagem4Place gStratagem4Place,

gui, HD2:add, Checkbox, x200 y350 w100 vNumPadChoice gNumPadChoice, Use NumPad
gui, HD2:add, Checkbox, x200 y365 w100 vLongPressChoice gLongPressChoice, Use DoublePress

Gui, HD2:Add, Radio, x20 y360 w100 vKeyChoice1 gKeyChoice1, WASD Keys
Gui, HD2:Add, Radio, x20 y380 w100 vKeyChoice2 gKeyChoice2, Arrow Keys

gui, HD2:add, Button, x470 y10 w60 h30 gLaunchGame, Launch Game

gui, HD2:show, x1930 y300 w550 h400,
Menu, Tray, Icon, HD2.ico
}

gosub, StandardLoadout

RETURN

LaunchGame:
run, steam://rungameid/553850
RETURN

Update:
UrlDownloadToFile, https://raw.githubusercontent.com/JuWi39/Helldivers2/main/HellDivers2.ahk, Helldivers2.ahk
UrlDownloadToFile, https://raw.githubusercontent.com/JuWi39/Helldivers2/main/HD2_Stratagems.ini, HD2_Stratagems.ini
msgbox, Update Successful
ExitApp
RETURN

;show and hide for controls as per choice
HideOrShow()
{
GuiControlGet, NumPadChoice , HD2:, NumPadChoice
GuiControlGet, LongPressChoice , HD2:, LongPressChoice
global NumPadChoiceKeys
global NumPadChoiceHotKeys
global LongPressChoiceKeys
global LongPressChoiceHotKeys
if (NumPadChoice)
{
	IniWrite, 1, HD2_Standard.ini, Keys, NumPad
	Loop, Parse, NumPadChoiceKeys, `,
	{
	GuiControl, HD2:Show, %A_LoopField%
	}
	Loop, Parse, NumPadChoiceHotKeys, `,
	{
	Hotkey, %A_LoopField%, On
	}
}
else if (!NumPadChoice)
{
	IniWrite, 0, HD2_Standard.ini, Keys, NumPad
	Loop, Parse, NumPadChoiceKeys, `,
	{
	GuiControl, HD2:Hide, %A_LoopField%
	}
	Loop, Parse, NumPadChoiceHotKeys, `,
	{
	Hotkey, %A_LoopField%, Off
	}
}
if (LongPressChoice)
{
	IniWrite, 1, HD2_Standard.ini, Keys, LongPress
	Loop, Parse, LongPressChoiceKeys, `,
	{
	GuiControl, HD2:Show, %A_LoopField%
	}
	Loop, Parse, LongPressChoiceHotKeys, `,
	{
	Hotkey, %A_LoopField%, On
	}
}
else if (!LongPressChoice)
{
	IniWrite, 0, HD2_Standard.ini, Keys, LongPress
	Loop, Parse, LongPressChoiceKeys, `,
	{
	GuiControl, HD2:Hide, %A_LoopField%
	}
	Loop, Parse, LongPressChoiceHotKeys, `,
	{
	Hotkey, %A_LoopField%, Off
	}
}
}

SetButton(ButtonName)
{
if (A_LoopField)
	{
	GuiControl, HD2:, %ButtonName%, %A_LoopField%.png
	IniRead, var2, HD2_Stratagems.ini, Stratagem, %A_LoopField%
	GuiControl, HD2:, %ButtonName%2, %var2%
	IniWrite, %A_LoopField%, HD2_Standard.ini, %ButtonName%, Picture
	IniWrite, %var2%, HD2_Standard.ini, %ButtonName%, Code
	}
	else
	{
	GuiControlGet, StratagemChoice, HD2:, StratagemChoice
		if (StratagemChoice) {
		GuiControl, HD2:, %ButtonName%, %StratagemChoice%.png
		IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
		GuiControl, HD2:, %ButtonName%2, %var2%
		IniWrite, %StratagemChoice%, HD2_Standard.ini, %ButtonName%, Picture
		IniWrite, %var2%, HD2_Standard.ini, %ButtonName%, Code
		}
	}
}

;image recognition for stratagems on p press
~p::
gui, submit, nohide
allStratagems = %stratagemOffensive%|%stratagemSupply%|%stratagemDefensive%
searchWindowEndX := (A_ScreenWidth/2)-(A_ScreenHeight*480/1080)
searchWindowEndY := A_ScreenHeight*(930/1080)
stratagemLeftDivider := searchWindowEndX-(4*85)
stratagemMiddleDivider := searchWindowEndX-(3*85)
stratagemRightDivider := searchWindowEndX-(2*85)
searchWindowStartX := searchWindowEndX-(5*85)
searchWindowStartY := A_ScreenHeight*(830/1080)
GuiControlGet, Stratagem1Place, HD2:, Stratagem1Place
GuiControlGet, Stratagem2Place, HD2:, Stratagem2Place
GuiControlGet, Stratagem3Place, HD2:, Stratagem3Place
GuiControlGet, Stratagem4Place, HD2:, Stratagem4Place
loop, parse, allStratagems, |
{
	ImageSearch, stratagemPosX, stratagemPosY, searchWindowStartX, searchWindowStartY, searchWindowEndX, searchWindowEndY, *25 %A_LoopField%.png
	if Errorlevel = 0
	{
		if (stratagemPosX < stratagemLeftDivider) { 													;first stratagem
			SetButton(Stratagem1Place)
		} else if (stratagemPosX > stratagemRightDivider) {												;fourth stratagem
			SetButton(Stratagem4Place)
		} else if (stratagemPosX > stratagemLeftDivider)&&(stratagemPosX < stratagemMiddleDivider) {	;second stratagem
			SetButton(Stratagem2Place)
		} else {																						;third stratagem
			SetButton(Stratagem3Place)
		}
	}
}
RETURN

;function simulate keypresses for stratagems
dialStratagem(TextBox)
{
gui, submit, nohide
global cPressed
GuiControlGet, stratagem, HD2:, %TextBox%2
GuiControlGet, KeyChoice1, HD2:, KeyChoice1
GuiControlGet, KeyChoice2, HD2:, KeyChoice2
if (stratagem) {
	if (stratagem = "x") {
	SoundPlay, Lorem Ipsum.mp3
	} else if (KeyChoice1) {
		BlockInput, Send	;blocks all input (against interference)
		BlockInput, MouseMoveOff		;re-enables mouse
		send {w up}				;releases some keys
		send {a up}
		send {s up}
		send {d up}
		send {LShift up}
		if !(cPressed) 
		{
		SetKeyDelay, 250, 60
		send c				;stratagem dial button
		}
		SetKeyDelay, 100, 40
		send %stratagem%{Click,right}
		BlockInput, Off
	} else if (KeyChoice2) {
		if !(cPressed) 
		{
			SetKeyDelay, 250, 60
			send c				;stratagem dial button
		}
		SetKeyDelay, 100, 40
		loop, parse, stratagem
		{
			if (A_LoopField="w") {
			send {Up}
			} else if (A_LoopField="a") {
			send {Left}
			} else if (A_LoopField="s") {
			send {Down}
			} else if (A_LoopField="d") {
			send {Right}
		}
	}
send {Click,right}
BlockInput, Off
}
stratagem =
cPressed = 0
}
}

~c::
if !(cPressed) 
	{
	cPressed = 1
	SetTimer, voidCPress, 2000,
	} else {
	cPressed = 0
	setTimer, voidCPress, Off,
	}
RETURN

voidCPress:
cPressed = 0
setTimer, voidCPress, Off,
RETURN

;reads Standard ini for saved Loadout
StandardLoadout:
Loop, Parse, controls, `,
{
	IniRead, var0, HD2_Standard.ini, %A_LoopField%, Picture
	GuiControl, HD2:, %A_LoopField%, %var0%.png
	IniRead, var00, HD2_Standard.ini, %A_LoopField%, Code
	GuiControl, HD2:, %A_LoopField%2, %var00%
}
IniRead, var000, HD2_Standard.ini, Keys, Key
if (var000="wasd") {
GuiControl, HD2:, KeyChoice1, 1
} else {
GuiControl, HD2:, KeyChoice2, 1
}
IniRead, var0000, HD2_Standard.ini, Keys, NumPad
if (var0000) {
GuiControl, HD2:, NumPadChoice, 1
}
IniRead, var00000, HD2_Standard.ini, Keys, LongPress
if (var00000) {
GuiControl, HD2:, LongPressChoice, 1
}
IniRead, var1, HD2_Standard.ini, Preference, Stratagem1Place
var11 = %var1%,
NewStr1 := RegExReplace(controls, var1, var11)
NewStr1 := RegExReplace(NewStr1,",","|")
GuiControl, HD2:, Stratagem1Place, %NewStr1%
IniRead, var1, HD2_Standard.ini, Preference, Stratagem2Place
var11 = %var1%,
NewStr1 := RegExReplace(controls, var1, var11)
NewStr1 := RegExReplace(NewStr1,",","|")
GuiControl, HD2:, Stratagem2Place, %NewStr1%
IniRead, var1, HD2_Standard.ini, Preference, Stratagem3Place
var11 = %var1%,
NewStr1 := RegExReplace(controls, var1, var11)
NewStr1 := RegExReplace(NewStr1,",","|")
GuiControl, HD2:, Stratagem3Place, %NewStr1%
IniRead, var1, HD2_Standard.ini, Preference, Stratagem4Place
var11 = %var1%,
NewStr1 := RegExReplace(controls, var1, var11)
NewStr1 := RegExReplace(NewStr1,",","|")
GuiControl, HD2:, Stratagem4Place, %NewStr1%
HideOrShow()
RETURN

Stratagem1Place:
GuiControlGet, Stratagem1Place, HD2:, Stratagem1Place
IniWrite, %Stratagem1Place%, HD2_Standard.ini, Preference, Stratagem1Place
RETURN

Stratagem2Place:
GuiControlGet, Stratagem2Place, HD2:, Stratagem2Place
IniWrite, %Stratagem2Place%, HD2_Standard.ini, Preference, Stratagem2Place
RETURN

Stratagem3Place:
GuiControlGet, Stratagem3Place, HD2:, Stratagem3Place
IniWrite, %Stratagem3Place%, HD2_Standard.ini, Preference, Stratagem3Place
RETURN

Stratagem4Place:
GuiControlGet, Stratagem4Place, HD2:, Stratagem4Place
IniWrite, %Stratagem4Place%, HD2_Standard.ini, Preference, Stratagem4Place
RETURN

;loads the department stratagemList into the dropdown menu
selectDepartment:
gui, submit, nohide
if (Department="Offensive") {
	GuiControl, HD2:, StratagemChoice, |
	GuiControl, HD2:, StratagemChoice, %stratagemOffensive%
} else if (Department="Supply") {
	GuiControl, HD2:, StratagemChoice, |
	GuiControl, HD2:, StratagemChoice, %stratagemSupply%
} else if (Department="Defensive") {
	GuiControl, HD2:, StratagemChoice, |
	GuiControl, HD2:, StratagemChoice, %stratagemDefensive%
} else if (Department="General") {
	GuiControl, HD2:, StratagemChoice, |
	GuiControl, HD2:, StratagemChoice, %stratagemGeneralList%
} else {
	GuiControl, HD2:, StratagemChoice, |
}
RETURN

KeyChoice1:
gui, submit, nohide
IniWrite, wasd, HD2_Standard.ini, Keys, Key
RETURN

KeyChoice2:
gui, submit, nohide
IniWrite, arrow, HD2_Standard.ini, Keys, Key
RETURN

voidKeys:
OneKeyPressed = 0
TwoKeyPressed = 0
ThreeKeyPressed = 0
FourKeyPressed = 0
RETURN

;hotkeys actions
~*1::
OneKeyPressed++
SetTimer, VoidKeys, 200
if (OneKeyPressed >= 2)
{
dialStratagem("OneKey")
OneKeyPressed = 0
}
RETURN

~*2::
TwoKeyPressed++
SetTimer, VoidKeys, 200
if (TwoKeyPressed >= 2)
{
dialStratagem("TwoKey")
TwoKeyPressed = 0
}
RETURN

~*3::
ThreeKeyPressed++
SetTimer, VoidKeys, 200
if (ThreeKeyPressed >= 2)
{
dialStratagem("ThreeKey")
ThreeKeyPressed = 0
}
RETURN

~*4::
FourKeyPressed++
SetTimer, VoidKeys, 200
if (FourKeyPressed >= 2)
{
dialStratagem("FourKey")
FourKeyPressed = 0
}
RETURN

*NumpadDiv::
dialStratagem("Divide")
RETURN

NumpadUp::
NumPad8::
dialStratagem("Eight")
RETURN

NumpadHome::
NumPad7::
dialStratagem("Seven")
RETURN

NumpadPgUp::
NumPad9::
dialStratagem("Nine")
RETURN

~*NumPadMult::
dialStratagem("Multiply")
RETURN

*NumPadSub::
dialStratagem("Subtract")
RETURN

*NumPadAdd::
dialStratagem("Add")
RETURN

NumpadLeft::
NumPad4::
dialStratagem("Four")
RETURN

NumpadClear::
NumPad5::
dialStratagem("Five")
RETURN

NumpadRight::
NumPad6::
dialStratagem("Six")
RETURN

NumpadEnd::
NumPad1::
dialStratagem("One")
RETURN

NumpadDown::
NumPad2::
dialStratagem("Two")
RETURN

NumpadPgDn::
NumPad3::
dialStratagem("Three")
RETURN

NumpadDel::
NumPadDot::
dialStratagem("Comma")
RETURN

NumpadIns::
NumPad0::
dialStratagem("Zero")
RETURN

~*RButton::
cPressed = 0
RETURN

;subroutines which saves the chosen stratagems to the standard ini, loads the picture boxes and the hidden text boxes from the stratagem ini
OneKey:
SetButton("OneKey")
RETURN

TwoKey:
SetButton("TwoKey")
RETURN

ThreeKey:
SetButton("ThreeKey")
RETURN

FourKey:
SetButton("FourKey")
RETURN

Divide:
SetButton("Divide")
RETURN

Multiply:
SetButton("Multiply")
RETURN

Subtract:
SetButton("Subtract")
RETURN

Add:
SetButton("Add")
RETURN

Seven:
SetButton("Seven")
RETURN

Eight:
SetButton("Eight")
RETURN

Nine:
SetButton("Nine")
RETURN

Four:
SetButton("Four")
RETURN

Five:
SetButton("Five")
RETURN

Six:
SetButton("Six")
RETURN

One:
SetButton("One")
RETURN

Two:
SetButton("Two")
RETURN

Three:
SetButton("Three")
RETURN

Zero:
SetButton("Zero")
RETURN

Comma:
SetButton("Comma")
RETURN

NumPadChoice:
HideOrShow()
RETURN

LongPressChoice:
HideOrShow()
RETURN

HD2GuiClose:
ExitApp