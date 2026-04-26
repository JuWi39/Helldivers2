SetWorkingDir %A_ScriptDir%
#SingleInstance force
#MaxThreadsPerHotkey 1

version = 1.15
;TO DO - #IfWinActive [WinTitle, WinText] 
; add hivebreaker drill, geo-drill

;if you want to ADD Stratagems, add them in "HD2_Stratagems.ini"
;creating list of Deparment Stratagems
IniRead, prepareDepartments, HD2_Stratagems.ini
departments := IniContentFormatter(prepareDepartments,0)
IniRead, prepareStratagemOffensive, HD2_Stratagems.ini, Offensive
stratagemOffensive := IniContentFormatter(prepareStratagemOffensive,1)
IniRead, prepareStratagemSupply, HD2_Stratagems.ini, Supply
stratagemSupply := IniContentFormatter(prepareStratagemSupply,1)
IniRead, prepareStratagemDefensive, HD2_Stratagems.ini, Defensive
stratagemDefensive := IniContentFormatter(prepareStratagemDefensive,1)
IniRead, prepareStratagemGeneralList, HD2_Stratagems.ini, General
stratagemGeneralList := IniContentFormatter(prepareStratagemGeneralList,1)

; Finding out what the max stratagems are via supply strats
maxStratagems = 0
Loop, parse, stratagemSupply, |,
{
maxStratagems = %A_Index%
}

; creating image search list
buildImageSearchList()

;global variable chosen stratagem on key press
stratagem =

;global variable for the chosen stratagem placement called by the numpad click contains numpadhotkeyinfo
CalledByXButton = 

;list of hotkeynames
controls = Zero,Comma,One,Two,Three,Four,Five,Six,Seven,Eight,Nine,Add,Divide,Multiply,Subtract,OneKey,TwoKey,ThreeKey,FourKey

;stratagem dial button variable
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

gui, SelectStrat:new
Gui, SelectStrat:Color, 6F6F6F

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

gui, SelectStrat:add, Picture, x95 y25 w50 h50 vGeneralStrats gGeneralStrats, General.png
gui, SelectStrat:add, Picture, x215 y25 w50 h50 vOffensiveStrats gOffensiveStrats, Offensive.png
gui, SelectStrat:add, Picture, x335 y25 w50 h50 vSupplyStrats gDefensiveStrats, Defensive.png
gui, SelectStrat:add, Picture, x455 y25 w50 h50 vDefensiveStrats gSupplyStrats, Supply.png

