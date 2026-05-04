' ============================================================
' Extract_TongueDrum_Dimensions_AllConfigs.bas
' ------------------------------------------------------------
' Walks every configuration in the active SolidWorks assembly,
' opens every top-level component, and dumps dimensions, global
' variables, and equations to one CSV next to the assembly.
'
' Output columns:
'   AssemblyConfigName, Component, ComponentConfigName,
'   FeatureName, FeatureType, DimFullName, Value_mm, Value_in,
'   Tolerance_Type, IsDriven, IsLinked, IsGlobalVar,
'   EquationOrComment
'
' Notes:
'   - Designed for TNG-000_TongueDrum.SLDASM, but works on any
'     active assembly.
'   - Read-only walk; it switches configurations and rebuilds,
'     but does not edit geometry or equations.
'   - Processes each unique component path + referenced config
'     per assembly config, so design-table-driven parts are not
'     accidentally deduped away.
' ============================================================

Option Explicit

Dim swApp           As SldWorks.SldWorks
Dim swTopModel      As SldWorks.ModelDoc2
Dim swTopAssy       As SldWorks.AssemblyDoc
Dim outFileNum      As Integer
Dim seenKeys        As Object   ' Scripting.Dictionary
Dim rowsWritten     As Long

Sub main()
    Set swApp = Application.SldWorks
    Set swTopModel = swApp.ActiveDoc

    If swTopModel Is Nothing Then
        MsgBox "Open the tongue drum assembly first.", vbExclamation
        Exit Sub
    End If

    If swTopModel.GetType <> swDocASSEMBLY Then
        MsgBox "Active doc is not an assembly. Open the .SLDASM and try again.", vbExclamation
        Exit Sub
    End If

    Set swTopAssy = swTopModel
    Set seenKeys = CreateObject("Scripting.Dictionary")
    rowsWritten = 0

    Dim asmPath As String
    asmPath = swTopModel.GetPathName
    If Len(asmPath) = 0 Then
        MsgBox "Save the assembly before running this macro so the CSV has a folder to write to.", vbExclamation
        Exit Sub
    End If

    Dim basePath As String
    basePath = Left$(asmPath, InStrRev(asmPath, ".") - 1)

    Dim outPath As String
    outPath = basePath & "_ALL_CONFIGS_dimensions.csv"

    Dim originalConfig As String
    originalConfig = swTopModel.ConfigurationManager.ActiveConfiguration.Name

    outFileNum = FreeFile
    Open outPath For Output As #outFileNum
    Print #outFileNum, "AssemblyConfigName,Component,ComponentConfigName,FeatureName,FeatureType," & _
                       "DimFullName,Value_mm,Value_in,Tolerance_Type," & _
                       "IsDriven,IsLinked,IsGlobalVar,EquationOrComment"

    Dim configNames As Variant
    configNames = swTopModel.GetConfigurationNames

    Dim i As Long
    For i = 0 To UBound(configNames)
        Dim asmConfigName As String
        asmConfigName = CStr(configNames(i))

        swTopModel.ShowConfiguration2 asmConfigName
        swTopModel.ForceRebuild3 False

        ' Assembly-level features/equations for this assembly configuration.
        ProcessModel swTopModel, "[ASSEMBLY] " & swTopModel.GetTitle, asmConfigName, asmConfigName

        ' Top-level components. Set True if you want flattened subassemblies.
        Dim vComps As Variant
        vComps = swTopAssy.GetComponents(False)

        If Not IsEmpty(vComps) Then
            Dim j As Long
            For j = 0 To UBound(vComps)
                Dim swComp As SldWorks.Component2
                Set swComp = vComps(j)

                If Not swComp Is Nothing Then
                    If Not swComp.IsSuppressed Then
                        Dim compModel As SldWorks.ModelDoc2
                        Set compModel = swComp.GetModelDoc2

                        If Not compModel Is Nothing Then
                            Dim compPath As String
                            compPath = compModel.GetPathName

                            Dim compConfigName As String
                            compConfigName = swComp.ReferencedConfiguration
                            If Len(compConfigName) = 0 Then
                                On Error Resume Next
                                compConfigName = compModel.ConfigurationManager.ActiveConfiguration.Name
                                On Error GoTo 0
                            End If

                            Dim seenKey As String
                            seenKey = asmConfigName & "|" & compPath & "|" & compConfigName

                            If Not seenKeys.Exists(seenKey) Then
                                seenKeys.Add seenKey, True
                                ProcessModel compModel, swComp.Name2, asmConfigName, compConfigName
                            End If
                        End If
                    End If
                End If
            Next j
        End If
    Next i

    swTopModel.ShowConfiguration2 originalConfig
    swTopModel.ForceRebuild3 False

    Close #outFileNum

    MsgBox "Dimensions exported to:" & vbCrLf & outPath & vbCrLf & vbCrLf & _
           "Assembly configs walked: " & (UBound(configNames) + 1) & vbCrLf & _
           "Unique component/config entries walked: " & seenKeys.Count & vbCrLf & _
           "Rows written: " & rowsWritten, vbInformation
End Sub

