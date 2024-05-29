
SetWorkingDir %A_ScriptDir%
#SingleInstance force

version = 1.11

;list of Deparment Stratagems
departments=General|Offensive|Supply|Defensive
stratagemOffensive = Eagle 110mm Rocket Pods|Eagle 500kg Bomb|Eagle Airstrike|Eagle Cluster Bomb|Eagle Napalm Airstrike|Eagle Smoke Strike|Eagle Strafing Run|Orbital 120mm HE Barrage|Orbital 380mm HE Barrage|Orbital Airburst Strike|Orbital EMS Strike|Orbital Gas Strike|Orbital Gatling Barrage|Orbital Laser|Orbital Precision Strike|Orbital Railcannon Strike|Orbital Smoke Strike|Orbital Walking Barrage
stratagemSupply = Airburst Rocket Launcher|Anti-Materiel Rifle|Arc Thrower|Autocannon|Ballistic Shield Backpack|Emancipator Exosuit|Expendable Anti-Tank|Flamethrower|Grenade Launcher|Guard Dog Rover|Guard Dog|Heavy Machine Gun|Jump Pack|Laser Cannon|Machine Gun|Patriot Exosuit|Quasar Cannon|Railgun|Recoilless Rifle|Shield Generator Pack|Spear|Stalwart|Supply Pack
stratagemDefensive = Anti-Personnel Minefield|Autocannon Sentry|EMS Mortar Sentry|Gatling Sentry|HMG Emplacement|Incendiary Mines|Machine Gun Sentry|Mortar Sentry|Rocket Sentry|Shield Generator Relay|Tesla Tower
stratagemGeneralList = Lorem Ipsum|Eagle Rearm|Hellbomb|Reinforce|Resupply|SEAF Artillery

;global variable chosen stratagem on key press
stratagem =

;list of numpadhotkeys
controls = Divide,Multiply,Subtract,Add,Seven,Eight,Nine,Four,Five,Six,One,Two,Three,Zero,Comma

;dial button variable
cPressed = 0


{
Gui, Color, 6F6F6F
gui, show, x1930 y300 w550 h400,

gui, add, Text, x520 y380 w30 h20, %version%

gui, add, Picture,  x80 y50 w50 h50 vDivide gDivide, /
gui, add, Text, w0 h0 vDivide2,

gui, add, Picture, x140 y50 w50 h50 vMultiply gMultiply, *
gui, add, Text, w0 h0 vMultiply2,

gui, add, Picture, x200 y50 w50 h50 vSubtract gSubtract, -
gui, add, Text, w0 h0 vSubtract2,

gui, add, Picture, x200 y140 w50 h50 vAdd gAdd, +
gui, add, Text, x0 y0 w0 h0 vAdd2,

gui, add, Picture, x20 y110 w50 h50 vSeven gSeven, 7
gui, add, Text, x0 y0 w0 h0 vSeven2,

gui, add, Picture, x80 y110 w50 h50 vEight gEight, 8
gui, add, Text, x0 y0 w0 h0 vEight2,

gui, add, Picture, x140 y110 w50 h50 vNine gNine, 9
gui, add, Text, x0 y0 w0 h0 vNine2,

gui, add, Picture, x20 y170 w50 h50 vFour gFour, 4
gui, add, Text, x0 y0 w0 h0 vFour2,

gui, add, Picture, x80 y170 w50 h50 vFive gFive, 5
gui, add, Text, x0 y0 w0 h0 vFive2,

gui, add, Picture, x140 y170 w50 h50 vSix gSix, 6
gui, add, Text, x0 y0 w0 h0 vSix2,

gui, add, Picture, x20 y230 w50 h50 vOne gOne, 1
gui, add, Text, x0 y0 w0 h0 vOne2,

gui, add, Picture, x80 y230 w50 h50 vTwo gTwo, 2
gui, add, Text, x0 y0 w0 h0 vTwo2,

gui, add, Picture, x140 y230 w50 h50 vThree gThree, 3
gui, add, Text, x0 y0 w0 h0 vThree2,

gui, add, Picture, x50 y290 w50 h50 vZero gZero, 0
gui, add, Text, x0 y0 w0 h0 vZero2,

gui, add, Picture, x140 y290 w50 h50 vComma gComma, ,
gui, add, Text, x0 y0 w0 h0 vComma2,

gui, add, DropDownList, x300 y50 w200 vDepartment gselectDepartment,%departments%
gui, add, DropDownList, x300 y100 w200 vStratagemChoice,

Gui, Add, Radio, x300 y150 w100 vKeyChoice1 gKeyChoice1, WASD Keys
Gui, Add, Radio, x300 y170 w100 vKeyChoice2 gKeyChoice2, Arrow Keys
}
gosub, StandardLoadout
return

