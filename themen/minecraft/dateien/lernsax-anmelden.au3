#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <AutoItConstants.au3>
#include <WindowsConstants.au3>

; ============================================================
; LernSax WebDAV
; Anmeldung und Einbindung als Windows-Laufwerke
; Benutzername und Kennwort koennen lokal gespeichert werden.
; Das Kennwort wird mit Windows-DPAPI verschluesselt und ist
; an das aktuelle Windows-Benutzerkonto gebunden.
; Beim Start werden vorhandene LernSax-Netzlaufwerke getrennt.
; Fuer Mitglieder der AGs Minecraft und Young Engineers.
; Martin-Rinckart-Gymnasium Eilenburg.
; ============================================================

; ------------------------------------------------------------
; WebDAV-Pfade
; ------------------------------------------------------------

Global Const $sWebDAVBasis = _
    "\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\storage"

Global Const $sPfadY = _
    "\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\youngengineers@mrge.lernsax.de\storage"

Global Const $sPfadM = _
    "\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\ye-minecraft@mrge.lernsax.de\storage"

; ------------------------------------------------------------
; Versionsinformation
; ------------------------------------------------------------

Global Const $sVersion = "4.5"
Global Const $sVersionStand = "25.09.2026 21:38"

; ------------------------------------------------------------
; Speicherort fuer die Anmeldedaten
; ------------------------------------------------------------

Global Const $sDatenOrdner = @AppDataDir & "\YoungEngineers"
Global Const $sDatenDatei = $sDatenOrdner & "\lernsax.ini"

; Auf dem gemeinsam genutzten Windows-Konto "nutzer" duerfen
; keine LernSax-Anmeldedaten gespeichert oder geladen werden.
Global $bSpeichernErlaubt = (StringLower(@UserName) <> "nutzer")

; ------------------------------------------------------------
; Beim Programmstart vorhandene LernSax-Netzlaufwerke trennen
; ------------------------------------------------------------

Local $sTrennWarnung = _LernSaxVerbindungenTrennen()

If $sTrennWarnung <> "" Then
    MsgBox(16, _
        "LernSax - Neustart erforderlich", _
        "Nicht alle vorhandenen LernSax-Netzwerkverbindungen konnten getrennt werden." & @CRLF & @CRLF & _
        $sTrennWarnung & @CRLF & _
        "Windows wird jetzt neu gestartet." & @CRLF & _
        "Nicht gespeicherte Daten in anderen Programmen koennen verloren gehen." _
    )

    ; Erzwungener Windows-Neustart. Danach wird dieses Programm beendet.
    Run(@ComSpec & ' /c shutdown /r /f /t 0', "", @SW_HIDE)
    Exit
EndIf

; ------------------------------------------------------------
; Gespeicherte Anmeldedaten laden
; ------------------------------------------------------------

Local $sGespeicherterBenutzer = "vorname.nachname@mrge.lernsax.de"
Local $sGespeichertesPasswort = ""
Local $bDatenVorhanden = False

If $bSpeichernErlaubt Then
    _AnmeldedatenLaden($sGespeicherterBenutzer, $sGespeichertesPasswort, $bDatenVorhanden)
Else
    ; Auf dem gemeinsamen Windows-Konto keine personenbezogenen
    ; Daten vorbelegen und eventuell vorhandene Altdaten entfernen.
    $sGespeicherterBenutzer = ""
    $sGespeichertesPasswort = ""
    _AnmeldedatenLoeschen()
EndIf

; ------------------------------------------------------------
; GUI erzeugen
; ------------------------------------------------------------

Global $hGUI = GUICreate("LernSax - WebDAV - Version " & $sVersion, 650, 620)

GUICtrlCreateLabel("LernSax-Anmeldung", 25, 20, 200, 25)

If Not $bSpeichernErlaubt Then
    GUICtrlCreateLabel( _
        "Windows-Benutzer 'nutzer': Anmeldedaten werden nicht gespeichert.", _
        285, 20, 315, 25 _
    )
EndIf

GUICtrlCreateLabel("Benutzername:", 25, 65, 100, 20)
Global $idBenutzer = GUICtrlCreateInput( _
    $sGespeicherterBenutzer, _
    130, 60, 470, 25 _
)

