B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10.2
@EndOfDesignText@
'Static code module
Sub Process_Globals

End Sub

'B4a / B4j
Public Sub GetStringCharNames(Str As String) As String
	Return GetStringCharNames2(Str,"")
End Sub

Public Sub GetStringCharNames2(Str As String, Header As String) As String
	Dim SB As StringBuilder
	SB.Initialize
	SB.Append(" ")
	SB.Append(CRLF)
	SB.Append("***** GetStringCharNames *****")
	SB.Append(CRLF)
	If Header <> "" Then
		SB.Append($"*** ${Header} ***"$)
		SB.Append(CRLF)
	End If
	SB.Append("___________________________")
	SB.Append(CRLF)
	SB.Append(Str & " Length : " & Str.Length)
	SB.Append(CRLF)
	SB.Append("___________________________")
	SB.Append(CRLF)
	For i = 0 To Str.Length - 1
		SB.Append(i & " : " & Str.CharAt(i) & " : " & Asc(Str.CharAt(i)) & " : " & GetCharName(Str.CharAt(i)))
		SB.Append(CRLF)
	Next
	SB.Append("___________________________")
	SB.Append(CRLF)
	SB.Append("***** Done *****")
	SB.Append(CRLF)
	SB.Append(" ")
	SB.Append(CRLF)
	Return SB.ToString
End Sub

Public Sub GetCharName(C As Char) As String
	Dim Character As JavaObject
	Character.InitializeStatic("java.lang.Character")
	Dim Name As Object = Character.RunMethod("getName",Array(Asc(C)))
	If Name = Null Then
		Return "Undefined"
	End If
	Return Name
End Sub




Public Sub Top(S As String, Lines As Int) As String
	Return TopHeader(S, Lines, "")
End Sub

Public Sub TopHeader(S As String, Lines As Int, Header As String) As String
	Dim Sb As StringBuilder
	Sb.Initialize
	Dim L As List = Regex.Split(CRLF,S)
	If Header <> "" Then
		Sb.Append($"*** Top: "${Header}" - ${Lines}***"$)
		Sb.Append(CRLF)
	End If
	For i = 0 To Min(Lines - 1, L.Size - 1)
		Sb.Append(L.Get(i))
		Sb.Append(CRLF)
	Next
	Return Sb.ToString
End Sub


'B4a / B4j
Public Sub GetStackTrace(FromSubName As String,Limit As Int) As String
	Dim StackTrace() As Object
	Dim Throwable As JavaObject
	Dim i As Int = 0
	Dim Found As Boolean = False
	Dim JO As JavaObject
 
	Dim SB As StringBuilder
	SB.Initialize
 
	'Initialize a new throwable from which to get the stacktrace
	Throwable.InitializeNewInstance("java.lang.Throwable",Null)
 
	'Get the stacktrace into an Object Array
	StackTrace = Throwable.RunMethod("getStackTrace",Null)
 
	'Check if list all is requested
	If Limit = -1 Then Limit = StackTrace.Length - 1
 
	SB.Append("Log Stack Trace ###############################")
	SB.Append(CRLF)
	If FromSubName <> "" Then
		SB.Append("From Sub: " & FromSubName)
		SB.Append(CRLF)
	End If
	SB.Append(" ")
 
	'Check if we only want to Log items before the named sub
	If FromSubName <> "" Then
		For i = 0 To StackTrace.Length - 1
			JO = StackTrace(i)
			Dim S As String = JO.RunMethod("toString",Null)
			If S.Contains("._" & FromSubName.ToLowerCase) Then
				Found = True
				i = i + 1
				i = i + 1
				Exit
			End If
		Next
		If Not(Found) Then
			SB.Append("Sub " & FromSubName & " Not found in stacktrace #######################")
			SB.Append(CRLF)
			Return SB.ToString
		End If
	End If
 
	'Make sure there are enough items in the stacktrace so that the requested Limit will not cause an Out of bounds error otherwise just show all items.
	If i + Limit >= StackTrace.Length Then Limit = StackTrace.Length - i
 
	'Log the required stacktrace items
	For j = i To i + Limit - 1
		JO = StackTrace(j)
		SB.Append(JO.RunMethod("toString",Null))
		SB.Append(CRLF)
	Next
	SB.Append(" ")
	SB.Append(CRLF)
	SB.Append((j - i) & " items Listed #######################")
	SB.Append(CRLF)
	Return SB.ToString
End Sub