# Dokumentation: `lernsax-anmelden-4-korrigiert-v3.au3`

**Stand:** 24.09.2026  
**Programmtyp:** AutoIt-Skript für Windows  
**Aufgabe:** Anmeldung bei LernSax und Einbindung ausgewählter LernSax-Bereiche als Windows-Netzlaufwerke

---

## 1. Zweck des Programms

`lernsax-anmelden-4-korrigiert-v3.au3` erleichtert den Zugriff auf LernSax über WebDAV.

Nach der Anmeldung werden drei LernSax-Bereiche als Windows-Laufwerke eingebunden:

| Laufwerk | Bereich | Ziel |
|---|---|---|
| `P:` | persönlicher LernSax-Bereich | persönlicher `storage`-Ordner des angemeldeten Nutzers |
| `Y:` | Young Engineers | gemeinsamer `storage`-Ordner der Gruppe |
| `M:` | Minecraft | gemeinsamer `storage`-Ordner der Minecraft-Gruppe |

Dadurch können nicht nur das AutoIt-Programm selbst, sondern auch andere Windows-Programme direkt auf die LernSax-Dateien zugreifen.

Beispiele:

```text
P:\
Y:\
M:\
```

---

## 2. Voraussetzungen

Das Programm ist für Windows vorgesehen.

Benötigt werden:

- eine funktionierende Internetverbindung,
- ein gültiger LernSax-Zugang,
- der Windows-WebDAV-Zugriff auf `www.lernsax.de`,
- freie Laufwerksbuchstaben `P:`, `Y:` und `M:`,
- AutoIt zum Starten der `.au3`-Datei oder eine daraus erzeugte `.exe`.

Die Laufwerksverbindungen werden nicht dauerhaft gespeichert. Sie gelten für die aktuelle Windows-Sitzung.

---

## 3. Verwendete WebDAV-Pfade

Das Programm verwendet den LernSax-WebDAV-Zugang über:

```text
\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\
```

### Persönlicher Bereich `P:`

Der persönliche Pfad wird aus dem eingegebenen LernSax-Benutzernamen erzeugt.

Beispiel:

```text
Benutzer:
max.mustermann@mrge.lernsax.de
```

ergibt:

```text
\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\max.mustermann@mrge.lernsax.de\storage
```

Damit wird immer der persönliche `storage`-Ordner des aktuell angemeldeten LernSax-Nutzers verwendet.

### Young Engineers `Y:`

```text
\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\youngengineers@mrge.lernsax.de\storage
```

### Minecraft `M:`

```text
\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\ye-minecraft@mrge.lernsax.de\storage
```

---

## 4. Ablauf beim Programmstart

Beim Start führt das Programm mehrere Schritte automatisch aus.

### 4.1 Vorhandene LernSax-Verbindungen suchen

Alle Laufwerksbuchstaben von `A:` bis `Z:` werden geprüft.

Dabei wird untersucht, ob ein vorhandenes Netzlaufwerk auf einen LernSax-WebDAV-Pfad verweist:

```text
\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\
```

Andere Netzlaufwerke bleiben unverändert.

### 4.2 Vorhandene LernSax-Verbindungen trennen

Gefundene LernSax-Verbindungen werden mit `DriveMapDel()` getrennt.

Nach dem Trennen kontrolliert das Programm nochmals, ob die Zuordnung tatsächlich verschwunden ist.

Dieses Vorgehen soll verhindern, dass alte LernSax-Verbindungen oder Anmeldedaten die neue Anmeldung behindern.

### 4.3 Fehler beim Trennen

Kann mindestens eine LernSax-Verbindung nicht getrennt werden, erscheint die Meldung:

```text
Nicht alle vorhandenen LernSax-Netzwerkverbindungen konnten getrennt werden.
```

Zusätzlich werden die betroffenen Laufwerke und Netzwerkpfade angezeigt.

Anschließend informiert das Programm:

```text
Windows wird jetzt neu gestartet.
Nicht gespeicherte Daten in anderen Programmen koennen verloren gehen.
```

Nach Bestätigung der Warnung wird unmittelbar ein Windows-Neustart ausgelöst:

```bat
shutdown /r /f /t 0
```

Bedeutung:

- `/r` – Windows neu starten
- `/f` – geöffnete Programme zwangsweise schließen
- `/t 0` – ohne Wartezeit neu starten

Das AutoIt-Programm wird anschließend beendet.

**Wichtig:** Durch `/f` können nicht gespeicherte Änderungen in anderen Programmen verloren gehen.

---

## 5. Anmeldefenster