gui, SelectStrat:add, Picture, x5 y105 w50 h50 vChoosePic1 gChoosePic1
gui, SelectStrat:add, Picture, x65 y105 w50 h50 vChoosePic2 gChoosePic2
gui, SelectStrat:add, Picture, x125 y105 w50 h50 vChoosePic3 gChoosePic3
gui, SelectStrat:add, Picture, x185 y105 w50 h50 vChoosePic4 gChoosePic4
gui, SelectStrat:add, Picture, x245 y105 w50 h50 vChoosePic5 gChoosePic5
gui, SelectStrat:add, Picture, x305 y105 w50 h50 vChoosePic6 gChoosePic6
gui, SelectStrat:add, Picture, x365 y105 w50 h50 vChoosePic7 gChoosePic7
gui, SelectStrat:add, Picture, x425 y105 w50 h50 vChoosePic8 gChoosePic8
gui, SelectStrat:add, Picture, x485 y105 w50 h50 vChoosePic9 gChoosePic9
gui, SelectStrat:add, Picture, x545 y105 w50 h50 vChoosePic10 gChoosePic10
gui, SelectStrat:add, Picture, x5 y165 w50 h50 vChoosePic11 gChoosePic11
gui, SelectStrat:add, Picture, x65 y165 w50 h50 vChoosePic12 gChoosePic12
gui, SelectStrat:add, Picture, x125 y165 w50 h50 vChoosePic13 gChoosePic13
gui, SelectStrat:add, Picture, x185 y165 w50 h50 vChoosePic14 gChoosePic14
gui, SelectStrat:add, Picture, x245 y165 w50 h50 vChoosePic15 gChoosePic15
gui, SelectStrat:add, Picture, x305 y165 w50 h50 vChoosePic16 gChoosePic16
gui, SelectStrat:add, Picture, x365 y165 w50 h50 vChoosePic17 gChoosePic17
gui, SelectStrat:add, Picture, x425 y165 w50 h50 vChoosePic18 gChoosePic18
gui, SelectStrat:add, Picture, x485 y165 w50 h50 vChoosePic19 gChoosePic19
gui, SelectStrat:add, Picture, x545 y165 w50 h50 vChoosePic20 gChoosePic20
gui, SelectStrat:add, Picture, x5 y225 w50 h50 vChoosePic21 gChoosePic21
gui, SelectStrat:add, Picture, x65 y225 w50 h50 vChoosePic22 gChoosePic22
gui, SelectStrat:add, Picture, x125 y225 w50 h50 vChoosePic23 gChoosePic23
gui, SelectStrat:add, Picture, x185 y225 w50 h50 vChoosePic24 gChoosePic24
gui, SelectStrat:add, Picture, x245 y225 w50 h50 vChoosePic25 gChoosePic25
gui, SelectStrat:add, Picture, x305 y225 w50 h50 vChoosePic26 gChoosePic26
gui, SelectStrat:add, Picture, x365 y225 w50 h50 vChoosePic27 gChoosePic27
gui, SelectStrat:add, Picture, x425 y225 w50 h50 vChoosePic28 gChoosePic28
gui, SelectStrat:add, Picture, x485 y225 w50 h50 vChoosePic29 gChoosePic29
gui, SelectStrat:add, Picture, x545 y225 w50 h50 vChoosePic30 gChoosePic30
gui, SelectStrat:add, Picture, x5 y285 w50 h50 vChoosePic31 gChoosePic31
gui, SelectStrat:add, Picture, x65 y285 w50 h50 vChoosePic32 gChoosePic32
gui, SelectStrat:add, Picture, x125 y285 w50 h50 vChoosePic33 gChoosePic33
gui, SelectStrat:add, Picture, x185 y285 w50 h50 vChoosePic34 gChoosePic34
gui, SelectStrat:add, Picture, x245 y285 w50 h50 vChoosePic35 gChoosePic35
gui, SelectStrat:add, Picture, x305 y285 w50 h50 vChoosePic36 gChoosePic36
gui, SelectStrat:add, Picture, x365 y285 w50 h50 vChoosePic37 gChoosePic37
gui, SelectStrat:add, Picture, x425 y285 w50 h50 vChoosePic38 gChoosePic38
gui, SelectStrat:add, Picture, x485 y285 w50 h50 vChoosePic39 gChoosePic39
gui, SelectStrat:add, Picture, x545 y285 w50 h50 vChoosePic40 gChoosePic40
gui, SelectStrat:add, Picture, x5 y345 w50 h50 vChoosePic41 gChoosePic41
gui, SelectStrat:add, Picture, x65 y345 w50 h50 vChoosePic42 gChoosePic42
gui, SelectStrat:add, Picture, x125 y345 w50 h50 vChoosePic43 gChoosePic43
gui, SelectStrat:add, Picture, x185 y345 w50 h50 vChoosePic44 gChoosePic44
gui, SelectStrat:add, Picture, x245 y345 w50 h50 vChoosePic45 gChoosePic45
gui, SelectStrat:add, Picture, x305 y345 w50 h50 vChoosePic46 gChoosePic46
gui, SelectStrat:add, Picture, x365 y345 w50 h50 vChoosePic47 gChoosePic47
gui, SelectStrat:add, Picture, x425 y345 w50 h50 vChoosePic48 gChoosePic48
gui, SelectStrat:add, Picture, x485 y345 w50 h50 vChoosePic49 gChoosePic49
gui, SelectStrat:add, Picture, x545 y345 w50 h50 vChoosePic50 gChoosePic50
gui, SelectStrat:add, Picture, x5 y405 w50 h50 vChoosePic51 gChoosePic51
gui, SelectStrat:add, Picture, x65 y405 w50 h50 vChoosePic52 gChoosePic52
gui, SelectStrat:add, Picture, x125 y405 w50 h50 vChoosePic53 gChoosePic53
gui, SelectStrat:add, Picture, x185 y405 w50 h50 vChoosePic54 gChoosePic54
gui, SelectStrat:add, Picture, x245 y405 w50 h50 vChoosePic55 gChoosePic55
gui, SelectStrat:add, Picture, x305 y405 w50 h50 vChoosePic56 gChoosePic56
gui, SelectStrat:add, Picture, x365 y405 w50 h50 vChoosePic57 gChoosePic57
gui, SelectStrat:add, Picture, x425 y405 w50 h50 vChoosePic58 gChoosePic58
gui, SelectStrat:add, Picture, x485 y405 w50 h50 vChoosePic59 gChoosePic59
gui, SelectStrat:add, Picture, x545 y405 w50 h50 vChoosePic60 gChoosePic60
gui, SelectStrat:add, Picture, x5 y465 w50 h50 vChoosePic61 gChoosePic61
gui, SelectStrat:add, Picture, x65 y465 w50 h50 vChoosePic62 gChoosePic62
gui, SelectStrat:add, Picture, x125 y465 w50 h50 vChoosePic63 gChoosePic63
gui, SelectStrat:add, Picture, x185 y465 w50 h50 vChoosePic64 gChoosePic64
gui, SelectStrat:add, Picture, x245 y465 w50 h50 vChoosePic65 gChoosePic65
gui, SelectStrat:add, Picture, x305 y465 w50 h50 vChoosePic66 gChoosePic66
gui, SelectStrat:add, Picture, x365 y465 w50 h50 vChoosePic67 gChoosePic67
gui, SelectStrat:add, Picture, x425 y465 w50 h50 vChoosePic68 gChoosePic68
gui, SelectStrat:add, Picture, x485 y465 w50 h50 vChoosePic69 gChoosePic69
gui, SelectStrat:add, Picture, x545 y465 w50 h50 vChoosePic70 gChoosePic70
gui, SelectStrat:add, Picture, x5 y525 w50 h50 vChoosePic71 gChoosePic71
gui, SelectStrat:add, Picture, x65 y525 w50 h50 vChoosePic72 gChoosePic72
gui, SelectStrat:add, Picture, x125 y525 w50 h50 vChoosePic73 gChoosePic73
gui, SelectStrat:add, Picture, x185 y525 w50 h50 vChoosePic74 gChoosePic74
gui, SelectStrat:add, Picture, x245 y525 w50 h50 vChoosePic75 gChoosePic75
gui, SelectStrat:add, Picture, x305 y525 w50 h50 vChoosePic76 gChoosePic76
gui, SelectStrat:add, Picture, x365 y525 w50 h50 vChoosePic77 gChoosePic77
gui, SelectStrat:add, Picture, x425 y525 w50 h50 vChoosePic78 gChoosePic78
gui, SelectStrat:add, Picture, x485 y525 w50 h50 vChoosePic79 gChoosePic79
gui, SelectStrat:add, Picture, x545 y525 w50 h50 vChoosePic80 gChoosePic80
gui, SelectStrat:add, Picture, x5 y585 w50 h50 vChoosePic81 gChoosePic81
gui, SelectStrat:add, Picture, x65 y585 w50 h50 vChoosePic82 gChoosePic82
gui, SelectStrat:add, Picture, x125 y585 w50 h50 vChoosePic83 gChoosePic83
gui, SelectStrat:add, Picture, x185 y585 w50 h50 vChoosePic84 gChoosePic84
gui, SelectStrat:add, Picture, x245 y585 w50 h50 vChoosePic85 gChoosePic85
gui, SelectStrat:add, Picture, x305 y585 w50 h50 vChoosePic86 gChoosePic86
gui, SelectStrat:add, Picture, x365 y585 w50 h50 vChoosePic87 gChoosePic87
gui, SelectStrat:add, Picture, x425 y585 w50 h50 vChoosePic88 gChoosePic88
gui, SelectStrat:add, Picture, x485 y585 w50 h50 vChoosePic89 gChoosePic89
gui, SelectStrat:add, Picture, x545 y585 w50 h50 vChoosePic90 gChoosePic90
gui, SelectStrat:add, Picture, x5 y645 w50 h50 vChoosePic91 gChoosePic91
gui, SelectStrat:add, Picture, x65 y645 w50 h50 vChoosePic92 gChoosePic92
gui, SelectStrat:add, Picture, x125 y645 w50 h50 vChoosePic93 gChoosePic93
gui, SelectStrat:add, Picture, x185 y645 w50 h50 vChoosePic94 gChoosePic94
gui, SelectStrat:add, Picture, x245 y645 w50 h50 vChoosePic95 gChoosePic95
gui, SelectStrat:add, Picture, x305 y645 w50 h50 vChoosePic96 gChoosePic96
gui, SelectStrat:add, Picture, x365 y645 w50 h50 vChoosePic97 gChoosePic97
gui, SelectStrat:add, Picture, x425 y645 w50 h50 vChoosePic98 gChoosePic98
gui, SelectStrat:add, Picture, x485 y645 w50 h50 vChoosePic99 gChoosePic99
gui, SelectStrat:add, Picture, x545 y645 w50 h50 vChoosePic100 gChoosePic100

