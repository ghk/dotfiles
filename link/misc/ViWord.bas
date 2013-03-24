'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'' viWord macro version
''
'' Version: 0.6.1
'' Author: William Tan <wil@dready.org>
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' viMode
' "n" - normal
' "i" - insert
' "/" - search
' "c" - command ':'
Dim viMode

Dim CountPrefix


' PartialCmd
' "g" - goto
' "d" - delete
' "y" - yank
' "m" - mark
' "c" - change
Dim PartialCmd
Dim LastCmd
Dim PartialMovement
Dim CommandBuf
Dim SearchBuf
Dim LeaderCmd
Dim SearchDirection As Boolean
Dim SearchMatchWord As Boolean
Dim viEnabled As Boolean
Dim activeBinding As KeyBinding


Public Const spaceCSet As String = vbCrLf & vbTab & vbFormFeed & vbVerticalTab & " "

' Automatically executed when you start Word or load a global template
Sub AutoExec()
    ' viMode = "i"
    viMode = "i"
End Sub

' Each time you open an existing document
Sub AutoOpen()
    ' normalMode
End Sub

' Each time you create a new document
Sub AutoNew()
    ' normalMode
End Sub

Sub disableBinding(cat, cmd)
    For Each k In KeysBoundTo(cat, cmd)
        k.Disable
    Next k
End Sub
Sub insertMode()
    viMode = "i"
    StatusBar = "Insert mode"
End Sub

Sub RunCmd(cmd)
    Application.Run cmd
    LastCmd = cmd
End Sub

Sub RepeatCmd(count)
    If IsEmpty(LastCmd) Then Exit Sub
    
    For i = 1 To count
        Application.Run LastCmd
    Next i
End Sub


'Unbind all Vi Keys, except for ESC.
Sub unbindViKeys()
    'Always bind escape so we can return to vi mode

    StatusBar = "Unbinding keys..."
    FindKey(BuildKeyCode(wdKeyA)).Clear
    FindKey(BuildKeyCode(wdKeyB)).Clear
    FindKey(BuildKeyCode(wdKeyC)).Clear
    FindKey(BuildKeyCode(wdKeyD)).Clear
    FindKey(BuildKeyCode(wdKeyE)).Clear
    FindKey(BuildKeyCode(wdKeyF)).Clear
    FindKey(BuildKeyCode(wdKeyG)).Clear
    FindKey(BuildKeyCode(wdKeyH)).Clear
    FindKey(BuildKeyCode(wdKeyI)).Clear
    FindKey(BuildKeyCode(wdKeyJ)).Clear
    FindKey(BuildKeyCode(wdKeyK)).Clear
    FindKey(BuildKeyCode(wdKeyL)).Clear
    FindKey(BuildKeyCode(wdKeyM)).Clear
    FindKey(BuildKeyCode(wdKeyN)).Clear
    FindKey(BuildKeyCode(wdKeyO)).Clear
    FindKey(BuildKeyCode(wdKeyP)).Clear
    FindKey(BuildKeyCode(wdKeyQ)).Clear
    FindKey(BuildKeyCode(wdKeyR)).Clear
    FindKey(BuildKeyCode(wdKeyS)).Clear
    FindKey(BuildKeyCode(wdKeyT)).Clear
    FindKey(BuildKeyCode(wdKeyU)).Clear
    FindKey(BuildKeyCode(wdKeyV)).Clear
    FindKey(BuildKeyCode(wdKeyW)).Clear
    FindKey(BuildKeyCode(wdKeyX)).Clear
    FindKey(BuildKeyCode(wdKeyY)).Clear
    FindKey(BuildKeyCode(wdKeyZ)).Clear
    FindKey(BuildKeyCode(wdKey0)).Clear
    FindKey(BuildKeyCode(wdKey1)).Clear
    FindKey(BuildKeyCode(wdKey2)).Clear
    FindKey(BuildKeyCode(wdKey3)).Clear
    FindKey(BuildKeyCode(wdKey4)).Clear
    FindKey(BuildKeyCode(wdKey5)).Clear
    FindKey(BuildKeyCode(wdKey6)).Clear
    FindKey(BuildKeyCode(wdKey7)).Clear
    FindKey(BuildKeyCode(wdKey8)).Clear
    FindKey(BuildKeyCode(wdKey9)).Clear
    
    FindKey(BuildKeyCode(wdKeyShift, wdKeyA)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyB)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyC)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyD)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyE)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyF)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyG)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyH)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyI)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyJ)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyK)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyL)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyM)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyN)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyO)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyP)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyQ)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyR)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyS)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyT)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyU)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyV)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyW)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyX)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyY)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyZ)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey0)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey1)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey2)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey3)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey4)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey5)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey6)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey7)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey8)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKey9)).Clear
    
    FindKey(BuildKeyCode(wdKeyEsc)).Clear
    FindKey(BuildKeyCode(wdKeySpacebar)).Clear
    FindKey(BuildKeyCode(wdKeySemiColon)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeySemiColon)).Clear
    FindKey(BuildKeyCode(wdKeyReturn)).Clear
    FindKey(BuildKeyCode(wdKeySlash)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeySlash)).Clear
    FindKey(BuildKeyCode(wdKeyBackspace)).Clear
    FindKey(BuildKeyCode(wdKeyPeriod)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyPeriod)).Clear
    FindKey(BuildKeyCode(wdKeyHyphen)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyHyphen)).Clear
    FindKey(BuildKeyCode(wdKeySingleQuote)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeySingleQuote)).Clear
    FindKey(BuildKeyCode(wdKeyComma)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyComma)).Clear
    FindKey(BuildKeyCode(wdKeyOpenSquareBrace)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyOpenSquareBrace)).Clear
    FindKey(BuildKeyCode(wdKeyCloseSquareBrace)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyCloseSquareBrace)).Clear
    FindKey(BuildKeyCode(wdKeyBackSlash)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyBackSlash)).Clear
    FindKey(BuildKeyCode(wdKeyBackSingleQuote)).Clear
    FindKey(BuildKeyCode(wdKeyShift, wdKeyBackSingleQuote)).Clear
    
    FindKey(BuildKeyCode(wdKeyControl, wdKeyB)).Clear
    FindKey(BuildKeyCode(wdKeyControl, wdKeyF)).Clear
    FindKey(BuildKeyCode(wdKeyControl, wdKeyOpenSquareBrace)).Clear
    
    viEnabled = False
    
End Sub
Sub normalMode()

    LeaderCmd = ""
    PartialCmd = ""
    PartialMovement = ""

    If viMode = "n" Then Exit Sub
    
    viMode = "n"
    
    StatusBar = "Normal mode"
   
'   don't seem to need it anymore
'    disableBinding wdKeyCategoryMacro, "normalMode"
    If Selection.Information(wdFirstCharacterColumnNumber) > 1 Then
        Selection.MoveLeft wdCharacter, 1, wdMove
    End If

End Sub

Sub emulate()
    StatusBar = "Binding your favourite keys..."