Wenn alle alten LernSax-Verbindungen erfolgreich entfernt wurden, öffnet sich das Anmeldefenster.

Es enthält:

- Benutzername
- Kennwort
- Auswahl `Anmeldedaten merken`
- Schaltfläche `Verbinden`
- Schaltfläche `Aktualisieren`
- Schaltfläche `Anmeldedaten loeschen`
- Schaltfläche `Beenden`
- Laufwerksübersicht

Das Kennwort wird im Eingabefeld verdeckt dargestellt.

---

## 6. Anmeldung bei LernSax

Nach Klick auf **Verbinden** liest das Programm Benutzername und Kennwort aus.

Sind Benutzername oder Kennwort leer, wird die Verbindung nicht gestartet und eine entsprechende Meldung angezeigt.

Danach wird der persönliche WebDAV-Pfad aus dem eingegebenen Benutzernamen erzeugt.

Vor dem eigentlichen Verbinden versucht das Programm vorsorglich erneut, die Laufwerke

```text
P:
Y:
M:
```

zu trennen.

Danach werden die drei Laufwerke neu eingerichtet.

---

## 7. Einbindung der Laufwerke

Die Zuordnung erfolgt mit AutoIts `DriveMapAdd()`.

### `P:` – persönlicher Bereich

```text
P: → persönlicher LernSax-storage-Ordner
```

Der Benutzername ist dynamisch und entspricht der im Programm eingegebenen LernSax-Adresse.

### `Y:` – Young Engineers

```text
Y: → Young Engineers / storage
```

### `M:` – Minecraft

```text
M: → Minecraft / storage
```

Alle drei Verbindungen verwenden dieselben eingegebenen LernSax-Anmeldedaten.

Die Verbindungen werden mit `$DMA_DEFAULT` erstellt und damit nicht als dauerhaft wiederherzustellende Laufwerke gespeichert.

---

## 8. Rückmeldung nach der Anmeldung

Das Programm unterscheidet drei Ergebnisse.

### Alle drei Laufwerke erfolgreich

```text
Anmeldung erfolgreich.

Die LernSax-Laufwerke P:, Y: und M: stehen zur Verfuegung.
```

### Kein Laufwerk erfolgreich

```text
Es konnte kein LernSax-Laufwerk verbunden werden.
Bitte Benutzername und Kennwort pruefen.
```

### Nur ein Teil der Laufwerke erfolgreich

```text
Die Anmeldung war erfolgreich, aber nicht alle LernSax-Laufwerke konnten verbunden werden.
```

Damit bleibt erkennbar, ob beispielsweise der persönliche Bereich funktioniert, aber ein gemeinsamer Bereich nicht verfügbar ist.

---

## 9. Laufwerksübersicht

Das Programm zeigt alle aktuell verfügbaren Laufwerke des PCs an.

Dazu gehören beispielsweise:

- lokale Festplatten,
- USB-Laufwerke,
- andere Netzlaufwerke,
- die LernSax-Laufwerke `P:`, `Y:` und `M:`.

Die Anzeige enthält:

```text
Laufwerk   Typ             Netzwerkpfad
```

Bei Netzlaufwerken wird zusätzlich der zugehörige Netzwerkpfad mit `DriveMapGet()` ermittelt.

Beispiel:

```text
C:         Fixed
D:         Fixed
M:         Network         \\www.lernsax.de@SSL\DavWWWRoot\...
P:         Network         \\www.lernsax.de@SSL\DavWWWRoot\...
Y:         Network         \\www.lernsax.de@SSL\DavWWWRoot\...
Z:         Network         \\schulserver\daten
```

Über die Schaltfläche **Aktualisieren** kann die Liste jederzeit neu eingelesen werden.

---

## 10. Speichern der Anmeldedaten

Auf persönlichen Windows-Konten können Benutzername und Kennwort gespeichert werden.

Die Daten werden in folgender Datei abgelegt:

```text
%APPDATA%\YoungEngineers\lernsax.ini
```

Typischer vollständiger Pfad:

```text
C:\Users\<Windows-Benutzer>\AppData\Roaming\YoungEngineers\lernsax.ini
```

Die Datei enthält:

- den LernSax-Benutzernamen,
- das verschlüsselte Kennwort.

Die Daten werden nur nach mindestens einer erfolgreichen Laufwerksverbindung gespeichert.

Ist **Anmeldedaten merken** nicht aktiviert, werden eventuell vorhandene gespeicherte Daten wieder gelöscht.

---

## 11. Schutz des Kennworts mit Windows-DPAPI

Das Kennwort wird nicht im Klartext in `lernsax.ini` gespeichert.