gui, HD2:add, DropDownList, x20 y10 w200 vDepartment gselectDepartment, %departments%
gui, HD2:add, DropDownList, x250 y10 w200 vStratagemChoice,

gui, HD2:add, Text, x300 y220 r1 vStratagem1PlaceLabel, Place Stratagem 1 on
gui, HD2:add, DropDownList, x410 y220 w100 vStratagem1Place gStratagem1Place,
gui, HD2:add, Text, x300 y250 r1 vStratagem2PlaceLabel, Place Stratagem 2 on
gui, HD2:add, DropDownList, x410 y250 w100 vStratagem2Place gStratagem2Place,
gui, HD2:add, Text, x300 y280 r1 vStratagem3PlaceLabel, Place Stratagem 3 on
gui, HD2:add, DropDownList, x410 y280 w100 vStratagem3Place gStratagem3Place,
gui, HD2:add, Text, x300 y310 r1 vStratagem4PlaceLabel, Place Stratagem 4 on
gui, HD2:add, DropDownList, x410 y310 w100 vStratagem4Place gStratagem4Place,

gui, HD2:add, Checkbox, x140 y360 w100 h20 vNumPadChoice gNumPadChoice, Use NumPad
gui, HD2:add, Checkbox, x140 y380 w100 h20 vLongPressChoice gLongPressChoice, Use DoublePress
gui, HD2:add, Checkbox, x260 y380 w160 h20 gStratPlacement vStratPlacementChoice , Show Stratagem Placement

