B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

'Joins an array or list of strings with Delimeters in between
Public Sub StringJoin(Delim As String, Source As Object) As String
	Dim Str As JavaObject
	Str.InitializeNewInstance("java.lang.String",Null)
	Return Str.RunMethod("join",Array(Delim, Source))
End Sub