'    CustomizationContext = ActiveDocument
    KeyBindings.Add wdKeyCategoryMacro, "key_A", BuildKeyCode(wdKeyA)
    KeyBindings.Add wdKeyCategoryMacro, "key_B", BuildKeyCode(wdKeyB)
    KeyBindings.Add wdKeyCategoryMacro, "key_C", BuildKeyCode(wdKeyC)
    KeyBindings.Add wdKeyCategoryMacro, "key_D", BuildKeyCode(wdKeyD)
    KeyBindings.Add wdKeyCategoryMacro, "key_E", BuildKeyCode(wdKeyE)
    KeyBindings.Add wdKeyCategoryMacro, "key_F", BuildKeyCode(wdKeyF)
    KeyBindings.Add wdKeyCategoryMacro, "key_G", BuildKeyCode(wdKeyG)
    KeyBindings.Add wdKeyCategoryMacro, "key_H", BuildKeyCode(wdKeyH)
    KeyBindings.Add wdKeyCategoryMacro, "key_I", BuildKeyCode(wdKeyI)
    KeyBindings.Add wdKeyCategoryMacro, "key_J", BuildKeyCode(wdKeyJ)
    KeyBindings.Add wdKeyCategoryMacro, "key_K", BuildKeyCode(wdKeyK)
    KeyBindings.Add wdKeyCategoryMacro, "key_L", BuildKeyCode(wdKeyL)
    KeyBindings.Add wdKeyCategoryMacro, "key_M", BuildKeyCode(wdKeyM)
    KeyBindings.Add wdKeyCategoryMacro, "key_N", BuildKeyCode(wdKeyN)
    KeyBindings.Add wdKeyCategoryMacro, "key_O", BuildKeyCode(wdKeyO)
    KeyBindings.Add wdKeyCategoryMacro, "key_P", BuildKeyCode(wdKeyP)
    KeyBindings.Add wdKeyCategoryMacro, "key_Q", BuildKeyCode(wdKeyQ)
    KeyBindings.Add wdKeyCategoryMacro, "key_R", BuildKeyCode(wdKeyR)
    KeyBindings.Add wdKeyCategoryMacro, "key_S", BuildKeyCode(wdKeyS)
    KeyBindings.Add wdKeyCategoryMacro, "key_T", BuildKeyCode(wdKeyT)
    KeyBindings.Add wdKeyCategoryMacro, "key_U", BuildKeyCode(wdKeyU)
    KeyBindings.Add wdKeyCategoryMacro, "key_V", BuildKeyCode(wdKeyV)
    KeyBindings.Add wdKeyCategoryMacro, "key_W", BuildKeyCode(wdKeyW)
    KeyBindings.Add wdKeyCategoryMacro, "key_X", BuildKeyCode(wdKeyX)
    KeyBindings.Add wdKeyCategoryMacro, "key_Y", BuildKeyCode(wdKeyY)
    KeyBindings.Add wdKeyCategoryMacro, "key_Z", BuildKeyCode(wdKeyZ)
    KeyBindings.Add wdKeyCategoryMacro, "key_0", BuildKeyCode(wdKey0)
    KeyBindings.Add wdKeyCategoryMacro, "key_1", BuildKeyCode(wdKey1)
    KeyBindings.Add wdKeyCategoryMacro, "key_2", BuildKeyCode(wdKey2)
    KeyBindings.Add wdKeyCategoryMacro, "key_3", BuildKeyCode(wdKey3)
    KeyBindings.Add wdKeyCategoryMacro, "key_4", BuildKeyCode(wdKey4)
    KeyBindings.Add wdKeyCategoryMacro, "key_5", BuildKeyCode(wdKey5)
    KeyBindings.Add wdKeyCategoryMacro, "key_6", BuildKeyCode(wdKey6)
    KeyBindings.Add wdKeyCategoryMacro, "key_7", BuildKeyCode(wdKey7)
    KeyBindings.Add wdKeyCategoryMacro, "key_8", BuildKeyCode(wdKey8)
    KeyBindings.Add wdKeyCategoryMacro, "key_9", BuildKeyCode(wdKey9)
    
    KeyBindings.Add wdKeyCategoryMacro, "key_s_A", BuildKeyCode(wdKeyShift, wdKeyA)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_B", BuildKeyCode(wdKeyShift, wdKeyB)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_C", BuildKeyCode(wdKeyShift, wdKeyC)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_D", BuildKeyCode(wdKeyShift, wdKeyD)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_E", BuildKeyCode(wdKeyShift, wdKeyE)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_F", BuildKeyCode(wdKeyShift, wdKeyF)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_G", BuildKeyCode(wdKeyShift, wdKeyG)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_H", BuildKeyCode(wdKeyShift, wdKeyH)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_I", BuildKeyCode(wdKeyShift, wdKeyI)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_J", BuildKeyCode(wdKeyShift, wdKeyJ)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_K", BuildKeyCode(wdKeyShift, wdKeyK)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_L", BuildKeyCode(wdKeyShift, wdKeyL)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_M", BuildKeyCode(wdKeyShift, wdKeyM)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_N", BuildKeyCode(wdKeyShift, wdKeyN)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_O", BuildKeyCode(wdKeyShift, wdKeyO)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_P", BuildKeyCode(wdKeyShift, wdKeyP)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_Q", BuildKeyCode(wdKeyShift, wdKeyQ)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_R", BuildKeyCode(wdKeyShift, wdKeyR)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_S", BuildKeyCode(wdKeyShift, wdKeyS)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_T", BuildKeyCode(wdKeyShift, wdKeyT)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_U", BuildKeyCode(wdKeyShift, wdKeyU)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_V", BuildKeyCode(wdKeyShift, wdKeyV)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_W", BuildKeyCode(wdKeyShift, wdKeyW)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_X", BuildKeyCode(wdKeyShift, wdKeyX)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_Y", BuildKeyCode(wdKeyShift, wdKeyY)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_Z", BuildKeyCode(wdKeyShift, wdKeyZ)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_0", BuildKeyCode(wdKeyShift, wdKey0)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_1", BuildKeyCode(wdKeyShift, wdKey1)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_2", BuildKeyCode(wdKeyShift, wdKey2)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_3", BuildKeyCode(wdKeyShift, wdKey3)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_4", BuildKeyCode(wdKeyShift, wdKey4)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_5", BuildKeyCode(wdKeyShift, wdKey5)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_6", BuildKeyCode(wdKeyShift, wdKey6)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_7", BuildKeyCode(wdKeyShift, wdKey7)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_8", BuildKeyCode(wdKeyShift, wdKey8)
    KeyBindings.Add wdKeyCategoryMacro, "key_s_9", BuildKeyCode(wdKeyShift, wdKey9)

    KeyBindings.Add wdKeyCategoryMacro, "key_ESC", BuildKeyCode(wdKeyEsc)
    KeyBindings.Add wdKeyCategoryMacro, "key_SPACE", BuildKeyCode(wdKeySpacebar)
    KeyBindings.Add wdKeyCategoryMacro, "key_Semicolon", BuildKeyCode(wdKeySemiColon)
    KeyBindings.Add wdKeyCategoryMacro, "key_Colon", BuildKeyCode(wdKeyShift, wdKeySemiColon)
    KeyBindings.Add wdKeyCategoryMacro, "key_ENTER", BuildKeyCode(wdKeyReturn)
    KeyBindings.Add wdKeyCategoryMacro, "key_Slash", BuildKeyCode(wdKeySlash)
    KeyBindings.Add wdKeyCategoryMacro, "key_QuestionMark", BuildKeyCode(wdKeyShift, wdKeySlash)
    KeyBindings.Add wdKeyCategoryMacro, "key_Backspace", BuildKeyCode(wdKeyBackspace)
    KeyBindings.Add wdKeyCategoryMacro, "key_Period", BuildKeyCode(wdKeyPeriod)
    KeyBindings.Add wdKeyCategoryMacro, "key_RightAngleBracket", BuildKeyCode(wdKeyShift, wdKeyPeriod)
    KeyBindings.Add wdKeyCategoryMacro, "key_Hyphen", BuildKeyCode(wdKeyHyphen)
    KeyBindings.Add wdKeyCategoryMacro, "key_Underscore", BuildKeyCode(wdKeyShift, wdKeyHyphen)
    KeyBindings.Add wdKeyCategoryMacro, "key_SingleQuote", BuildKeyCode(wdKeySingleQuote)
    KeyBindings.Add wdKeyCategoryMacro, "key_DoubleQuote", BuildKeyCode(wdKeyShift, wdKeySingleQuote)
    KeyBindings.Add wdKeyCategoryMacro, "key_Comma", BuildKeyCode(wdKeyComma)
    KeyBindings.Add wdKeyCategoryMacro, "key_LeftAngleBracket", BuildKeyCode(wdKeyShift, wdKeyComma)
    KeyBindings.Add wdKeyCategoryMacro, "key_LeftSquareBracket", BuildKeyCode(wdKeyOpenSquareBrace)
    KeyBindings.Add wdKeyCategoryMacro, "key_LeftCurlyBrace", BuildKeyCode(wdKeyShift, wdKeyOpenSquareBrace)
    KeyBindings.Add wdKeyCategoryMacro, "key_RightSquareBracket", BuildKeyCode(wdKeyCloseSquareBrace)
    KeyBindings.Add wdKeyCategoryMacro, "key_RightCurlyBrace", BuildKeyCode(wdKeyShift, wdKeyCloseSquareBrace)
    KeyBindings.Add wdKeyCategoryMacro, "key_BackSlash", BuildKeyCode(wdKeyBackSlash)
    KeyBindings.Add wdKeyCategoryMacro, "key_Pipe", BuildKeyCode(wdKeyShift, wdKeyBackSlash)
    KeyBindings.Add wdKeyCategoryMacro, "key_BackTick", BuildKeyCode(wdKeyBackSingleQuote)
    KeyBindings.Add wdKeyCategoryMacro, "key_Tilde", BuildKeyCode(wdKeyShift, wdKeyBackSingleQuote)
    KeyBindings.Add wdKeyCategoryMacro, "key_Equals", BuildKeyCode(wdKeyEquals)
    KeyBindings.Add wdKeyCategoryMacro, "key_Plus", BuildKeyCode(wdKeyShift, wdKeyEquals)

    KeyBindings.Add wdKeyCategoryMacro, "key_c_B", BuildKeyCode(wdKeyControl, wdKeyB)
    KeyBindings.Add wdKeyCategoryMacro, "key_c_B", BuildKeyCode(wdKeyControl, wdKeyU)
    KeyBindings.Add wdKeyCategoryMacro, "key_c_F", BuildKeyCode(wdKeyControl, wdKeyF)
    KeyBindings.Add wdKeyCategoryMacro, "key_c_F", BuildKeyCode(wdKeyControl, wdKeyD)
    KeyBindings.Add wdKeyCategoryMacro, "key_ESC", BuildKeyCode(wdKeyControl, wdKeyOpenSquareBrace)

    
    StatusBar = "Done"

    ' disable the default keybinding for Ctrl-R, Ctrl-K
    FindKey(BuildKeyCode(wdKeyControl, wdKeyR)).Disable
    FindKey(BuildKeyCode(wdKeyControl, wdKeyK)).Disable
    ' bind it to our functions :)
    KeyBindings.Add wdKeyCategoryMacro, "key_c_R", BuildKeyCode(wdKeyControl, wdKeyR)
    KeyBindings.Add wdKeyCategoryMacro, "key_c_K", BuildKeyCode(wdKeyControl, wdKeyK)
    
    'normalMode
    viEnabled = True