Gui, HD2:Add, Radio, x20 y360 w100 h20 vKeyChoice1 gKeyChoice1, WASD Keys
Gui, HD2:Add, Radio, x20 y380 w100 h20 vKeyChoice2 gKeyChoice2, Arrow Keys

gui, HD2:add, Button, x470 y10 w60 h30 gLaunchGame, Launch Game

gui, HD2:show, x1930 y300 w550 h400,
gui, SelectStrat:show, x1950 y200 w600 h700
gui, SelectStrat:hide
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
downloadStratagems = %stratagemOffensive%|%stratagemSupply%|%stratagemDefensive%|%stratagemGeneralList%
loop, parse, downloadStratagems, |
{
	if (A_LoopField != "Lorem Ipsum") {
	UrlDownloadToFile, https://raw.githubusercontent.com/JuWi39/Helldivers2/main/%A_LoopField%.png, %A_LoopField%.png
	}
}
msgbox, Update Successful
ExitApp
RETURN

;building the image searching list in the most complicated way
buildImageSearchList()
{
global prepareStratagemDefensive
global prepareStratagemOffensive
global prepareStratagemSupply
global ImageSearchList
OffensiveArray := []
DefensiveArray := []
SupplyArray := []
ListOffensive := IniContentFormatter(prepareStratagemOffensive,0)
ListDefensive := IniContentFormatter(prepareStratagemDefensive,0)
ListSupply := IniContentFormatter(prepareStratagemSupply,0)
Loop, Parse, ListOffensive, |,
{
    OffensiveArray.push(A_LoopField)
}
Loop, Parse, ListDefensive, |,
{
    DefensiveArray.push(A_LoopField)
}
Loop, Parse, ListSupply, |,
{
    SupplyArray.push(A_LoopField)
}
SupplyArrayLength := SupplyArray.Length()
loop, %SupplyArrayLength%
{
OffensivePop := OffensiveArray.Pop()
DefensivePop := DefensiveArray.Pop()
SupplyPop := SupplyArray.Pop()
	if (OffensivePop) {
	ImageSearchList = %ImageSearchList%%OffensivePop%|
	}
	if (DefensivePop) {
	ImageSearchList = %ImageSearchList%%DefensivePop%|
	}
	if (SupplyPop) {
	ImageSearchList = %ImageSearchList%%SupplyPop%|
	}
}
}

