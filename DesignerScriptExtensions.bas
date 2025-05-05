B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10.2
@EndOfDesignText@
Sub Class_Globals
	Private fx As JFX
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize
	
End Sub

'B4j Only
'Forum post https://www.b4x.com/android/forum/threads/dse-settogglegroup-radiobutton-togglebutton.143089/#content

'Parameters: SelectedIndex as Int, 2 or more RadioButtons or ToggleButtons
'DesignerScript: {Class}.SetToggleGroup(0,RadioButton1,Radiobutton2)
Public Sub SetToggleGroup(DesignerArgs As DesignerArgs)
 
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
 
End Sub