End Sub



Sub runCommand()
    If (CommandBuf = "") Then
        Exit Sub
    End If

    If (IsNumeric(CommandBuf)) Then
        Selection.GoTo wdGoToLine, wdGoToFirst, Int(Val(CommandBuf))
    ElseIf CommandBuf = "q" Then
        ActiveDocument.Close
        Exit Sub
    ElseIf CommandBuf = "qa" Then
        Application.Quit
        Exit Sub
    ElseIf CommandBuf = "q!" Then
        ' instead of using "Application.Quit wdDoNotSaveChanges" right away,
        ' which may be a bit too unforgiving, we close the current document without saving
        ' then tries to tell the app to quit, prompting to save changes if necessary
        ActiveWindow.Close wdDoNotSaveChanges
        Application.Quit
        Exit Sub
    ElseIf CommandBuf = "w" Then
        If ActiveDocument.Saved = False Then ActiveDocument.save
    ElseIf CommandBuf = "wq" Then
        If ActiveDocument.Saved = False Then ActiveDocument.save
        Application.Quit
        Exit Sub
    End If
    
    CommandBuf = ""
    normalMode
End Sub
Function commandMode()
    viMode = "c"
    StatusBar = ":" & CommandBuf
End Function
Sub searchMode()
    Dim t
    
    If SearchDirection Then
        t = "/"
    Else
        t = "?"
    End If
    
    viMode = "/"
    StatusBar = t & SearchBuf
End Sub
Sub doSearch(dir As Boolean)
    Dim found As Boolean
    
    viMode = "n"
    Selection.Find.ClearFormatting
    StatusBar = "Next match for '" & SearchBuf & "'"
    found = Selection.Find.Execute(FindText:=SearchBuf, Forward:=dir, MatchCase:=True, MatchWildcards:=(Not SearchMatchWord), MatchWholeWord:=SearchMatchWord)
    If Not found Then StatusBar = "'" & SearchBuf & "' not found!"
End Sub
Sub do_Backspace()
    Selection.TypeBackspace
End Sub

Function FlipCase(c)
    If (c >= "a" And c <= "z") Then
        FlipCase = UCase(c)
    ElseIf (c >= "A" And c <= "Z") Then
        FlipCase = LCase(c)
    Else
        FlipCase = c
    End If
End Function
Sub do_ToggleCase()
    Selection.Characters(1) = FlipCase(Selection.Characters(1))
    Selection.MoveRight wdCharacter, 1, wdMove
End Sub
Sub unbindKey(keycode)
    FindKey(keycode).Clear
End Sub
Sub rebindKey(cmd, keycode)
    KeyBindings.Add wdKeyCategoryMacro, cmd, keycode
End Sub