;moves the stratagem up in its list
movinUp(stratagemToMove, section, key)
{
if (stratagemToMove && section && key)
{
IniDelete, HD2_Stratagems.ini, %section%, %stratagemToMove%
IniWrite, %key%, HD2_Stratagems.ini, %section%, %stratagemToMove%
}
}

;Reads an .ini Section and formats the content to a dropdownlist, with a binary .Sorted. for alphabetical sorting
IniContentFormatter(IniContent, Sorted) 
{
if (Sorted) {
Sort, IniContent
}
Sorted = 0
IniContent := StrReplace(IniContent,"`n","|")
IniContent := StrReplace(IniContent,"?")
IniContent := StrReplace(IniContent,"=")
IniContent := StrReplace(IniContent,"^")
IniContent := StrReplace(IniContent,">")
IniContent := StrReplace(IniContent,"<")
IniContent := StrReplace(IniContent,"_")
return IniContent
}

;show and hide for controls as per choice
StratPlacement()
{
GuiControlGet, StratPlacementChoice , HD2:, StratPlacementChoice
if(StratPlacementChoice)
{
	GuiControl, HD2:Show, Stratagem1PlaceLabel
	GuiControl, HD2:Show, Stratagem2PlaceLabel
	GuiControl, HD2:Show, Stratagem3PlaceLabel
	GuiControl, HD2:Show, Stratagem4PlaceLabel
	GuiControl, HD2:Show, Stratagem1Place
	GuiControl, HD2:Show, Stratagem2Place
	GuiControl, HD2:Show, Stratagem3Place
	GuiControl, HD2:Show, Stratagem4Place
}
else if (!StratPlacementChoice)
{
	GuiControl, HD2:Hide, Stratagem1PlaceLabel
	GuiControl, HD2:Hide, Stratagem2PlaceLabel
	GuiControl, HD2:Hide, Stratagem3PlaceLabel
	GuiControl, HD2:Hide, Stratagem4PlaceLabel
	GuiControl, HD2:Hide, Stratagem1Place
	GuiControl, HD2:Hide, Stratagem2Place
	GuiControl, HD2:Hide, Stratagem3Place
	GuiControl, HD2:Hide, Stratagem4Place
}
}

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
global stratagemGeneralList
global stratagemOffensive
global stratagemSupply
global stratagemDefensive
searchListOffensive = %stratagemOffensive%|
searchListDefensive = %stratagemDefensive%|
searchListSupply = %stratagemSupply%|
searchListGeneral = %stratagemGeneralList%|
if (A_LoopField)
	{
	GuiControl, HD2:, %ButtonName%, %A_LoopField%.png
		searchTermWithSeparator = %A_LoopField%|
		if InStr(searchListGeneral, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, General, %A_LoopField%
		}
		if InStr(searchListSupply, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, Supply, %A_LoopField%
		movinUp(A_LoopField,"Supply",var2)
		}
		if InStr(searchListOffensive, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, Offensive, %A_LoopField% 
		movinUp(A_LoopField,"Offensive",var2)
		}
		if InStr(searchListDefensive, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, Defensive, %A_LoopField%
		movinUp(A_LoopField,"Defensive",var2)
		}
	GuiControl, HD2:, %ButtonName%2, %var2%
	IniWrite, %A_LoopField%, HD2_Standard.ini, %ButtonName%, Picture
	IniWrite, %var2%, HD2_Standard.ini, %ButtonName%, Code
	}
	else
	{
	GuiControlGet, StratagemChoice, HD2:, StratagemChoice
		if (StratagemChoice) {
		GuiControl, HD2:, %ButtonName%, %StratagemChoice%.png
		searchTermWithSeparator = %StratagemChoice%|
		if InStr(searchListGeneral, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, General, %StratagemChoice%
		}
		if InStr(searchListSupply, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, Supply, %StratagemChoice%
		movinUp(StratagemChoice,"Supply",var2)
		}
		if InStr(searchListOffensive, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, Offensive, %StratagemChoice%
		movinUp(StratagemChoice,"Offensive",var2)
		}
		if InStr(searchListDefensive, searchTermWithSeparator) {
		IniRead, var2, HD2_Stratagems.ini, Defensive, %StratagemChoice%
		movinUp(StratagemChoice,"Defensive",var2)
		}
		GuiControl, HD2:, %ButtonName%2, %var2%
		IniWrite, %StratagemChoice%, HD2_Standard.ini, %ButtonName%, Picture
		IniWrite, %var2%, HD2_Standard.ini, %ButtonName%, Code
		}
	}
}

