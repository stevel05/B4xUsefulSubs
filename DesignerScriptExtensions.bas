B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
Sub Class_Globals
	Private XUi As XUI
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'B4j
'Parameters: ClassNames As String (Comma delimited), 1 or more Views comma delimited
'Designer Script : DSE_CSSStyleClass.AddStyleClass("button-sl",Button1,Button2,Button3)
Public Sub AddStyleClass(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim ClassNames() As String = Regex.Split(",",DesignerArgs.Arguments.Get(0))
		For i = 1 To DesignerArgs.Arguments.Size - 1
			Dim V As Node = DesignerArgs.GetViewFromArgs(i)
			For Each ClassName As String In ClassNames
				ClassName = ClassName.Trim
				If V.StyleClasses.IndexOf(ClassName) = -1 Then
					V.StyleClasses.Add(ClassName)
				End If
			Next
		Next
	End If
End Sub


'B4j
'Parameters: Type As String, 1 or more Labels (Comma delimited)
'Type : One Of - CENTER_ELLIPSIS, CENTER_WORD_ELLIPSIS, CLIP, ELLIPSIS, LEADING_ELLIPSIS, LEADING_WORD_ELLIPSIS, WORD_ELLIPSIS
'Designer Script : {Class}.SetLabelTextOverrun("CENTER_ELLIPSIS",Label2)
Public Sub SetLabelTextOverrun(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim TType As String = DesignerArgs.Arguments.Get(0)
		For i = 1 To DesignerArgs.Arguments.Size - 1
			Dim JO As JavaObject = DesignerArgs.GetViewFromArgs(i)
			JO.Runmethod("setTextOverrun",Array(TType))
		Next
	End If
End Sub

'B4j
'Forum Post https://www.b4x.com/android/forum/threads/b4j-dse-add-a-pane-with-layout-to-a-tooltip.151203/#content

'Parameters: Target As B4xView, LayoutName As String, AnchorLocation As String, PaneWidth As Double, PaneHeight as Double
'DesignerScript: {Classname}.SetPaneOnTooltip(Button1,"layoutname","CONTENT_TOP_RIGHT",120,100 )
'ContentDisplay Should be one of: CONTENT_BOTTOM_LEFT, CONTENT_BOTTOM_RIGHT, CONTENT_TOP_LEFT, CONTENT_TOP_RIGHT,
'WINDOW_BOTTOM_LEFT, WINDOW_BOTTOM_RIGHT, WINDOW_TOP_LEFT, WINDOW_TOP_RIGHT or empty string for default
Public Sub SetPaneOnTooltip(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim Target As JavaObject = DesignerArgs.GetViewFromArgs(0)
		Dim LayoutName As String = DesignerArgs.Arguments.Get(1)
		Dim AnchorLocation As String = DesignerArgs.Arguments.Get(2)
		Dim Width As Double = DesignerArgs.Arguments.Get(3)
		Dim Height As Double = DesignerArgs.Arguments.Get(4)
    
		Dim P As B4XView = XUi.CreatePanel("")
		P.SetLayoutAnimated(0,0,0,Width,Height)
		P.LoadLayout(LayoutName)
		Dim TT As JavaObject
		TT.InitializeNewInstance("javafx.scene.control.Tooltip",Null)
		TT.RunMethod("setGraphic",Array(P))
		If AnchorLocation <> "" Then TT.RunMethod("setAnchorLocation",Array(AnchorLocation.ToUpperCase))
		Target.As(JavaObject).RunMethod("setTooltip",Array(TT))
 
	End If
End Sub


'B4j
'Forum post https://www.b4x.com/android/forum/threads/dse-settogglegroup-radiobutton-togglebutton.143089/#content

'Parameters: SelectedIndex as Int, 2 or more RadioButtons or ToggleButtons
'DesignerScript: {Class}.SetToggleGroup(0,RadioButton1,Radiobutton2)
Public Sub SetToggleGroup(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim SelectedIndex As Int = DesignerArgs.Arguments.Get(0)
		Dim RBG As JavaObject
		RBG.InitializeNewInstance("javafx.scene.control.ToggleGroup",Null)
 
		For i = 1 To DesignerArgs.Arguments.Size - 1
			Dim RB As JavaObject = DesignerArgs.GetViewFromArgs(i)
			RB.RunMethod("setToggleGroup",Array(RBG))
		Next
 
		If SelectedIndex < 0 Or SelectedIndex > DesignerArgs.Arguments.Size - 2 Then
			SelectedIndex = 0
		End If
		DesignerArgs.GetViewFromArgs(SelectedIndex + 1).As(JavaObject).RunMethod("setSelected",Array(True))
	End If
End Sub

'B4j
'Parameters: Size As Int, 1 or more Views (Comma delimited)
'Designer Script : {Class}.SetTooltipTextSize(14,btn1,btn2)
Public Sub SetTooltipTextSize(DesignerArgs As DesignerArgs)
	If DesignerArgs.FirstRun Then
		Dim Size As Double = DesignerArgs.Arguments.Get(0)
		Dim F As B4XFont = XUi.CreateFont( DesignerArgs.GetViewFromArgs(1).As(B4XView).Font,Size)
      
		For i = 1 To DesignerArgs.Arguments.Size - 1
			Dim V As B4XView = DesignerArgs.GetViewFromArgs(i)
			Dim TT As JavaObject = V.As(JavaObject).RunMethod("getTooltip",Null)
			TT.Runmethod("setFont",Array(F))
		Next
	End If
End Sub

'B4a
'Forum post  https://www.b4x.com/android/forum/threads/dse-b4a-standard-tooltips-for-android-8.143481/#content
'Based on code from Dave O
'Forum post https://www.b4x.com/android/forum/threads/standard-tooltips-for-android-8.143440/

'Parameters: Text As String, 1 view
'Code in DesignerScript:{class}.SetTooltip("Tooltip", Button1)
Public Sub SetTooltip(DesignerArgs As DesignerArgs)
	#if B4a
	Dim p As Phone
	If p.SdkVersion >= 26 Then
		Dim Text As String = DesignerArgs.Arguments.Get(0)
		Dim viewJO As JavaObject = DesignerArgs.GetViewFromArgs(1)
		viewJO.RunMethod("setOnLongClickListener", Array As Object(Null))   'remove any longClick listener
		viewJO.RunMethod("setTooltip", Array As Object(Text))
	End If
	#End If
End Sub