GUICtrlCreateLabel("Kennwort:", 25, 105, 100, 20)
Global $idPasswort = GUICtrlCreateInput( _
    $sGespeichertesPasswort, _
    130, 100, 470, 25, _
    $ES_PASSWORD _
)

Global $idMerken = GUICtrlCreateCheckbox( _
    "Anmeldedaten merken", _
    130, 132, 170, 22 _
)

If $bSpeichernErlaubt Then
    GUICtrlSetState($idMerken, $GUI_CHECKED)
Else
    GUICtrlSetState($idMerken, $GUI_UNCHECKED)
    GUICtrlSetState($idMerken, $GUI_DISABLE)
    GUICtrlSetData($idMerken, "Anmeldedaten merken (deaktiviert)")
EndIf

Global $idVerbinden = GUICtrlCreateButton( _
    "Verbinden", _
    130, 170, 120, 32 _
)

Global $idAktualisieren = GUICtrlCreateButton( _
    "Aktualisieren", _
    265, 170, 120, 32 _
)

Global $idLoeschen = GUICtrlCreateButton( _
    "Anmeldedaten loeschen", _
    400, 170, 160, 32 _
)

If Not $bSpeichernErlaubt Then
    GUICtrlSetState($idLoeschen, $GUI_DISABLE)
EndIf

Global $idBeenden = GUICtrlCreateButton( _
    "Beenden", _
    480, 565, 120, 32 _
)

; Hinweise zur Zielgruppe und Schule
GUICtrlCreateLabel( _
    "Martin-Rinckart-Gymnasium Eilenburg", _
    25, 510, 360, 20 _
)

GUICtrlCreateLabel( _
    "F" & ChrW(252) & "r Mitglieder der AGs Minecraft und Young Engineers", _
    25, 532, 430, 20 _
)

; Versionsanzeige
GUICtrlCreateLabel( _
    "Version " & $sVersion & " - Stand: " & $sVersionStand, _
    25, 565, 360, 20 _
)

; ------------------------------------------------------------
; Laufwerksuebersicht
; ------------------------------------------------------------

GUICtrlCreateLabel("Laufwerksuebersicht", 25, 225, 200, 25)

Global $idLaufwerke = GUICtrlCreateEdit( _
    "", _
    25, 255, 575, 240, _
    BitOR($ES_READONLY, $WS_VSCROLL, $ES_AUTOVSCROLL) _
)

GUISetState(@SW_SHOW)
LaufwerkeAnzeigen()

; ============================================================
; Hauptschleife
; ============================================================

While True
    Switch GUIGetMsg()

        Case $GUI_EVENT_CLOSE, $idBeenden
            Exit

        Case $idVerbinden
            LaufwerkeVerbinden()

        Case $idAktualisieren
            LaufwerkeAnzeigen()

        Case $idLoeschen
            If MsgBox(36, "LernSax", "Gespeicherte Anmeldedaten wirklich loeschen?") = 6 Then
                _AnmeldedatenLoeschen()
                GUICtrlSetData($idPasswort, "")
                GUICtrlSetState($idMerken, $GUI_UNCHECKED)
                MsgBox(64, "LernSax", "Die gespeicherten Anmeldedaten wurden geloescht.")
            EndIf

    EndSwitch
WEnd

; ============================================================
; LernSax-Laufwerke verbinden
; ============================================================