;image recognition for stratagems on p press
~p::
gui, submit, nohide
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
loop, parse, ImageSearchList, |
{
	ImageSearch, stratagemPosX, stratagemPosY, searchWindowStartX, searchWindowStartY, searchWindowEndX, searchWindowEndY, *40 %A_LoopField%.png
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
	if (stratagem = "?") {
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
		loop, parse, stratagem
		{
			if (A_LoopField="^") {
			send w
			} else if (A_LoopField="<") {
			send a
			} else if (A_LoopField="_") {
			send s
			} else if (A_LoopField=">") {
			send d
			}
		}		
		send {Click,right}
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
			if (A_LoopField="^") {
			send {Up}
			} else if (A_LoopField="<") {
			send {Left}
			} else if (A_LoopField="_") {
			send {Down}
			} else if (A_LoopField=">") {
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
	SetTimer, voidCPress, 3000,
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
GuiControl, HD2: , StratPlacementChoice, 0
StratPlacement()
HideOrShow()
loop, 64
{
GuiControl, HD2:Hide, ChoosePic%A_Index%
}
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
	Loop, %maxStratagems%
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, Lorem Ipsum.png
	}
	Loop, parse, stratagemOffensive, |,
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, %A_LoopField%.png
	}
} else if (Department="Supply") {
	GuiControl, HD2:, StratagemChoice, |
	GuiControl, HD2:, StratagemChoice, %stratagemSupply%
	Loop, %maxStratagems%
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, Lorem Ipsum.png
	}
	Loop, parse, stratagemSupply, |,
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, %A_LoopField%.png
	}
} else if (Department="Defensive") {
	GuiControl, HD2:, StratagemChoice, |
	GuiControl, HD2:, StratagemChoice, %stratagemDefensive%
	Loop, %maxStratagems%
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, Lorem Ipsum.png
	}
	Loop, parse, stratagemDefensive, |,
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, %A_LoopField%.png
	}
} else if (Department="General") {
	GuiControl, HD2:, StratagemChoice, |
	GuiControl, HD2:, StratagemChoice, %stratagemGeneralList%
	Loop, %maxStratagems%
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, Lorem Ipsum.png
	}
	Loop, parse, stratagemGeneralList, |,
	{
		GuiControl, SelectStrat:, ChoosePic%A_Index%, %A_LoopField%.png
	}
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
CalledByXButton = OneKey
gui, SelectStrat:show
RETURN

TwoKey:
CalledByXButton = TwoKey
gui, SelectStrat:show
RETURN

ThreeKey:
CalledByXButton = ThreeKey
gui, SelectStrat:show
RETURN

FourKey:
CalledByXButton = FourKey
gui, SelectStrat:show
RETURN

Divide:
CalledByXButton = Divide
gui, SelectStrat:show
RETURN

Multiply:
CalledByXButton = Multiply
gui, SelectStrat:show
RETURN

Subtract:
CalledByXButton = Subtract
gui, SelectStrat:show
RETURN

Add:
CalledByXButton = Add
gui, SelectStrat:show
RETURN

Seven:
CalledByXButton = Seven
gui, SelectStrat:show
RETURN

Eight:
CalledByXButton = Eight
gui, SelectStrat:show
RETURN

Nine:
CalledByXButton = Nine
gui, SelectStrat:show
RETURN

Four:
CalledByXButton = Four
gui, SelectStrat:show
RETURN

Five:
CalledByXButton = Five
gui, SelectStrat:show
RETURN

Six:
CalledByXButton = Six
gui, SelectStrat:show
RETURN

One:
CalledByXButton = One
gui, SelectStrat:show
RETURN

Two:
CalledByXButton = Two
gui, SelectStrat:show
RETURN

Three:
CalledByXButton = Three
gui, SelectStrat:show
RETURN

Zero:
CalledByXButton = Zero
gui, SelectStrat:show
RETURN

Comma:
CalledByXButton = Comma
gui, SelectStrat:show
RETURN

