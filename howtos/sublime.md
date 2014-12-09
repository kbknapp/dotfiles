# Sublime Text

## Files
Close File 
PC `^W`
Mac `Cmd + W`

Open Recent File 
PC `^Shift + T`
Mac `Cmd + Shift + T`

Switch to Numbered Tab 
PC `Alt + #` 
Mac `CMD + #`

Cycle Tabs
PC `^PgUp | PgDown`
PC `^Tab`
Mac `Cmd + Shift + [ | ]` 
Mac `Cmd + Opt + Left | Right`
Mac `Cmd + Tab`

**Note**: `^Tab` Moves backwards through most recent tabs

Goto Tab (Can use Fuzzy Typing)
PC `^P`
Mac `Cmd + P`

## Editing
Indenting paragraphs
PC `^[ | ]`
Mac `Cmd + [ | ]`

Jump to matching bracket
Place cursor on bracket, `^M`

Jump to split
`^#`

Switch Projects
PC `^Alt + P`
Mac `^Cmd + P`

## Search / Find and Replace
Search File
PC `^F`
Mac `Cmd + F`

Search History
PC `^F, Up | Down`
Mac `Cmd + F, Up | Down`

Incremental Search (Used for navigation)
PC `^I`
Mac `Cmd + I`

Repace
PC `^H`
Mac `Cmd + Opt + F`

Replace Where
PC `^Shift + F`
Mac `Cmd + Shift + F`

Cyle Find Results
After find, `F4`

## Selections and Moving
Move one word at a time
`Alt + Left | Right`

Select one word at a time
`Alt + Shift + Left | Right`

Select current word
PC `^D`
Mac `Cmd + D`

Select Line
PC `^L`
Mac `Cmd + L`

Select inside brackets
`^Shift + M`

Select inside indentation
PC `^Shift + J`
Mac `Cmd + Shift + J`

Select Visual Scope (Syntax Highlighting)
PC `^Shift + Space`
Mac `Cmd + Shift + Space`

Select Inside Tag
PC `^Shift + A`
Mac `Cmd + Shift + A`

## Transpose and Swap
Swap Char or Word
`^T`

Swap Line
PC `^Shift + Up | Down`
Mac `Cmd + Shift + Up | Down`

## Bookmarks
Bookmark Selection or Cursor Point
PC `^F2`
Mac `Cmd + F2`

Return to Bookmark
`F2`

## Goto Anything
Open Goto Anything Prompt
PC `^P`
Mac `Cmd + P`

Fuzzy Match Mode
`#`

ID Tag Mode
`@`

Line Number Mode
`:`

Cancel (i.e. peek)
`Esc`

Open File at Match
`Enter`

## Command Pallete
Open Prompt
PC `^Shift + P`
Mac `Cmd + Shift + P`

## Multiple Selection
Add Cursors
PC `^Click`
Mac `Cmd + Click`

Add Next or Previous Line
PC `^Alt + Up | Down`
Mac `^Shift + Up | Down`

Split Selection into Lines
PC `^Shift + L`
Mac `Cmd + Shift + L`

Select Next Occurance of Word
PC `^D`
Mac `Cmd + D`

Skip Occurance of Word
PC `^K`
Mac `Cmd + K`

Undo Last Selection
PC `^U`
Mac `Cmd + U`

## Vintage Mode
Enable Vintage Mode
Inside User Settings
```
{
	"ignored_packages": []
}
```

Start in Command Mode
Inside User Settings, add
```
{
	"vintage_start_in_command_mode": true
}
```

## Auto Complete
Open Auto Complete List
`^Space`

Set Accept Auto Complete Suggestion on Tab
Inside User Settings, add
```
{
	"auto_complete_commit_on_tab": true
}
```

## Macros
Start or Stop recoding Macro
`^Q`

Playback Macro
`^Shift + Q`

Add Keyboard Shortcut to custom macro
Inside User Keybindings, add
```
// Adds ^; as macro invoking keybinding
[
	{
    	"keys": ["ctrl+;"],
    	"command": "run_macro_file",
    	"args": {"file": "Packages/User/mymacro.subline-macro"}
    }
]
```