' ------------------------------------------------------------
Sub ProcessModel(model As SldWorks.ModelDoc2, compLabel As String, asmConfigName As String, modelConfigName As String)
    If model Is Nothing Then Exit Sub

    Dim originalModelConfig As String
    originalModelConfig = ""

    On Error Resume Next
    originalModelConfig = model.ConfigurationManager.ActiveConfiguration.Name
    If Len(modelConfigName) > 0 Then
        model.ShowConfiguration2 modelConfigName
        model.ForceRebuild3 False
    End If
    If Err.Number <> 0 Then Err.Clear
    On Error GoTo 0

    ' Walk all features, including immediate sub-features.
    Dim swFeat As SldWorks.Feature
    Set swFeat = model.FirstFeature
    WalkFeature swFeat, model, compLabel, asmConfigName, modelConfigName

    ' Dump global variables and equations.
    Dim swEqMgr As SldWorks.EquationMgr
    Set swEqMgr = model.GetEquationMgr

    If Not swEqMgr Is Nothing Then
        Dim eq As Long
        For eq = 0 To swEqMgr.GetCount - 1
            Dim isGlob As Boolean
            isGlob = swEqMgr.GlobalVariable(eq)

            Dim eqText As String
            eqText = SafeCsv(swEqMgr.Equation(eq))

            Print #outFileNum, _
                SafeCsv(asmConfigName) & "," & _
                SafeCsv(compLabel) & "," & _
                SafeCsv(modelConfigName) & "," & _
                "[Equation " & eq & "]," & _
                "Equation," & _
                "," & _
                "," & _
                "," & _
                "," & _
                "," & _
                "," & _
                IIf(isGlob, "TRUE", "FALSE") & "," & _
                eqText
            rowsWritten = rowsWritten + 1
        Next eq
    End If

    If Len(originalModelConfig) > 0 And originalModelConfig <> modelConfigName Then
        On Error Resume Next
        model.ShowConfiguration2 originalModelConfig
        On Error GoTo 0
    End If
End Sub

' ------------------------------------------------------------
' Walks top-level features and immediate sub-features.
Sub WalkFeature(startFeat As SldWorks.Feature, model As SldWorks.ModelDoc2, compLabel As String, asmConfigName As String, modelConfigName As String)
    Dim swFeat As SldWorks.Feature
    Set swFeat = startFeat

    Do While Not swFeat Is Nothing
        DumpFeatureDimensions swFeat, model, compLabel, asmConfigName, modelConfigName

        Dim swSubFeat As SldWorks.Feature
        Set swSubFeat = swFeat.GetFirstSubFeature
        Do While Not swSubFeat Is Nothing
            DumpFeatureDimensions swSubFeat, model, compLabel, asmConfigName, modelConfigName
            Set swSubFeat = swSubFeat.GetNextSubFeature
        Loop

        Set swFeat = swFeat.GetNextFeature
    Loop
End Sub

' ------------------------------------------------------------
Sub DumpFeatureDimensions(swFeat As SldWorks.Feature, model As SldWorks.ModelDoc2, compLabel As String, asmConfigName As String, modelConfigName As String)
    If swFeat Is Nothing Then Exit Sub

    Dim swDispDim As SldWorks.DisplayDimension
    Set swDispDim = swFeat.GetFirstDisplayDimension

    Do While Not swDispDim Is Nothing
        Dim swDim As SldWorks.Dimension
        Set swDim = swDispDim.GetDimension2(0)

        If Not swDim Is Nothing Then
            Dim valSI As Double
            Dim vVal As Variant

            On Error Resume Next
            vVal = swDim.GetSystemValue3(swSetValue_InThisConfiguration, modelConfigName)
            If Err.Number <> 0 Then
                Err.Clear
                vVal = swDim.GetSystemValue3(swSetValue_InThisConfiguration, "")
            End If
            On Error GoTo 0

            If IsArray(vVal) Then
                valSI = CDbl(vVal(0))
            Else
                valSI = CDbl(vVal)
            End If

            Dim valMm As Double, valIn As Double
            valMm = valSI * 1000#
            valIn = valSI / 0.0254

            Dim tolType As String
            tolType = "N/A"
            On Error Resume Next
            tolType = TolTypeName(swDispDim.GetTolerance.Type)
            On Error GoTo 0

            Dim isDriven As Boolean, isLinked As Boolean
            isDriven = False
            isLinked = False
            On Error Resume Next
            isDriven = (swDim.DrivenState = swDimensionDrivenState_e.swDimensionDriven)
            isLinked = swDim.LinkedToShape
            On Error GoTo 0

            Print #outFileNum, _
                SafeCsv(asmConfigName) & "," & _
                SafeCsv(compLabel) & "," & _
                SafeCsv(modelConfigName) & "," & _
                SafeCsv(swFeat.Name) & "," & _
                SafeCsv(swFeat.GetTypeName2) & "," & _
                SafeCsv(swDim.FullName) & "," & _
                Format(valMm, "0.0000") & "," & _
                Format(valIn, "0.0000") & "," & _
                tolType & "," & _
                IIf(isDriven, "TRUE", "FALSE") & "," & _
                IIf(isLinked, "TRUE", "FALSE") & "," & _
                "FALSE,"
            rowsWritten = rowsWritten + 1
        End If

        Set swDispDim = swFeat.GetNextDisplayDimension(swDispDim)
    Loop
End Sub

' ------------------------------------------------------------
Function TolTypeName(t As Long) As String
    Select Case t
        Case 0: TolTypeName = "None"
        Case 1: TolTypeName = "Basic"
        Case 2: TolTypeName = "Bilateral"
        Case 3: TolTypeName = "Limit"
        Case 4: TolTypeName = "Symmetric"
        Case 5: TolTypeName = "MIN"
        Case 6: TolTypeName = "MAX"
        Case 7: TolTypeName = "Fit"
        Case Else: TolTypeName = "Other(" & t & ")"
    End Select
End Function

' ------------------------------------------------------------
Function SafeCsv(s As String) As String
    Dim r As String
    r = Replace(s, """", """""")
    r = Replace(r, vbCrLf, " | ")
    r = Replace(r, vbLf, " | ")
    r = Replace(r, vbCr, " | ")
    If InStr(r, ",") > 0 Or InStr(r, """") > 0 Then
        SafeCsv = """" & r & """"
    Else
        SafeCsv = r
    End If
End Function