Sub doMovementStart(movement)
    If movement = "j" Then
        Selection.HomeKey wdLine
    ElseIf movement = "G" Then
        Selection.HomeKey wdLine
    ElseIf movement = "k" Then
        Selection.EndKey wdLine
    End If
End Sub

Sub doMovementMiddle(movement, amp)
    
    If movement = "h" Then
        Selection.MoveLeft wdCharacter, GetRepeatCount(), amp
    ElseIf movement = "l" Then
        Selection.MoveRight wdCharacter, GetRepeatCount(), amp
    ElseIf movement = "j" Then
        Selection.MoveDown wdLine, GetRepeatCount(), amp
        If amp = wdExtend And viMode = "n" Then
            Selection.MoveEnd wdCharacter
        End If
    ElseIf movement = "k" Then
        Selection.MoveUp wdLine, GetRepeatCount(), amp
    ElseIf movement = "b" Then
        Selection.MoveLeft wdWord, GetRepeatCount(), amp
    ElseIf movement = "w" Then
        Selection.MoveRight wdWord, GetRepeatCount(), amp
    ElseIf movement = "0" Then
        Selection.HomeKey wdLine, amp
    ElseIf movement = "$" Then
        Selection.EndKey wdLine, amp
    ElseIf movement = "^" Then
        Selection.EndKey wdLine, amp
    ElseIf movement = "G" Then
        If CountPrefix = "" Then
            Selection.EndKey wdStory, amp
            Selection.HomeKey wdLine, amp
        Else
            Selection.GoTo wdGoToLine, wdGoToFirst, GetRepeatCount
        End If
    ElseIf movement = "gg" Then
        Selection.HomeKey wdStory, amp
        Selection.HomeKey wdLine, amp
    ElseIf Mid$(movement, 1, 1) = "f" Then
        
        If amp = wdMove Then
            Dim moved
            moved = False
            If Selection.Characters(1) = Mid$(movement, 2, 1) Then
                Selection.MoveRight (wdCharacter)
                moved = True
            End If
            If Not Selection.MoveUntil(Mid$(movement, 2, 1)) And moved Then
                Selection.MoveLeft wdCharacter
            End If
        Else
            If Selection.MoveEndUntil(Mid$(movement, 2, 1)) Then
                Selection.MoveRight wdCharacter, 1, wdExtend
            End If
        End If
    ElseIf Mid$(movement, 1, 1) = "F" Then
        
        If amp = wdMove Then
            
            If Selection.Characters(1) = Mid$(movement, 2, 1) Then
                Selection.MoveLeft (wdCharacter)
            End If
            If Selection.MoveUntil((Mid$(movement, 2, 1)), wdBackward) Then
                Selection.MoveLeft (wdCharacter)
            End If
        Else
            If Selection.MoveStartUntil((Mid$(movement, 2, 1)), wdBackward) Then
                Selection.MoveStart wdCharacter, -1
            End If
        End If
    End If
End Sub
Sub doMovementEnd(movement)
    If movement = "j" Then
        Selection.EndKey wdLine, wdExtend
    ElseIf movement = "G" Then
        Selection.EndKey wdLine, wdExtend
    ElseIf movement = "k" Then
        Selection.HomeKey wdLine, wdExtend
    End If
    ' StatusBar = Selection.Characters(Selection.End - Selection.Start)
End Sub


Sub doMovement(movement)
    If viMode = "n" Then
        If PartialCmd <> "" Then
            If PartialCmd = "c" Or PartialCmd = "d" Or PartialCmd = "y" Then
                doMovementStart movement
                doMovementMiddle movement, wdExtend
                doMovementEnd movement
                If PartialCmd = "c" Then
                    Selection.Copy
                    Selection.Delete wdCharacter
                    insertMode
                ElseIf PartialCmd = "d" Then
                    Selection.Cut
                ElseIf PartialCmd = "y" Then
                    Selection.Copy
                    Selection.Collapse
                End If
            End If
            PartialCmd = ""
        Else
            doMovementMiddle movement, wdMove
        End If
    ElseIf viMode = "v" Then
        doMovementMiddle movement, wdExtend
    Else
        TypeChar movement
    End If
End Sub

Sub TypeChar(c)
    If Application.CapsLock Then
        c = FlipCase(c)
    End If
    
    If viMode = "i" Then
        Selection.TypeText c
    ElseIf viMode = "c" Then
        CommandBuf = CommandBuf & c
        StatusBar = ":" & CommandBuf
    ElseIf viMode = "/" Then
        SearchBuf = SearchBuf & c
        searchMode
    Else
        If (c >= "0" And c <= "9") Then
            AppendCountPrefix (c)
        End If
    End If
End Sub

Sub IncrementHeading()
    Dim sty
    Dim splittedSty
    Dim h
    sty = Selection.Paragraphs(1).Style
    splittedSty = Split(sty, " ")
    If splittedSty(0) = "Heading" Then
        h = CInt(splittedSty(1))
        If h > 1 Then
            h = h - 1
        End If
        sty = "Heading " + CStr(h)
    Else
        sty = "Heading 6"
    End If
    
    Selection.Paragraphs(1).Style = sty

End Sub
Sub DecrementHeading()
    Dim sty
    Dim splittedSty
    Dim h
    sty = Selection.Paragraphs(1).Style
    splittedSty = Split(sty, " ")
    If splittedSty(0) = "Heading" Then
        h = CInt(splittedSty(1))
        If h < 6 Then
            h = h + 1
            sty = "Heading " + CStr(h)
        Else
            sty = "Normal"
        End If
    End If
    
    Selection.Paragraphs(1).Style = sty
End Sub

Sub SelectionBold()
    Selection.Font.Bold = True
End Sub
Sub SelectionUnbold()
    Selection.Font.Bold = False
End Sub

Sub SelectionItalic()
    Selection.Font.Italic = True
End Sub
Sub SelectionUnitalic()
    Selection.Font.Italic = False
End Sub

Sub ProcessLeader(c)
    LeaderCmd = LeaderCmd + c
    If LeaderCmd = "fh" Then
        RunCmd "DecrementHeading"
        normalMode
    ElseIf LeaderCmd = "fH" Then
        RunCmd "IncrementHeading"
        normalMode
    ElseIf LeaderCmd = "fb" Then
        RunCmd "SelectionUnbold"
        normalMode
    ElseIf LeaderCmd = "fB" Then
        RunCmd "SelectionBold"
        normalMode
    ElseIf LeaderCmd = "fi" Then
        RunCmd "SelectionUnitalic"
        normalMode
    ElseIf LeaderCmd = "fI" Then
        RunCmd "SelectionItalic"
        normalMode
    End If
    
    StatusBar = "\" + LeaderCmd
End Sub


