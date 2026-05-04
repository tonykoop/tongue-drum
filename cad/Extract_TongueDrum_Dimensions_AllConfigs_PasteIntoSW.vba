' ============================================================
' ExtractTongueDrumDimensions_AllConfigs.swp
' ------------------------------------------------------------
' Walks EVERY configuration of the active SolidWorks assembly,
' opens every component, and dumps EVERY dimension (named +
' unnamed), every global variable, and every equation to a CSV
' next to the assembly.
'
' Output columns:
'   AssemblyConfigName, Component, ConfigName, FeatureName,
'   FeatureType, DimFullName, Value_mm, Value_in,
'   Tolerance_Type, IsDriven, IsLinked, IsGlobalVar,
'   EquationOrComment
'
' Usage:
'   1. Open TNG-000_TongueDrum.SLDASM in SolidWorks.
'   2. Tools > Macro > Edit, paste this whole file into a
'      blank module, save as a .swp macro.
'   3. Tools > Macro > Run > select main.
'   4. CSV is written to <AssemblyPath>_ALL_CONFIGS_dimensions.csv.
' ============================================================

Option Explicit

Dim swApp           As SldWorks.SldWorks
Dim swTopModel      As SldWorks.ModelDoc2
Dim swTopAssy       As SldWorks.AssemblyDoc
Dim outFileNum      As Integer
Dim seenPaths       As Object   ' Scripting.Dictionary, dedupe per assembly config
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

    If Len(swTopModel.GetPathName) = 0 Then
        MsgBox "Save the assembly before running this macro.", vbExclamation
        Exit Sub
    End If

    Set swTopAssy = swTopModel
    rowsWritten = 0

    Dim originalConfig As String
    originalConfig = swTopModel.GetActiveConfiguration.Name

    Dim outPath As String
    outPath = Left(swTopModel.GetPathName, InStrRev(swTopModel.GetPathName, ".") - 1) & _
              "_ALL_CONFIGS_dimensions.csv"

    outFileNum = FreeFile
    Open outPath For Output As #outFileNum
    Print #outFileNum, "AssemblyConfigName,Component,ConfigName,FeatureName,FeatureType," & _
                       "DimFullName,Value_mm,Value_in,Tolerance_Type," & _
                       "IsDriven,IsLinked,IsGlobalVar,EquationOrComment"

    Dim vConfigs As Variant
    vConfigs = swTopModel.GetConfigurationNames

    Dim c As Long
    For c = 0 To UBound(vConfigs)
        Dim asmConfigName As String
        asmConfigName = CStr(vConfigs(c))

        swTopModel.ShowConfiguration2 asmConfigName
        swTopModel.EditRebuild3

        Set seenPaths = CreateObject("Scripting.Dictionary")

        ' --- Walk top-level components for this assembly configuration ---
        Dim vComps As Variant
        vComps = swTopAssy.GetComponents(False)   ' False = top-level only; True = flatten subassemblies

        If Not IsEmpty(vComps) Then
            Dim i As Long
            For i = 0 To UBound(vComps)
                Dim swComp As SldWorks.Component2
                Set swComp = vComps(i)

                If Not swComp Is Nothing Then
                    If swComp.IsSuppressed = False Then
                        Dim compModel As SldWorks.ModelDoc2
                        Set compModel = swComp.GetModelDoc2

                        If Not compModel Is Nothing Then
                            Dim compPath As String
                            compPath = compModel.GetPathName

                            Dim compConfigName As String
                            compConfigName = swComp.ReferencedConfiguration
                            If Len(compConfigName) = 0 Then
                                On Error Resume Next
                                compConfigName = compModel.GetActiveConfiguration.Name
                                On Error GoTo 0
                            End If

                            ' Dedupe by file path plus referenced config, within this assembly config.
                            Dim seenKey As String
                            seenKey = compPath & "|" & compConfigName

                            If Not seenPaths.Exists(seenKey) Then
                                seenPaths.Add seenKey, True
                                ProcessModel compModel, swComp.Name2, asmConfigName, compConfigName
                            End If
                        End If
                    End If
                End If
            Next i
        End If

        ' --- Also process the assembly itself for assembly-level features/equations ---
        ProcessModel swTopModel, "[ASSEMBLY] " & swTopModel.GetTitle, asmConfigName, asmConfigName
    Next c

    swTopModel.ShowConfiguration2 originalConfig
    swTopModel.EditRebuild3

    Close #outFileNum

    MsgBox "Dimensions exported to:" & vbCrLf & outPath & vbCrLf & vbCrLf & _
           "Assembly configs walked: " & (UBound(vConfigs) + 1) & vbCrLf & _
           "Rows written: " & rowsWritten, vbInformation