;image recognition for stratagems on Enter press
~Enter::
gui, submit, nohide
allStratagems = %stratagemOffensive%|%stratagemSupply%|%stratagemDefensive%
searchWindowEndX := (A_ScreenWidth/2)-(A_ScreenHeight*480/1080)
searchWindowEndY := A_ScreenHeight*(930/1080)
stratagemLeftDivider := searchWindowEndX-(4*85)
stratagemMiddleDivider := searchWindowEndX-(3*85)
stratagemRightDivider := searchWindowEndX-(2*85)
searchWindowStartX := searchWindowEndX-(5*85)
searchWindowStartY := A_ScreenHeight*(830/1080)
loop, parse, allStratagems, |
{
	ImageSearch, stratagemPosX, stratagemPosY, searchWindowStartX, searchWindowStartY, searchWindowEndX, searchWindowEndY, *50 %A_LoopField%.png
	if Errorlevel = 0
	{
		if (stratagemPosX < stratagemLeftDivider) { 													;first stratagem
			GuiControl,, One, %A_LoopField%.png
			IniRead, var2, HD2_Stratagems.ini, Stratagem, %A_LoopField%
			GuiControl,, One2, %var2%
		} else if (stratagemPosX > stratagemRightDivider) {												;fourth stratagem
			GuiControl,, Five, %A_LoopField%.png
			IniRead, var2, HD2_Stratagems.ini, Stratagem, %A_LoopField%
			GuiControl,, Five2, %var2%
		} else if (stratagemPosX > stratagemLeftDivider)&&(stratagemPosX < stratagemMiddleDivider) {	;second stratagem
			GuiControl,, Two, %A_LoopField%.png
			IniRead, var2, HD2_Stratagems.ini, Stratagem, %A_LoopField%
			GuiControl,, Two2, %var2%
		} else {																						;third stratagem
			GuiControl,, Three, %A_LoopField%.png
			IniRead, var2, HD2_Stratagems.ini, Stratagem, %A_LoopField%
			GuiControl,, Three2, %var2%
		}
	}
}
return

;numpad hotkeys actions
*NumpadDiv::
gui, submit, nohide
GuiControlGet, stratagem ,, Divide2 		;this line gets the keycombo for the stratagem from a hidden gui text field
if (stratagem) {
gosub, dialStratagem
}
return

NumpadUp::
NumPad8::
gui, submit, nohide
GuiControlGet, stratagem ,, Eight2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadHome::
NumPad7::
gui, submit, nohide
GuiControlGet, stratagem ,, Seven2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadPgUp::
NumPad9::
gui, submit, nohide
GuiControlGet, stratagem ,, Nine2
if (stratagem) {
gosub, dialStratagem
}
return

*NumPadMult::
gui, submit, nohide
GuiControlGet, stratagem ,, Multiply2
if (stratagem) {
gosub, dialStratagem
}
return

*NumPadSub::
gui, submit, nohide
GuiControlGet, stratagem ,, Subtract2
if (stratagem) {
gosub, dialStratagem
}
return

*NumPadAdd::
gui, submit, nohide
GuiControlGet, stratagem ,, Add2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadLeft::
NumPad4::
gui, submit, nohide
GuiControlGet, stratagem ,, Four2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadClear::
NumPad5::
gui, submit, nohide
GuiControlGet, stratagem ,, Five2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadRight::
NumPad6::
gui, submit, nohide
GuiControlGet, stratagem ,, Six2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadEnd::
NumPad1::
gui, submit, nohide
GuiControlGet, stratagem ,, One2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadDown::
NumPad2::
gui, submit, nohide
GuiControlGet, stratagem ,, Two2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadPgDn::
NumPad3::
gui, submit, nohide
GuiControlGet, stratagem ,, Three2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadDel::
NumPadDot::
gui, submit, nohide
GuiControlGet, stratagem ,, Comma2
if (stratagem) {
gosub, dialStratagem
}
return

NumpadIns::
NumPad0::
gui, submit, nohide
GuiControlGet, stratagem ,, Zero2
if (stratagem) {
gosub, dialStratagem
}
return