; 4 Department Pics to select in the extra window

GeneralStrats:
gui, submit, nohide
GuiControl, HD2:Choose, Department, |1
RETURN

OffensiveStrats:
gui, submit, nohide
GuiControl, HD2:Choose, Department, |2
RETURN

DefensiveStrats:
gui, submit, nohide
GuiControl, HD2:Choose, Department, |3
RETURN

SupplyStrats:
gui, submit, nohide
GuiControl, HD2:Choose, Department, |4
RETURN

;Different Pics in the extra Window to select stratagems

ChoosePic1:
GuiControl, HD2:Choose, StratagemChoice, 1
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic2:
GuiControl, HD2:Choose, StratagemChoice, 2
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic3:
GuiControl, HD2:Choose, StratagemChoice, 3
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic4:
GuiControl, HD2:Choose, StratagemChoice, 4
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic5:
GuiControl, HD2:Choose, StratagemChoice, 5
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic6:
GuiControl, HD2:Choose, StratagemChoice, 6
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic7:
GuiControl, HD2:Choose, StratagemChoice, 7
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic8:
GuiControl, HD2:Choose, StratagemChoice, 8
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic9:
GuiControl, HD2:Choose, StratagemChoice, 9
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic10:
GuiControl, HD2:Choose, StratagemChoice, 10
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic11:
GuiControl, HD2:Choose, StratagemChoice, 11
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic12:
GuiControl, HD2:Choose, StratagemChoice, 12
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic13:
GuiControl, HD2:Choose, StratagemChoice, 13
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic14:
GuiControl, HD2:Choose, StratagemChoice, 14
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic15:
GuiControl, HD2:Choose, StratagemChoice, 15
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic16:
GuiControl, HD2:Choose, StratagemChoice, 16
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic17:
GuiControl, HD2:Choose, StratagemChoice, 17
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic18:
GuiControl, HD2:Choose, StratagemChoice, 18
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic19:
GuiControl, HD2:Choose, StratagemChoice, 19
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic20:
GuiControl, HD2:Choose, StratagemChoice, 20
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic21:
GuiControl, HD2:Choose, StratagemChoice, 21
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic22:
GuiControl, HD2:Choose, StratagemChoice, 22
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic23:
GuiControl, HD2:Choose, StratagemChoice, 23
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic24:
GuiControl, HD2:Choose, StratagemChoice, 24
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic25:
GuiControl, HD2:Choose, StratagemChoice, 25
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic26:
GuiControl, HD2:Choose, StratagemChoice, 26
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic27:
GuiControl, HD2:Choose, StratagemChoice, 27
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic28:
GuiControl, HD2:Choose, StratagemChoice, 28
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic29:
GuiControl, HD2:Choose, StratagemChoice, 29
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic30:
GuiControl, HD2:Choose, StratagemChoice, 30
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic31:
GuiControl, HD2:Choose, StratagemChoice, 31
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic32:
GuiControl, HD2:Choose, StratagemChoice, 32
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic33:
GuiControl, HD2:Choose, StratagemChoice, 33
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic34:
GuiControl, HD2:Choose, StratagemChoice, 34
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic35:
GuiControl, HD2:Choose, StratagemChoice, 35
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic36:
GuiControl, HD2:Choose, StratagemChoice, 36
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic37:
GuiControl, HD2:Choose, StratagemChoice, 37
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic38:
GuiControl, HD2:Choose, StratagemChoice, 38
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic39:
GuiControl, HD2:Choose, StratagemChoice, 39
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic40:
GuiControl, HD2:Choose, StratagemChoice, 40
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic41:
GuiControl, HD2:Choose, StratagemChoice, 41
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic42:
GuiControl, HD2:Choose, StratagemChoice, 42
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic43:
GuiControl, HD2:Choose, StratagemChoice, 43
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic44:
GuiControl, HD2:Choose, StratagemChoice, 44
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic45:
GuiControl, HD2:Choose, StratagemChoice, 45
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic46:
GuiControl, HD2:Choose, StratagemChoice, 46
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic47:
GuiControl, HD2:Choose, StratagemChoice, 47
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic48:
GuiControl, HD2:Choose, StratagemChoice, 48
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic49:
GuiControl, HD2:Choose, StratagemChoice, 49
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic50:
GuiControl, HD2:Choose, StratagemChoice, 50
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic51:
GuiControl, HD2:Choose, StratagemChoice, 51
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic52:
GuiControl, HD2:Choose, StratagemChoice, 52
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic53:
GuiControl, HD2:Choose, StratagemChoice, 53
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic54:
GuiControl, HD2:Choose, StratagemChoice, 54
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic55:
GuiControl, HD2:Choose, StratagemChoice, 55
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic56:
GuiControl, HD2:Choose, StratagemChoice, 56
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic57:
GuiControl, HD2:Choose, StratagemChoice, 57
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic58:
GuiControl, HD2:Choose, StratagemChoice, 58
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic59:
GuiControl, HD2:Choose, StratagemChoice, 59
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic60:
GuiControl, HD2:Choose, StratagemChoice, 60
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic61:
GuiControl, HD2:Choose, StratagemChoice, 61
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic62:
GuiControl, HD2:Choose, StratagemChoice, 62
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic63:
GuiControl, HD2:Choose, StratagemChoice, 63
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic64:
GuiControl, HD2:Choose, StratagemChoice, 64
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic65:
GuiControl, HD2:Choose, StratagemChoice, 65
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic66:
GuiControl, HD2:Choose, StratagemChoice, 66
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic67:
GuiControl, HD2:Choose, StratagemChoice, 67
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic68:
GuiControl, HD2:Choose, StratagemChoice, 68
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic69:
GuiControl, HD2:Choose, StratagemChoice, 69
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic70:
GuiControl, HD2:Choose, StratagemChoice, 70
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic71:
GuiControl, HD2:Choose, StratagemChoice, 71
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic72:
GuiControl, HD2:Choose, StratagemChoice, 72
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic73:
GuiControl, HD2:Choose, StratagemChoice, 73
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic74:
GuiControl, HD2:Choose, StratagemChoice, 74
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic75:
GuiControl, HD2:Choose, StratagemChoice, 75
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic76:
GuiControl, HD2:Choose, StratagemChoice, 76
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic77:
GuiControl, HD2:Choose, StratagemChoice, 77
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic78:
GuiControl, HD2:Choose, StratagemChoice, 78
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic79:
GuiControl, HD2:Choose, StratagemChoice, 79
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic80:
GuiControl, HD2:Choose, StratagemChoice, 80
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic81:
GuiControl, HD2:Choose, StratagemChoice, 81
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic82:
GuiControl, HD2:Choose, StratagemChoice, 82
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic83:
GuiControl, HD2:Choose, StratagemChoice, 83
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic84:
GuiControl, HD2:Choose, StratagemChoice, 84
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic85:
GuiControl, HD2:Choose, StratagemChoice, 85
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic86:
GuiControl, HD2:Choose, StratagemChoice, 86
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic87:
GuiControl, HD2:Choose, StratagemChoice, 87
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic88:
GuiControl, HD2:Choose, StratagemChoice, 88
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic89:
GuiControl, HD2:Choose, StratagemChoice, 89
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic90:
GuiControl, HD2:Choose, StratagemChoice, 90
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic91:
GuiControl, HD2:Choose, StratagemChoice, 91
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic92:
GuiControl, HD2:Choose, StratagemChoice, 92
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic93:
GuiControl, HD2:Choose, StratagemChoice, 93
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic94:
GuiControl, HD2:Choose, StratagemChoice, 94
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic95:
GuiControl, HD2:Choose, StratagemChoice, 95
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic96:
GuiControl, HD2:Choose, StratagemChoice, 96
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic97:
GuiControl, HD2:Choose, StratagemChoice, 97
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic98:
GuiControl, HD2:Choose, StratagemChoice, 98
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic99:
GuiControl, HD2:Choose, StratagemChoice, 99
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

ChoosePic100:
GuiControl, HD2:Choose, StratagemChoice, 100
SetButton(CalledByXButton)
CalledByXButton =
gui, SelectStrat:hide
RETURN

NumPadChoice:
HideOrShow()
RETURN

LongPressChoice:
HideOrShow()
RETURN

HD2GuiClose:
ExitApp