Function HandleKey(c, cmd, keycode)
    Dim isPartialCmd
    Dim isPartialMovement
    HandleKey = True
    
    If Application.FocusInMailHeader Then GoTo later
    If viMode <> "n" And viMode <> "v" Then GoTo later
    If c = "{ESC}" Or c = "^{[}" Then GoTo later
    
    isPartialCmd = False
    isPartialMovement = False
    
    If PartialCmd = "" Then
        If c = "\" Then
            PartialCmd = c + ""
            isPartialCmd = True
            StatusBar = c + ""
        End If
    ElseIf PartialCmd = "\" Then
        ProcessLeader (c)
        isPartialCmd = True
    End If
    
    If Not isPartialCmd Then
        If PartialMovement = "" Then
            If c = "f" Or c = "F" Then
                PartialMovement = c + ""
                isPartialMovement = True
            End If
        ElseIf PartialMovement = "f" Or PartialMovement = "F" Then
            doMovement (PartialMovement + c)
            PartialMovement = ""
            isPartialMovement = True
        End If
    End If
    
    
    
    If isPartialCmd Or isPartialMovement Then
        HandleKey = False
    End If
    
later:
    If Application.FocusInMailHeader Then
        HandleKey = False
        CustomizationContext = ActiveDocument
        Set k = FindKey(keycode)
        k.Disable
        SendKeys c, True
        KeyBindings.Add wdKeyCategoryMacro, cmd, keycode
    End If
End Function

Sub AppendCountPrefix(x)
    CountPrefix = CountPrefix & x
    StatusBar = "count: " & CountPrefix
End Sub
Function GetRepeatCount()
    Dim cnt
    cnt = 1
    If (CountPrefix <> "") Then
        cnt = Int(Val(CountPrefix))
    End If
    CountPrefix = ""
    GetRepeatCount = cnt
End Function
Sub key_ESC()
    If Not HandleKey("{ESC}", "key_ESC", BuildKeyCode(wdKeyEsc)) Then Exit Sub
    
    If viMode = "c" Then
        CommandBuf = ""
        PartialCmd = ""
    End If
    
    normalMode
    Selection.Collapse
    Selection.Find.ClearFormatting
End Sub
Sub key_SPACE()
    If Not HandleKey(" ", "key_SPACE", BuildKeyCode(wdKeySpacebar)) Then Exit Sub
    If viMode = "n" Then
        CommandBuf = ""
        commandMode
    Else
        TypeChar " "
    End If
End Sub
Sub key_Colon()
    If Not HandleKey(":", "key_Colon", BuildKeyCode(wdKeyShift, wdKeySemiColon)) Then Exit Sub
    If viMode = "n" Then
        CommandBuf = ""
        commandMode
    Else
        TypeChar ":"
    End If
End Sub
Sub key_ENTER()
    If Not HandleKey(vbCrLf, "key_ENTER", BuildKeyCode(wdKeyReturn)) Then Exit Sub
    If viMode = "n" Then
        Selection.MoveDown wdLine, GetRepeatCount, wdMove
    ElseIf viMode = "c" Then
        runCommand
    ElseIf viMode = "/" Then
        Selection.Collapse ' collapse the current selection, or else the search wouldn't work
        doSearch (SearchDirection)
    Else
        TypeChar vbCrLf
    End If
End Sub
Sub key_Slash()
    If Not HandleKey("/", "key_Slash", BuildKeyCode(wdKeySlash)) Then Exit Sub
    If viMode = "n" Then
        SearchDirection = True
        SearchMatchWord = False

        searchMode
    Else
        TypeChar "/"
    End If
End Sub
Sub key_QuestionMark()
    If Not HandleKey("?", "key_QuestionMark", BuildKeyCode(wdKeyShift, wdKeySlash)) Then Exit Sub
    If viMode = "n" Then
        SearchDirection = False
        SearchMatchWord = False
        searchMode
    Else
        TypeChar "?"
    End If
End Sub
Sub key_Backspace()
    If Not HandleKey("{BS}", "key_Backspace", BuildKeyCode(wdKeyBackspace)) Then Exit Sub
    
    If viMode = "n" Then
        If Len(CountPrefix) > 0 Then
            CountPrefix = Left(CountPrefix, Len(CountPrefix) - 1)
            StatusBar = "count: " & CountPrefix
        End If
    ElseIf viMode = "/" Then
        If Len(SearchBuf) > 0 Then SearchBuf = Left(SearchBuf, Len(SearchBuf) - 1)
        searchMode
    ElseIf viMode = "c" Then
        If Len(CommandBuf) > 0 Then CommandBuf = Left(CommandBuf, Len(CommandBuf) - 1)
        commandMode
    Else
        Selection.TypeBackspace
    End If
End Sub
Sub key_Period()
    If Not HandleKey(".", "key_Period", BuildKeyCode(wdKeyPeriod)) Then Exit Sub
    If viMode = "n" Then
        RepeatCmd GetRepeatCount
    Else
        TypeChar "."
    End If