Func LaufwerkeVerbinden()

    Local $sBenutzer = GUICtrlRead($idBenutzer)
    Local $sPasswort = GUICtrlRead($idPasswort)

    If $sBenutzer = "" Then
        MsgBox(48, "LernSax", "Bitte einen Benutzernamen eingeben.")
        Return
    EndIf

    If $sPasswort = "" Then
        MsgBox(48, "LernSax", "Bitte das Kennwort eingeben.")
        Return
    EndIf

    ; Persoenlicher LernSax-Pfad des aktuell angemeldeten Benutzers.
    ; Der Benutzername wird vor dem Unterordner \storage eingesetzt.
    Local $sPfadL = _
        StringTrimRight($sWebDAVBasis, StringLen("\storage")) & _
        "\" & $sBenutzer & "\storage"

    GUICtrlSetState($idVerbinden, $GUI_DISABLE)
    GUICtrlSetData($idVerbinden, "Verbinde ...")

    ; Vorhandene LernSax-Verbindungen entfernen
    DriveMapDel("L:")
    DriveMapDel("Y:")
    DriveMapDel("M:")

    ; L: Lernsax - persoenlicher Bereich
    Local $sL = DriveMapAdd( _
        "L:", _
        $sPfadL, _
        $DMA_DEFAULT, _
        $sBenutzer, _
        $sPasswort _
    )

    ; Y: Young Engineers
    Local $sY = DriveMapAdd( _
        "Y:", _
        $sPfadY, _
        $DMA_DEFAULT, _
        $sBenutzer, _
        $sPasswort _
    )

    ; M: Minecraft
    Local $sM = DriveMapAdd( _
        "M:", _
        $sPfadM, _
        $DMA_DEFAULT, _
        $sBenutzer, _
        $sPasswort _
    )

    GUICtrlSetState($idVerbinden, $GUI_ENABLE)
    GUICtrlSetData($idVerbinden, "Verbinden")

    LaufwerkeAnzeigen()

    ; Anmeldedaten nur nach einer zumindest teilweise erfolgreichen
    ; Verbindung speichern. Auf dem Windows-Konto "nutzer" ist das
    ; Speichern grundsaetzlich gesperrt.
    If $sL <> "" Or $sY <> "" Or $sM <> "" Then
        If $bSpeichernErlaubt Then
            If BitAND(GUICtrlRead($idMerken), $GUI_CHECKED) Then
                If Not _AnmeldedatenSpeichern($sBenutzer, $sPasswort) Then
                    MsgBox(48, "LernSax", "Die Laufwerke wurden verbunden, aber die Anmeldedaten konnten nicht gespeichert werden.")
                EndIf
            Else
                _AnmeldedatenLoeschen()
            EndIf
        Else
            _AnmeldedatenLoeschen()
        EndIf
    EndIf

    ; Ergebnis mit differenzierter Anzeige der drei LernSax-Bereiche
    Local $sStatus = _
        "L: Persoenlicher Bereich   " & _VerbindungsStatus($sL, False) & @CRLF & _
        "Y: Young Engineers         " & _VerbindungsStatus($sY, True) & @CRLF & _
        "M: Minecraft               " & _VerbindungsStatus($sM, True)

    If $sL <> "" And $sY <> "" And $sM <> "" Then
        MsgBox(64, _
            "LernSax", _
            "Anmeldung erfolgreich." & @CRLF & @CRLF & _
            $sStatus _
        )

    ElseIf $sL = "" And $sY = "" And $sM = "" Then
        MsgBox(16, _
            "LernSax", _
            "Es konnte kein LernSax-Laufwerk verbunden werden." & @CRLF & _
            "Bitte Benutzername, Kennwort und Netzwerkverbindung pruefen." & @CRLF & @CRLF & _
            $sStatus _
        )

    Else
        MsgBox(48, _
            "LernSax", _
            "Die Anmeldung war erfolgreich, aber nicht alle LernSax-Laufwerke " & _
            "konnten verbunden werden." & @CRLF & @CRLF & _
            $sStatus & @CRLF & @CRLF & _
            "Bei Y: und M: kann eine fehlende Gruppenmitgliedschaft oder " & _
            "Berechtigung die Ursache sein." _
        )
    EndIf

EndFunc

; ============================================================
; Text fuer den Verbindungsstatus eines LernSax-Laufwerks
; ============================================================

Func _VerbindungsStatus($sRueckgabe, $bGruppenLaufwerk)

    If $sRueckgabe <> "" Then Return "verbunden"

    If $bGruppenLaufwerk Then
        Return "kein Zugriff / nicht verbunden"
    EndIf

    Return "nicht verbunden"

EndFunc

; ============================================================
; Alle verfuegbaren Laufwerke anzeigen
; ============================================================