;subroutine simulate keypresses for stratagems
dialStratagem:
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
return

~c::
if !(cPressed) 
	{
	cPressed = 1
	SetTimer, voidCPress, 3000,
	} else {
	cPressed = 0
	setTimer, voidCPress, Off,
	}
return

voidCPress:
cPressed = 0
setTimer, voidCPress, Off,
return

;reads Standard ini for saved Loadout
StandardLoadout:
Loop, Parse, controls, `,
{
	IniRead, var1, HD2_Standard.ini, %A_LoopField%, Picture
	GuiControl,, %A_LoopField%, %var1%.png
	IniRead, var1, HD2_Standard.ini, %A_LoopField%, Code
	GuiControl,, %A_LoopField%2, %var1%
}
IniRead, var1, HD2_Standard.ini, Keys, Key
if (var1="wasd") {
GuiControl,, KeyChoice1, 1
} else {
GuiControl,, KeyChoice2, 1
}

return

;loads the department stratagemList into the dropdown menu
selectDepartment:
gui, submit, nohide
if (Department="Offensive") {
	GuiControl,, StratagemChoice, |
	GuiControl,, StratagemChoice, %stratagemOffensive%
} else if (Department="Supply") {
	GuiControl,, StratagemChoice, |
	GuiControl,, StratagemChoice, %stratagemSupply%
} else if (Department="Defensive") {
	GuiControl,, StratagemChoice, |
	GuiControl,, StratagemChoice, %stratagemDefensive%
} else if (Department="General") {
	GuiControl,, StratagemChoice, |
	GuiControl,, StratagemChoice, %stratagemGeneralList%
} else {
	GuiControl,, StratagemChoice, |
}
return

;subroutines which saves the chosen stratagems to the standard ini, loads the picture boxes and the hidden text boxes from the stratagem ini
Divide:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Divide, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Divide2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Divide, Picture
IniWrite, %var2%, HD2_Standard.ini, Divide, Code
}
return

Multiply:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Multiply, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Multiply2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Multiply, Picture
IniWrite, %var2%, HD2_Standard.ini, Multiply, Code
}
return

Subtract:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Subtract, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Subtract2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Subtract, Picture
IniWrite, %var2%, HD2_Standard.ini, Subtract, Code
}
return

Add:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Add, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Add2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Add, Picture
IniWrite, %var2%, HD2_Standard.ini, Add, Code
}
return

Seven:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Seven, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Seven2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Seven, Picture
IniWrite, %var2%, HD2_Standard.ini, Seven, Code
}
return

Eight:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Eight, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Eight2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Eight, Picture
IniWrite, %var2%, HD2_Standard.ini, Eight, Code
}
return

Nine:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Nine, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Nine2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Nine, Picture
IniWrite, %var2%, HD2_Standard.ini, Nine, Code
}
return

Four:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Four, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Four2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Four, Picture
IniWrite, %var2%, HD2_Standard.ini, Four, Code
}
return

Five:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Five, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Five2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Five, Picture
IniWrite, %var2%, HD2_Standard.ini, Five, Code
}
return

Six:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Six, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Six2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Six, Picture
IniWrite, %var2%, HD2_Standard.ini, Six, Code
}
return

One:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, One, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, One2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, One, Picture
IniWrite, %var2%, HD2_Standard.ini, One, Code
}
return

Two:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Two, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Two2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Two, Picture
IniWrite, %var2%, HD2_Standard.ini, Two, Code
}
return

Three:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Three, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Three2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Three, Picture
IniWrite, %var2%, HD2_Standard.ini, Three, Code
}
return

Zero:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Zero, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Zero2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Zero, Picture
IniWrite, %var2%, HD2_Standard.ini, Zero, Code
}
return

Comma:
gui, submit, nohide
if (StratagemChoice) {
GuiControl,, Comma, %StratagemChoice%.png
IniRead, var2, HD2_Stratagems.ini, Stratagem, %StratagemChoice%
GuiControl,, Comma2, %var2%
IniWrite, %StratagemChoice%, HD2_Standard.ini, Comma, Picture
IniWrite, %var2%, HD2_Standard.ini, Comma, Code
}
return

KeyChoice1:
gui, submit, nohide
IniWrite, wasd, HD2_Standard.ini, Keys, Key
return

KeyChoice2:
gui, submit, nohide
IniWrite, arrow, HD2_Standard.ini, Keys, Key
return

GuiClose:
ExitApp