End Sub
Sub key_Semicolon()
    If Not HandleKey(";", "key_Semicolon", BuildKeyCode(wdKeySemiColon)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar ";"
    End If
End Sub
Sub key_Tilde()
    If Not HandleKey("{~}", "key_Tilde", BuildKeyCode(wdKeyShift, wdKeyBackSingleQuote)) Then Exit Sub
    If viMode = "n" Then
        RepeatAction "do_ToggleCase", GetRepeatCount
    Else
        TypeChar "~"
    End If
End Sub
Sub key_BackTick()
    If Not HandleKey("`", "key_BackTick", BuildKeyCode(wdKeyBackSingleQuote)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "`"
    End If
End Sub
Sub key_RightAngleBracket()
    If Not HandleKey(">", "key_RightAngleBracket", BuildKeyCode(wdKeyShift, wdKeyPeriod)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar ">"
    End If
End Sub

Sub key_Hyphen()
    If Not HandleKey("-", "key_Hyphen", BuildKeyCode(wdKeyHyphen)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "-"
    End If
End Sub
Sub key_Underscore()
    If Not HandleKey("_", "key_Underscore", BuildKeyCode(wdKeyShift, wdKeyHyphen)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "_"
    End If
End Sub
Sub key_SingleQuote()
    If Not HandleKey("'", "key_SingleQuote", BuildKeyCode(wdKeySingleQuote)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "'"
    End If
End Sub
Sub key_DoubleQuote()
    If Not HandleKey("""", "key_DoubleQuote", BuildKeyCode(wdKeyShift, wdKeySingleQuote)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar """"
    End If
End Sub
Sub key_Comma()
    If Not HandleKey(",", "key_Comma", BuildKeyCode(wdKeyComma)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar ","
    End If
End Sub
Sub key_LeftAngleBracket()
    If Not HandleKey("<", "key_LeftAngleBracket", BuildKeyCode(wdKeyShift, wdKeyComma)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "<"
    End If
End Sub
Sub key_LeftSquareBracket()
    If Not HandleKey("{[}", "key_LeftSquareBracket", BuildKeyCode(wdKeyOpenSquareBrace)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "["
    End If
End Sub
Sub key_LeftCurlyBrace()
    If Not HandleKey("{{}", "key_LeftCurlyBrace", BuildKeyCode(wdKeyShift, wdKeyOpenSquareBrace)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "{"
    End If
End Sub
Sub key_RightSquareBracket()
    If Not HandleKey("{]}", "key_RightSquareBracket", BuildKeyCode(wdKeyCloseSquareBrace)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "]"
    End If
End Sub
Sub key_RightCurlyBrace()
    If Not HandleKey("{}}", "key_RightCurlyBrace", BuildKeyCode(wdKeyShift, wdKeyCloseSquareBrace)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "}"
    End If
End Sub
Sub key_BackSlash()
    If Not HandleKey("\", "key_BackSlash", BuildKeyCode(wdKeyBackSlash)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "\"
    End If
End Sub
Sub key_Pipe()
    If Not HandleKey("|", "key_Pipe", BuildKeyCode(wdKeyShift, wdKeyBackSlash)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "|"
    End If
End Sub
Sub key_Equals()
    If Not HandleKey("=", "key_Equals", BuildKeyCode(wdKeyEquals)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "="
    End If
End Sub
Sub key_Plus()
    If Not HandleKey("{+}", "key_Plus", BuildKeyCode(wdKeyShift, wdKeyEquals)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "+"
    End If
End Sub

Sub key_A()
    If Not HandleKey("a", "key_A", BuildKeyCode(wdKeyA)) Then Exit Sub
    If viMode = "n" Then
        ' move the cursor 1 right
        If Selection.Characters(1) <> vbCr Then
            Selection.MoveRight wdCharacter, 1, wdMove
        End If
        insertMode
    Else
        TypeChar "a"
    End If
End Sub

Sub key_B()
    If Not HandleKey("b", "key_B", BuildKeyCode(wdKeyB)) Then Exit Sub
    doMovement ("b")
End Sub

Sub key_C()
    If Not HandleKey("c", "key_C", BuildKeyCode(wdKeyC)) Then Exit Sub
    If viMode = "n" Then
        If Selection.Start <> Selection.End Then
            Selection.Cut
            insertMode
            Exit Sub
        End If
        
        If PartialCmd = "" Then
            PartialCmd = "c"
        Else
            If PartialCmd = "c" Then
                Selection.Paragraphs(1).Range.Cut
                insertMode
            End If
            PartialCmd = ""
        End If
    Else
        TypeChar "c"
    End If
End Sub
Sub key_D()
    If Not HandleKey("d", "key_D", BuildKeyCode(wdKeyD)) Then Exit Sub
    If viMode = "n" Then
        If Selection.Start <> Selection.End Then
            Selection.Cut
            Exit Sub
        End If

        If PartialCmd = "" Then
            PartialCmd = "d"
        Else
            If PartialCmd = "d" Then
                Selection.Paragraphs(1).Range.Cut
            End If
            PartialCmd = ""
        End If
    ElseIf viMode = "v" Then
        If Selection.Start <> Selection.End Then
            Selection.Cut
        End If
        normalMode
        Exit Sub
    Else
        TypeChar "d"
    End If
End Sub
Sub key_E()
    If Not HandleKey("e", "key_E", BuildKeyCode(wdKeyE)) Then Exit Sub
    If viMode = "n" Then
        'StatusBar = "char=" & ActiveWindow.Selection.Characters(1)
'        If is_space(Selection.Characters(1)) Then
'            'StatusBar = "char=" & ActiveWindow.Selection.Characters(1) & ". moving forward"
'            Selection.MoveWhile spaceCSet, wdForward
'        End If

'        pos = Selection.Words(1).End
'        If (pos < ActiveDocument.Characters.count) And is_space(ActiveDocument.Characters(pos)) Then
'            pos = pos - 1
'        End If
'        Selection.SetRange pos, pos

        Selection.Paragraphs(1).Style = "Heading 1"
    Else
        TypeChar "e"
    End If
End Sub
Sub key_F()
    If Not HandleKey("f", "key_F", BuildKeyCode(wdKeyF)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "f"
    End If
End Sub
Sub key_G()
    If Not HandleKey("g", "key_G", BuildKeyCode(wdKeyG)) Then Exit Sub
    If PartialMovement = "g" Then
        PartialMovement = ""
        doMovement ("gg")
    End If
    
    If viMode = "n" Or viMode = "v" Then
        If PartialMovement = "" Then
            PartialMovement = "g"
        End If
    Else
        TypeChar "g"
    End If
End Sub

Sub key_H()
    If Not HandleKey("h", "key_H", BuildKeyCode(wdKeyH)) Then Exit Sub
    doMovement ("h")
End Sub
Sub key_I()
    If Not HandleKey("i", "key_I", BuildKeyCode(wdKeyI)) Then Exit Sub
    If viMode = "n" Then
        insertMode
    Else
        TypeChar "i"
    End If
End Sub
Sub key_J()
    If Not HandleKey("j", "key_J", BuildKeyCode(wdKeyJ)) Then Exit Sub
    doMovement ("j")
End Sub
Sub key_K()
    If Not HandleKey("k", "key_K", BuildKeyCode(wdKeyK)) Then Exit Sub
    doMovement ("k")
End Sub
Sub key_L()
    If Not HandleKey("l", "key_L", BuildKeyCode(wdKeyL)) Then Exit Sub
    doMovement ("l")
End Sub
Sub key_M()
    If Not HandleKey("m", "key_M", BuildKeyCode(wdKeyM)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "m"
    End If
End Sub
Sub key_N()
    If Not HandleKey("n", "key_N", BuildKeyCode(wdKeyN)) Then Exit Sub
    If viMode = "n" Then
        doSearch (SearchDirection)
    Else
        TypeChar "n"
    End If
End Sub
Sub key_O()
    If Not HandleKey("o", "key_O", BuildKeyCode(wdKeyO)) Then Exit Sub
    If viMode = "n" Then
        Selection.EndKey wdLine, wdMove
        Selection.TypeText vbCrLf
        insertMode
    Else
        TypeChar "o"
    End If
End Sub
Sub key_P()
    If Not HandleKey("p", "key_P", BuildKeyCode(wdKeyP)) Then Exit Sub
    If viMode = "n" Then
        If Selection.Characters(1) <> vbCrLf Then
            ' move to next character before pasting, like vi would
            Selection.Move wdCharacter, 1
            Selection.Paste
            ' move back a step (just like vi)
            Selection.Move wdCharacter, -1
        Else
            ' normal, just paste
            Selection.Paste
        End If
    Else
        TypeChar "p"
    End If
End Sub
Sub key_Q()
    If Not HandleKey("q", "key_Q", BuildKeyCode(wdKeyQ)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "q"
    End If
End Sub
Sub key_R()
    If Not HandleKey("r", "key_R", BuildKeyCode(wdKeyR)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "r"
    End If
End Sub
Sub key_S()
    If Not HandleKey("s", "key_S", BuildKeyCode(wdKeyS)) Then Exit Sub
    If viMode = "n" Then
        Selection.Delete wdCharacter, GetRepeatCount
        insertMode
    Else
        TypeChar "s"
    End If
End Sub
Sub key_T()
    If Not HandleKey("t", "key_T", BuildKeyCode(wdKeyT)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "t"
    End If
End Sub
Sub key_U()
    If Not HandleKey("u", "key_U", BuildKeyCode(wdKeyU)) Then Exit Sub
    If viMode = "n" Then
        ActiveDocument.Undo 1
    Else
        TypeChar "u"
    End If
End Sub
Sub key_V()
    If Not HandleKey("v", "key_V", BuildKeyCode(wdKeyV)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "v"
    Else
        viMode = "v"
    End If
End Sub
Sub key_W()
    If Not HandleKey("w", "key_W", BuildKeyCode(wdKeyW)) Then Exit Sub
    doMovement ("w")
End Sub
Sub key_X()
    If Not HandleKey("x", "key_X", BuildKeyCode(wdKeyX)) Then Exit Sub
    If viMode = "n" Then
        cnt = GetRepeatCount
        ' To overcome the problem of Word being a smartass when the
        ' cursor is between a punctuation and space (it re-inserts
        ' a space right after you delete it)
        
        ' first, select the number of characters and copy onto clipboard
        Selection.MoveEnd wdCharacter, cnt
        Selection.Copy

        ' collapse the selection to the right then delete left from there
        Selection.Collapse wdCollapseEnd
        RepeatAction "do_Backspace", cnt
    Else
        TypeChar "x"
    End If
End Sub
Sub key_Y()
    If Not HandleKey("y", "key_Y", BuildKeyCode(wdKeyY)) Then Exit Sub
    If viMode = "n" Then
        If Selection.Start <> Selection.End Then
            Selection.Copy
            Exit Sub
        End If

        If PartialCmd = "" Then
            PartialCmd = "y"
        Else
            If PartialCmd = "y" Then
                Selection.Paragraphs(1).Range.Copy
            End If
            PartialCmd = ""
        End If
    ElseIf viMode = "v" Then
        If Selection.Start <> Selection.End Then
            Selection.Copy
        End If
        
        normalMode
        Exit Sub
    Else
        TypeChar "y"
    End If
End Sub
Sub key_Z()
    If Not HandleKey("z", "key_Z", BuildKeyCode(wdKeyZ)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "z"
    End If
End Sub
Sub key_0()
    If Not HandleKey("0", "key_0", BuildKeyCode(wdKey0)) Then Exit Sub
    If CountPrefix = "" Then
        doMovement ("0")
    ElseIf viMode = "n" Then
        AppendCountPrefix ("0")
    Else
        TypeChar "0"
    End If
End Sub
Sub key_1()
    If Not HandleKey("1", "key_1", BuildKeyCode(wdKey1)) Then Exit Sub
    TypeChar "1"
End Sub
Sub key_2()
    If Not HandleKey("2", "key_2", BuildKeyCode(wdKey2)) Then Exit Sub
    TypeChar "2"
End Sub
Sub key_3()
    If Not HandleKey("3", "key_3", BuildKeyCode(wdKey3)) Then Exit Sub
    TypeChar "3"
End Sub
Sub key_4()
    If Not HandleKey("4", "key_4", BuildKeyCode(wdKey4)) Then Exit Sub
    TypeChar "4"
End Sub
Sub key_5()
    If Not HandleKey("5", "key_5", BuildKeyCode(wdKey5)) Then Exit Sub
    TypeChar "5"
End Sub
Sub key_6()
    If Not HandleKey("6", "key_6", BuildKeyCode(wdKey6)) Then Exit Sub
    TypeChar "6"
End Sub
Sub key_7()
    If Not HandleKey("7", "key_7", BuildKeyCode(wdKey7)) Then Exit Sub
    TypeChar "7"
End Sub
Sub key_8()
    If Not HandleKey("8", "key_8", BuildKeyCode(wdKey8)) Then Exit Sub
    TypeChar "8"
End Sub
Sub key_9()
    If Not HandleKey("9", "key_9", BuildKeyCode(wdKey9)) Then Exit Sub
    TypeChar "9"
End Sub
Sub key_s_A()
    If Not HandleKey("A", "key_s_A", BuildKeyCode(wdKeyShift, wdKeyA)) Then Exit Sub
    If viMode = "n" Then
        ' if the character to my right is vbCr, do not move an inch!
        If Selection.Characters(1) <> vbCr Then
            ' if we are at the start of a paragraph, we need to inch forward a bit, otherwise the EndOf function will refuse to move
            If Selection.Paragraphs(1).Range.Start = Selection.Start Then
                Selection.Move wdCharacter, 1
            End If
            Selection.EndOf wdParagraph, wdMove
            
            ' this usually moves us to the position after the newline, so reverse a bit
            Dim r As Range
            Set r = Selection.Range
            r.SetRange Selection.Start - 1, Selection.Start - 1
            
            If r.Characters(1) = vbCr Then
                Selection.Move wdCharacter, -1
            End If
        End If

        insertMode
    Else
        TypeChar "A"
    End If
End Sub
Sub key_s_B()
    If Not HandleKey("B", "key_s_B", BuildKeyCode(wdKeyShift, wdKeyB)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "B"
    End If
End Sub
' C - cut to the end of line
Sub key_s_C()
    If Not HandleKey("C", "key_s_C", BuildKeyCode(wdKeyShift, wdKeyC)) Then Exit Sub
    If viMode = "n" Then
        ' move to the end of line, but back one character so that we don't delete the end-of-line
        Selection.MoveEnd wdParagraph, 1
        Selection.MoveEnd wdCharacter, -1
        Selection.Cut
        insertMode
    Else
        TypeChar "C"
    End If
End Sub
Sub key_s_D()
    If Not HandleKey("D", "key_s_D", BuildKeyCode(wdKeyShift, wdKeyD)) Then Exit Sub
    If viMode = "n" Then
        ' similar to |C| but do not go into insert mode
        Selection.MoveEnd wdLine, 1
        Selection.MoveEnd wdCharacter, -1
        Selection.Cut
    Else
        TypeChar "D"
    End If
End Sub
Sub key_s_E()
    If Not HandleKey("E", "key_s_E", BuildKeyCode(wdKeyShift, wdKeyE)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "E"
    End If
End Sub
Sub key_s_F()
    If Not HandleKey("F", "key_s_F", BuildKeyCode(wdKeyShift, wdKeyF)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "F"
    End If
End Sub
Sub key_s_G()
    If Not HandleKey("G", "key_s_G", BuildKeyCode(wdKeyShift, wdKeyG)) Then Exit Sub
    doMovement ("G")
End Sub
Sub key_s_H()
    If Not HandleKey("H", "key_s_H", BuildKeyCode(wdKeyShift, wdKeyH)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "H"
    End If
End Sub
Sub key_s_I()
    If Not HandleKey("I", "key_s_I", BuildKeyCode(wdKeyShift, wdKeyI)) Then Exit Sub
    If viMode = "n" Then
        Selection.HomeKey wdLine, wdMove
        insertMode
    Else
        TypeChar "I"
    End If
End Sub
Sub key_s_J()
    If Not HandleKey("J", "key_s_J", BuildKeyCode(wdKeyShift, wdKeyJ)) Then Exit Sub
    If viMode = "n" Then
        x = Selection.MoveUntil(vbCrLf)
        If x <> 0 Then
            Selection.Delete wdCharacter, 1
        End If
    Else
        TypeChar "J"
    End If
End Sub
Sub key_s_K()
    If Not HandleKey("K", "key_s_K", BuildKeyCode(wdKeyShift, wdKeyK)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "K"
    End If
End Sub
Sub key_s_L()
    If Not HandleKey("L", "key_s_L", BuildKeyCode(wdKeyShift, wdKeyL)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "L"
    End If
End Sub
Sub key_s_M()
    If Not HandleKey("M", "key_s_M", BuildKeyCode(wdKeyShift, wdKeyM)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "M"
    End If
End Sub
Sub key_s_N()
    If Not HandleKey("N", "key_s_N", BuildKeyCode(wdKeyShift, wdKeyN)) Then Exit Sub
    If viMode = "n" Then
        doSearch (Not SearchDirection)
    Else
        TypeChar "N"
    End If
End Sub
Sub key_s_O()
    If Not HandleKey("O", "key_s_O", BuildKeyCode(wdKeyShift, wdKeyO)) Then Exit Sub
    If viMode = "n" Then
        Selection.HomeKey wdLine, wdMove
        Selection.TypeText vbCrLf
        Selection.MoveUp wdLine, 1, wdMove
        insertMode
    Else
        TypeChar "O"
    End If
End Sub
Sub key_s_P()
    If Not HandleKey("P", "key_s_P", BuildKeyCode(wdKeyShift, wdKeyP)) Then Exit Sub
    If viMode = "n" Then
        Selection.Paste
    Else
        TypeChar "P"
    End If
End Sub
Sub key_s_Q()
    If Not HandleKey("Q", "key_s_Q", BuildKeyCode(wdKeyShift, wdKeyQ)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "Q"
    End If
End Sub
Sub key_s_R()
    If Not HandleKey("R", "key_s_R", BuildKeyCode(wdKeyShift, wdKeyR)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "R"
    End If
End Sub
Sub key_s_S()
    If Not HandleKey("S", "key_s_S", BuildKeyCode(wdKeyShift, wdKeyS)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "S"
    End If
End Sub
Sub key_s_T()
    If Not HandleKey("T", "key_s_T", BuildKeyCode(wdKeyShift, wdKeyT)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "T"
    End If
End Sub
Sub key_s_U()
    If Not HandleKey("U", "key_s_U", BuildKeyCode(wdKeyShift, wdKeyU)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "U"
    End If
End Sub
Sub key_s_V()
    If Not HandleKey("V", "key_s_V", BuildKeyCode(wdKeyShift, wdKeyV)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "V"
    Else
        viMode = "V"
    End If
End Sub
Sub key_s_W()
    If Not HandleKey("W", "key_s_W", BuildKeyCode(wdKeyShift, wdKeyW)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "W"
    End If
End Sub
Sub key_s_X()
    If Not HandleKey("X", "key_s_X", BuildKeyCode(wdKeyShift, wdKeyX)) Then Exit Sub
    If viMode = "n" Then
        RepeatAction "do_Backspace", GetRepeatCount
    Else
        TypeChar "X"
    End If
End Sub
Sub key_s_Y()
    If Not HandleKey("Y", "key_s_Y", BuildKeyCode(wdKeyShift, wdKeyY)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "Y"
    End If
End Sub
Sub key_s_Z()
    If Not HandleKey("Z", "key_s_Z", BuildKeyCode(wdKeyShift, wdKeyZ)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "Z"
    End If
End Sub
Sub key_s_0()
    If Not HandleKey("{)}", "key_s_0", BuildKeyCode(wdKeyShift, wdKey0)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar ")"
    End If
End Sub
Sub key_s_1()
    If Not HandleKey("!", "key_s_1", BuildKeyCode(wdKeyShift, wdKey1)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "!"
    End If
End Sub
Sub key_s_2()
    If Not HandleKey("@", "key_s_2", BuildKeyCode(wdKeyShift, wdKey2)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "@"
    End If
End Sub
Sub key_s_3()
    If Not HandleKey("#", "key_s_3", BuildKeyCode(wdKeyShift, wdKey3)) Then Exit Sub
    If viMode = "n" Then
        SearchDirection = False
        SearchMatchWord = True
        SearchBuf = Selection.Words(1).Text
        If Right(SearchBuf, 1) = " " Then SearchBuf = Left(SearchBuf, Len(SearchBuf) - 1)
        searchMode
        doSearch (SearchDirection)
    Else
        TypeChar "#"
    End If
End Sub
Sub key_s_4()
    If Not HandleKey("$", "key_s_4", BuildKeyCode(wdKeyShift, wdKey4)) Then Exit Sub
    doMovement ("$")
End Sub
Sub key_s_5()
    If Not HandleKey("{%}", "key_s_5", BuildKeyCode(wdKeyShift, wdKey5)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "%"
    End If
End Sub
Sub key_s_6()
    If Not HandleKey("{^}", "key_s_6", BuildKeyCode(wdKeyShift, wdKey6)) Then Exit Sub
    doMovement ("^")
End Sub
Sub key_s_7()
    If Not HandleKey("&", "key_s_7", BuildKeyCode(wdKeyShift, wdKey7)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "&"
    End If
End Sub
Sub key_s_8()
    If Not HandleKey("*", "key_s_8", BuildKeyCode(wdKeyShift, wdKey8)) Then Exit Sub
    If viMode = "n" Then
        SearchDirection = True
        SearchMatchWord = True

        SearchBuf = Selection.Words(1).Text
        If Right(SearchBuf, 1) = " " Then SearchBuf = Left(SearchBuf, Len(SearchBuf) - 1)
        searchMode
        doSearch (SearchDirection)
    Else
        TypeChar "*"
    End If
End Sub
Sub key_s_9()
    If Not HandleKey("{(}", "key_s_9", BuildKeyCode(wdKeyShift, wdKey9)) Then Exit Sub
    If viMode <> "n" Then
        TypeChar "("
    End If
End Sub
Sub key_c_B()
    If Not HandleKey("^b", "key_c_B", BuildKeyCode(wdKeyControl, wdKeyB)) Then Exit Sub
    If viMode = "n" Then
        Selection.MoveUp wdScreen, GetRepeatCount
    End If
End Sub
Sub key_c_F()
    If Not HandleKey("^f", "key_c_F", BuildKeyCode(wdKeyControl, wdKeyF)) Then Exit Sub
    If viMode = "n" Then
        Selection.MoveDown wdScreen, GetRepeatCount
    End If
End Sub

Sub key_c_R()
    If Not HandleKey("^r", "key_c_R", BuildKeyCode(wdKeyControl, wdKeyR)) Then Exit Sub
    If viMode = "n" Then
        ActiveDocument.Redo GetRepeatCount
    End If
End Sub
Sub key_c_K()
    If Not HandleKey("^k", "key_c_K", BuildKeyCode(wdKeyControl, wdKeyK)) Then Exit Sub
    If viMode = "n" And viEnabled = True Then
        unbindViKeys
    ElseIf viEnabled = False Then
        emulate
    End If
End Sub

Sub RepeatAction(func, count)
    Dim i
    For i = 1 To count
        Application.Run func
    Next i
End Sub

Function is_space(c)
    If c = Chr(7) Or c = Chr(10) Or c = Chr(13) Or c = Chr(160) Or c = Chr(176) Or c = Chr(182) Or c = vbCrLf Or c = vbTab Or c = vbCr Or c = vbLf Or c = Chr(32) Then
        is_space = True
    Else
        is_space = False
    End If
End Function