Func LaufwerkeAnzeigen()

    Local $aLaufwerke = DriveGetDrive("ALL")
    Local $sAnzeige = ""
    Local $sLaufwerk
    Local $sTyp
    Local $sNetzPfad

    If @error Or Not IsArray($aLaufwerke) Then
        GUICtrlSetData($idLaufwerke, "Keine Laufwerke gefunden.")
        Return
    EndIf

    $sAnzeige &= "Laufwerk   Typ             Netzwerkpfad" & @CRLF
    $sAnzeige &= "--------------------------------------------------------------" & @CRLF

    For $i = 1 To $aLaufwerke[0]

        $sLaufwerk = StringUpper($aLaufwerke[$i])
        $sTyp = DriveGetType($sLaufwerk)
        $sNetzPfad = ""

        If $sTyp = "Network" Then
            $sNetzPfad = DriveMapGet($sLaufwerk)

            If @error Then
                $sNetzPfad = "(Netzwerkpfad nicht ermittelbar)"
            EndIf
        EndIf

        $sAnzeige &= StringFormat( _
            "%-10s %-15s %s", _
            $sLaufwerk, _
            $sTyp, _
            $sNetzPfad _
        )

        $sAnzeige &= @CRLF
    Next

    GUICtrlSetData($idLaufwerke, $sAnzeige)

EndFunc

; ============================================================
; Vorhandene LernSax-Netzlaufwerke beim Programmstart trennen
;
; Rueckgabe:
;   ""  = alle gefundenen LernSax-Verbindungen wurden getrennt
;   Text = mindestens eine Verbindung konnte nicht getrennt werden
; ============================================================

Func _LernSaxVerbindungenTrennen()

    Local $sFehler = ""
    Local $sLaufwerk
    Local $sNetzPfad
    Local $sPruefPfad

    For $i = Asc("A") To Asc("Z")

        $sLaufwerk = Chr($i) & ":"
        $sNetzPfad = DriveMapGet($sLaufwerk)

        If @error Then ContinueLoop

        ; Nur Verbindungen zum LernSax-WebDAV-Server trennen.
        ; Andere Netzlaufwerke bleiben unveraendert.
        If StringInStr( _
            StringLower($sNetzPfad), _
            "\\www.lernsax.de@ssl\davwwwroot\webdav.php\" _
        ) > 0 Then

            If Not DriveMapDel($sLaufwerk) Then
                $sFehler &= $sLaufwerk & "  " & $sNetzPfad & @CRLF
            Else
                ; Kontrollieren, ob die Zuordnung wirklich verschwunden ist.
                $sPruefPfad = DriveMapGet($sLaufwerk)

                If Not @error Then
                    If StringInStr( _
                        StringLower($sPruefPfad), _
                        "\\www.lernsax.de@ssl\davwwwroot\webdav.php\" _
                    ) > 0 Then
                        $sFehler &= $sLaufwerk & "  " & $sPruefPfad & @CRLF
                    EndIf
                EndIf
            EndIf

        EndIf

    Next

    Return $sFehler

EndFunc

; ============================================================
; Anmeldedaten speichern / laden / loeschen
; ============================================================

Func _AnmeldedatenSpeichern($sBenutzer, $sPasswort)

    If Not $bSpeichernErlaubt Then Return False

    DirCreate($sDatenOrdner)

    Local $sVerschluesselt = _DPAPIVerschluesseln($sPasswort)
    If @error Or $sVerschluesselt = "" Then Return False

    If Not IniWrite($sDatenDatei, "LernSax", "Benutzer", $sBenutzer) Then Return False
    If Not IniWrite($sDatenDatei, "LernSax", "Kennwort", $sVerschluesselt) Then Return False

    Return True

EndFunc

Func _AnmeldedatenLaden(ByRef $sBenutzer, ByRef $sPasswort, ByRef $bVorhanden)

    $bVorhanden = False

    If Not $bSpeichernErlaubt Then Return

    If Not FileExists($sDatenDatei) Then Return

    Local $sBenutzerDatei = IniRead($sDatenDatei, "LernSax", "Benutzer", "")
    Local $sKennwortDatei = IniRead($sDatenDatei, "LernSax", "Kennwort", "")

    If $sBenutzerDatei = "" Or $sKennwortDatei = "" Then Return

    Local $sEntschluesselt = _DPAPIEntschluesseln($sKennwortDatei)
    If @error Then Return

    $sBenutzer = $sBenutzerDatei
    $sPasswort = $sEntschluesselt
    $bVorhanden = True