Das Programm verwendet die Windows Data Protection API (DPAPI):

```text
CryptProtectData
CryptUnprotectData
```

Vor dem Verschlüsseln wird das Kennwort als UTF-8-Binärdaten behandelt.

Beim Laden wird es mit demselben Windows-Benutzerkonto wieder entschlüsselt.

Dadurch ist das gespeicherte Kennwort an das jeweilige Windows-Benutzerkonto und das Windows-System gebunden.

Die zentrale Idee lautet:

```text
LernSax-Kennwort
      ↓
Windows-DPAPI
      ↓
verschlüsselte Daten
      ↓
lernsax.ini
```

Beim Laden läuft der Weg umgekehrt.

---

## 12. Sonderregel für den Windows-Benutzer `nutzer`

Das gemeinsam verwendete Windows-Konto

```text
nutzer
```

wird besonders behandelt.

Für diesen Windows-Benutzer dürfen keine LernSax-Anmeldedaten gespeichert werden.

Die Prüfung erfolgt sinngemäß über:

```autoit
StringLower(@UserName) <> "nutzer"
```

Ist der aktuelle Windows-Benutzer `nutzer`:

- wird kein gespeicherter LernSax-Benutzer geladen,
- wird kein Kennwort geladen,
- werden eventuell vorhandene alte Anmeldedaten gelöscht,
- ist `Anmeldedaten merken` deaktiviert,
- ist `Anmeldedaten loeschen` deaktiviert,
- Benutzername und Kennwort müssen bei jeder Nutzung neu eingegeben werden.

Im Fenster erscheint zusätzlich der Hinweis:

```text
Windows-Benutzer 'nutzer': Anmeldedaten werden nicht gespeichert.
```

Diese Regel ist besonders für gemeinsam genutzte Schul-PCs vorgesehen.

---

## 13. Löschen gespeicherter Anmeldedaten

Auf Windows-Konten, auf denen das Speichern erlaubt ist, kann die Schaltfläche

```text
Anmeldedaten loeschen
```

verwendet werden.

Nach einer Sicherheitsabfrage wird `lernsax.ini` gelöscht.

Zusätzlich:

- wird das Kennwortfeld geleert,
- wird die Option `Anmeldedaten merken` deaktiviert.

Auf dem Windows-Konto `nutzer` steht diese Funktion nicht zur Verfügung, weil dort ohnehin keine Daten gespeichert werden dürfen.

---

## 14. Verwendete AutoIt-Funktionen und Windows-Schnittstellen

### GUI

- `GUICreate()` – Programmfenster erzeugen
- `GUICtrlCreateInput()` – Eingabefelder
- `GUICtrlCreateButton()` – Schaltflächen
- `GUICtrlCreateCheckbox()` – Auswahl zum Speichern
- `GUICtrlCreateEdit()` – Laufwerksübersicht
- `GUIGetMsg()` – Benutzeraktionen verarbeiten
- `MsgBox()` – Meldungen und Warnungen

### Laufwerke

- `DriveMapAdd()` – Netzlaufwerk verbinden
- `DriveMapDel()` – Netzlaufwerk trennen
- `DriveMapGet()` – Netzwerkpfad eines Laufwerks ermitteln
- `DriveGetDrive()` – verfügbare Laufwerke auflisten
- `DriveGetType()` – Laufwerkstyp bestimmen

### Datei und Konfiguration

- `DirCreate()` – Datenordner erzeugen
- `IniWrite()` – Anmeldedaten speichern
- `IniRead()` – Anmeldedaten laden
- `FileDelete()` – gespeicherte Anmeldedaten löschen

### Kennwortschutz

- `CryptProtectData()` – Kennwort verschlüsseln
- `CryptUnprotectData()` – Kennwort entschlüsseln
- `StringToBinary()` – Text in Binärdaten umwandeln
- `BinaryToString()` – Binärdaten wieder in Text umwandeln

### Windows-Neustart

Bei nicht trennbaren LernSax-Verbindungen wird ausgeführt:

```bat
shutdown /r /f /t 0
```

---

## 15. Programmablauf im Überblick

