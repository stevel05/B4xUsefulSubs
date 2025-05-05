B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

'Forum Post
'https://www.b4x.com/android/forum/threads/count-sub-strings.58124/#content
Public Sub StringCount(StringToSearch As String,TargetStr As String,IgnoreCase As Boolean) As Int
	If IgnoreCase Then
		StringToSearch = StringToSearch.ToLowerCase
		TargetStr = TargetStr.ToLowerCase
	End If

	Return (StringToSearch.Length - StringToSearch.Replace(TargetStr,"").Length) / TargetStr.Length

End Sub

'Joins an array or list of strings with Delimeters in between
Public Sub StringJoin(Delim As String, Source As Object) As String
	Dim Str As JavaObject
	Str.InitializeNewInstance("java.lang.String",Null)
	Return Str.RunMethod("join",Array(Delim, Source))
End Sub

'Capitalize first character of each Space separated word
Public Sub ToProperCase(Str As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	
	For Each Word As String In Regex.Split(" ",Str)
		SB.Append(" ")
		SB.Append(Word.CharAt(0).As(String).ToUpperCase & Word.SubString(1).ToLowerCase)
	Next
	Return SB.ToString.SubString(1)
End Sub