EndFunc

Func _AnmeldedatenLoeschen()
    If FileExists($sDatenDatei) Then FileDelete($sDatenDatei)
EndFunc

; ============================================================
; Windows-DPAPI
; Das Kennwort kann nur vom gleichen Windows-Benutzerkonto
; auf diesem Windows-System entschluesselt werden.
; ============================================================

Func _DPAPIVerschluesseln($sText)

    Local $bDaten = StringToBinary($sText, 4) ; UTF-8
    Local $iLaenge = BinaryLen($bDaten)

    If $iLaenge = 0 Then Return SetError(1, 0, "")

    Local $tDaten = DllStructCreate("byte[" & $iLaenge & "]")
    DllStructSetData($tDaten, 1, $bDaten)

    Local $tEingabe = DllStructCreate("dword cbData;ptr pbData")
    DllStructSetData($tEingabe, "cbData", $iLaenge)
    DllStructSetData($tEingabe, "pbData", DllStructGetPtr($tDaten))

    Local $tAusgabe = DllStructCreate("dword cbData;ptr pbData")

    Local $aRueckgabe = DllCall( _
        "Crypt32.dll", _
        "bool", "CryptProtectData", _
        "ptr", DllStructGetPtr($tEingabe), _
        "wstr", "LernSax WebDAV", _
        "ptr", 0, _
        "ptr", 0, _
        "ptr", 0, _
        "dword", 0, _
        "ptr", DllStructGetPtr($tAusgabe) _
    )

    If @error Or Not $aRueckgabe[0] Then Return SetError(2, 0, "")

    Local $iAusgabeLaenge = DllStructGetData($tAusgabe, "cbData")
    Local $pAusgabe = DllStructGetData($tAusgabe, "pbData")

    Local $tVerschluesselt = DllStructCreate("byte[" & $iAusgabeLaenge & "]", $pAusgabe)
    Local $bVerschluesselt = DllStructGetData($tVerschluesselt, 1)

    DllCall("Kernel32.dll", "ptr", "LocalFree", "ptr", $pAusgabe)

    Return String($bVerschluesselt)

EndFunc

Func _DPAPIEntschluesseln($sVerschluesselt)

    Local $bDaten = Binary($sVerschluesselt)
    Local $iLaenge = BinaryLen($bDaten)

    If $iLaenge = 0 Then Return SetError(1, 0, "")

    Local $tDaten = DllStructCreate("byte[" & $iLaenge & "]")
    DllStructSetData($tDaten, 1, $bDaten)

    Local $tEingabe = DllStructCreate("dword cbData;ptr pbData")
    DllStructSetData($tEingabe, "cbData", $iLaenge)
    DllStructSetData($tEingabe, "pbData", DllStructGetPtr($tDaten))

    Local $tAusgabe = DllStructCreate("dword cbData;ptr pbData")
    Local $pBeschreibung = 0

    Local $aRueckgabe = DllCall( _
        "Crypt32.dll", _
        "bool", "CryptUnprotectData", _
        "ptr", DllStructGetPtr($tEingabe), _
        "ptr*", $pBeschreibung, _
        "ptr", 0, _
        "ptr", 0, _
        "ptr", 0, _
        "dword", 0, _
        "ptr", DllStructGetPtr($tAusgabe) _
    )

    If @error Or Not $aRueckgabe[0] Then Return SetError(2, 0, "")

    Local $iAusgabeLaenge = DllStructGetData($tAusgabe, "cbData")
    Local $pAusgabe = DllStructGetData($tAusgabe, "pbData")

    Local $tEntschluesselt = DllStructCreate("byte[" & $iAusgabeLaenge & "]", $pAusgabe)
    Local $bEntschluesselt = DllStructGetData($tEntschluesselt, 1)

    DllCall("Kernel32.dll", "ptr", "LocalFree", "ptr", $pAusgabe)

    If IsArray($aRueckgabe) And UBound($aRueckgabe) > 2 Then
        If $aRueckgabe[2] <> 0 Then DllCall("Kernel32.dll", "ptr", "LocalFree", "ptr", $aRueckgabe[2])
    EndIf

    Return BinaryToString($bEntschluesselt, 4)

EndFunc