End Sub

' ------------------------------------------------------------
Sub ProcessModel(model As SldWorks.ModelDoc2, compLabel As String, asmConfigName As String, configName As String)
    Dim originalConfig As String
    originalConfig = ""

    On Error Resume Next
    originalConfig = model.GetActiveConfiguration.Name
    If Len(configName) > 0 Then
        model.ShowConfiguration2 configName
        model.EditRebuild3
    End If
    On Error GoTo 0

    ' --- Walk all features (including nested in folders / patterns) ---
    Dim swFeat As SldWorks.Feature
    Set swFeat = model.FirstFeature
    WalkFeature swFeat, model, compLabel, asmConfigName, configName

    ' --- Dump global variables and equations ---
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
                SafeCsv(configName) & "," & _
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

    If Len(originalConfig) > 0 And originalConfig <> configName Then
        On Error Resume Next
        model.ShowConfiguration2 originalConfig
        model.EditRebuild3
        On Error GoTo 0
    End If
End Sub

' ------------------------------------------------------------
' Walks top-level features and their immediate sub-features (sketches inside extrudes, etc.)
Sub WalkFeature(startFeat As SldWorks.Feature, model As SldWorks.ModelDoc2, compLabel As String, asmConfigName As String, configName As String)
    Dim swFeat As SldWorks.Feature
    Set swFeat = startFeat

    Do While Not swFeat Is Nothing
        DumpFeatureDimensions swFeat, model, compLabel, asmConfigName, configName

        ' Walk sub-features one level deep using GetNextSubFeature (NOT GetNextFeature)
        Dim swSubFeat As SldWorks.Feature
        Set swSubFeat = swFeat.GetFirstSubFeature
        Do While Not swSubFeat Is Nothing
            DumpFeatureDimensions swSubFeat, model, compLabel, asmConfigName, configName
            Set swSubFeat = swSubFeat.GetNextSubFeature
        Loop

        Set swFeat = swFeat.GetNextFeature
    Loop
End Sub

' ------------------------------------------------------------
Sub DumpFeatureDimensions(swFeat As SldWorks.Feature, model As SldWorks.ModelDoc2, compLabel As String, asmConfigName As String, configName As String)
    Dim swDispDim As SldWorks.DisplayDimension
    Set swDispDim = swFeat.GetFirstDisplayDimension

    Do While Not swDispDim Is Nothing
        Dim swDim As SldWorks.Dimension
        Set swDim = swDispDim.GetDimension2(0)

        If Not swDim Is Nothing Then
            Dim valSI As Double
            valSI = swDim.GetSystemValue3(swSetValue_InThisConfiguration, configName)(0)

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
                SafeCsv(configName) & "," & _
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
    r = Replace(s, """", """""")     ' escape internal quotes
    r = Replace(r, vbCrLf, " | ")
    r = Replace(r, vbLf, " | ")
    r = Replace(r, vbCr, " | ")
    If InStr(r, ",") > 0 Or InStr(r, """") > 0 Then
        SafeCsv = """" & r & """"
    Else
        SafeCsv = r
    End If
End Function