```text
Programm starten
      │
      ▼
Vorhandene Laufwerke A: bis Z: prüfen
      │
      ▼
LernSax-Netzlaufwerke gefunden?
      │
      ├── nein ───────────────────────────────┐
      │                                      │
      └── ja                                 │
           │                                 │
           ▼                                 │
     Verbindungen trennen                    │
           │                                 │
           ▼                                 │
     vollständig getrennt?                   │
           │                                 │
      ┌────┴────┐                            │
      │         │                            │
     nein      ja                            │
      │         │                            │
      ▼         └────────────────────────────┘
 Warnung
      │
      ▼
 Windows-Neustart
      │
      └── Programmende


Bei erfolgreicher Bereinigung:

Anmeldedaten laden
      │
      ▼
Anmeldefenster anzeigen
      │
      ▼
Benutzername + Kennwort
      │
      ▼
Verbinden
      │
      ├── P: persönlicher storage
      ├── Y: Young Engineers storage
      └── M: Minecraft storage
      │
      ▼
Laufwerksübersicht aktualisieren
      │
      ▼
ggf. Anmeldedaten speichern
      │
      ▼
Ergebnis anzeigen
```

---

## 16. Beispiel für den praktischen Einsatz

Ein Nutzer meldet sich mit

```text
max.mustermann@mrge.lernsax.de
```

an.

Das Programm erzeugt:

```text
P: → \\www.lernsax.de@SSL\DavWWWRoot\webdav.php\max.mustermann@mrge.lernsax.de\storage
Y: → \\www.lernsax.de@SSL\DavWWWRoot\webdav.php\youngengineers@mrge.lernsax.de\storage
M: → \\www.lernsax.de@SSL\DavWWWRoot\webdav.php\ye-minecraft@mrge.lernsax.de\storage
```

Danach können andere Programme die LernSax-Dateien wie gewöhnliche Windows-Dateien verwenden.

Beispielsweise:

```text
M:\AG-Welten\Burgenland.zip
```

oder:

```text
Y:\Minecraft\Anleitungen\
```

Die genaue Verzeichnisstruktur innerhalb der LernSax-`storage`-Ordner hängt von den dort tatsächlich vorhandenen Dateien und Ordnern ab.

---

## 17. Sicherheitsaspekte

### Positiv

- Das Kennwort wird nicht im Klartext in der INI-Datei gespeichert.
- Das gespeicherte Kennwort ist über DPAPI an das Windows-Benutzerkonto gebunden.
- Auf dem gemeinsam genutzten Windows-Konto `nutzer` wird nichts gespeichert.
- Alte LernSax-Laufwerksverbindungen werden vor einer neuen Anmeldung bereinigt.
- Andere Netzlaufwerke werden beim Start nicht absichtlich getrennt.

### Zu beachten

- Wer Zugriff auf ein bereits angemeldetes Windows-Konto hat, kann die während dieser Sitzung eingebundenen LernSax-Laufwerke verwenden.
- Ein erzwungener Neustart mit `/f` kann nicht gespeicherte Daten in anderen Anwendungen verwerfen.
- Die Laufwerke `P:`, `Y:` und `M:` müssen für die Nutzung verfügbar sein.
- Änderungen an LernSax-WebDAV-Pfaden können Anpassungen am Programm erforderlich machen.

---

## 18. Wichtige Dateien

### Programm

```text
lernsax-anmelden-4-korrigiert-v3.au3
```

### Konfigurationsdatei

```text
%APPDATA%\YoungEngineers\lernsax.ini
```

Die INI-Datei existiert nur auf Windows-Konten, auf denen das Speichern von Anmeldedaten erlaubt ist und tatsächlich Daten gespeichert wurden.

---

## 19. Kurzbeschreibung für die Webseite

> `lernsax-anmelden` meldet einen Nutzer bei LernSax an und bindet den persönlichen Speicher sowie die gemeinsamen Bereiche „Young Engineers“ und „Minecraft“ als Windows-Netzlaufwerke ein. Vorhandene LernSax-Verbindungen werden beim Start automatisch bereinigt; Anmeldedaten können auf persönlichen Windows-Konten verschlüsselt gespeichert werden.

---

## 20. Zusammenfassung

Das Programm verbindet LernSax mit der gewohnten Windows-Laufwerksstruktur.

Die wesentlichen Aufgaben sind:

1. vorhandene LernSax-Netzlaufwerke erkennen und trennen,
2. bei nicht lösbaren Verbindungskonflikten einen Neustart erzwingen,
3. LernSax-Benutzername und Kennwort erfassen,
4. `P:`, `Y:` und `M:` als WebDAV-Netzlaufwerke verbinden,
5. alle verfügbaren Laufwerke übersichtlich anzeigen,
6. Anmeldedaten bei geeigneten Windows-Konten verschlüsselt speichern,
7. das Speichern auf dem gemeinsam genutzten Windows-Konto `nutzer` verhindern.

Damit können LernSax-Dateien in der AG von Windows-Programmen ähnlich wie Dateien auf lokalen oder klassischen Netzlaufwerken verwendet werden.
