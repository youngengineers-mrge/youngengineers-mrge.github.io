**Korrektur:** Keine Fehler. ✅

Auf Basis der drei aktuellen Dateien `ag_server.py`, `index.html` und `ag-tool.cmd` würde ich das Projekt so beschreiben:

## Projekt `AG-Server` – aktueller Stand

Der **AG-Server** ist ein kleiner, portabler Webserver für die Arbeitsgemeinschaften des Martin-Rinckart-Gymnasiums. Er soll insbesondere auf Schul-PCs eine einfache Dateiablage, den Austausch von AG-Dateien und die **Bereitstellung bzw. Einrichtung portabler Software ohne klassische Installation** ermöglichen.

Der Server basiert auf Python und läuft auf **Port 8000**. Beim Start ermittelt er die lokale IP-Adresse des Rechners, gibt die vollständige Browseradresse sowie die verwendeten Upload-, Download- und Protokollpfade aus und öffnet anschließend die Serveroberfläche im Browser. Der HTTP-Server arbeitet mit mehreren Threads. :chatgpt-content-reference{index="0"}

### Weboberfläche

`index.html` bildet die zentrale Benutzeroberfläche. Sie bietet derzeit Zugänge für:

- allgemeinen **Datei-Upload** per Dateiauswahl oder Drag & Drop,
- **Datei-Download**,
- das Upload-Verzeichnis,
- die **Minecraft-Dateiablage**,
- eine Anleitung,
- sowie einen gesonderten Bereich **Wartungsarbeiten**.

Dateien dürfen beim allgemeinen Upload maximal **200 MB** groß sein. :chatgpt-content-reference{index="1"}

Der Wartungsbereich stellt insbesondere das Wartungsskript `ag-tool.cmd`, ein Wartungsarchiv, eine Anleitung und den Zugang zum Wartungsverzeichnis bereit. :chatgpt-content-reference{index="2"}

### Dateiablage und Verwaltung

Der Python-Server verwaltet eigene Bereiche für `upload`, `download`, `wartung` und `minecraft`. Beim Start werden die benötigten Verzeichnisse automatisch angelegt. Für Minecraft existiert bereits eine vorbereitete Struktur für die Instanz **26.2** mit `mods`, `resourcepacks`, `saves` und `schematics`. :chatgpt-content-reference{index="3"}

Über die Weboberfläche können Dateien aufgelistet, gefiltert und heruntergeladen werden. Auf dem **Server-PC selbst** stehen zusätzliche Verwaltungsfunktionen wie Hochladen und Löschen zur Verfügung. Der Server unterscheidet dabei zwischen einem lokalen Zugriff und Zugriffen anderer Rechner. :chatgpt-content-reference{index="4"}

### Minecraft

Der AG-Server besitzt einen eigenen Minecraft-Bereich mit getrenntem **Download- und Upload-Modus**. Die Verzeichnisstruktur kann im Browser durchlaufen werden. :chatgpt-content-reference{index="5"}

Für die vorbereitete Minecraft-Instanz werden bestimmte Dateitypen gezielt unterstützt:

```text
mods            → .jar
resourcepacks   → .zip
saves           → .zip
schematics      → .schem, .schematic, .nbt
```

:chatgpt-content-reference{index="6"}

### Transferprotokoll

Uploads, Downloads und Löschvorgänge werden protokolliert. Dabei werden unter anderem Zeitpunkt, Serverrechner, Client-IP, Datei, Datenmenge und HTTP-Status gespeichert. Die Protokolldateien rotieren bei 2 MB; bis zu fünf ältere Protokolle werden aufbewahrt. :chatgpt-content-reference{index="7"}

Das Transferprotokoll kann über eine eigene Webseite angezeigt, gefiltert und nach verschiedenen Kriterien sortiert werden. Dieser Zugriff ist auf den Server-PC beschränkt. :chatgpt-content-reference{index="8"}

## Wartung und portable Software

`ag-tool.cmd` bildet inzwischen einen zweiten wichtigen Teil des Projekts. Das Skript dient dazu, **portable Programme auf einem Schul-PC automatisch bereitzustellen**.

Der gegenwärtige Ablauf ist:

```text
AG-Server
    │
    │ HTTP :8000
    ▼
ag-tool.cmd auf dem Schul-PC
    │
    ├── curl.exe → Softwarearchive herunterladen
    │
    ├── 7-Zip    → Archive entpacken
    │
    └── C:\Users\Public\Programme\
```

Das Skript prüft zunächst, ob 7-Zip bereits unter `C:\Program Files\7-Zip\7z.exe` oder als portable Version vorhanden ist. Fehlt es, kann es die benötigten 7-Zip-Werkzeuge selbst herunterladen und bereitstellen.

Anschließend bezieht `ag-tool.cmd` die Softwarearchive über

```text
http://192.168.2.107:8000/wartung/download
```

und installiert sie nicht im klassischen Sinn, sondern **entpackt die vorbereiteten portablen Pakete nach `C:\Users\Public\Programme\`**.

Aktuell verarbeitet das Skript:

```text
thonny-5.0.0-windows-portable-x64.zip
ChromiumPortable.zip
WinPython64-3.14.7.0dot.zip
Prusa3D.zip
```

Nach erfolgreichem Abschluss erzeugt es

```text
C:\Users\Public\Programme\ag-tool-v1.0-erfolgreich.txt
```

als Markierungsdatei. Existiert diese beim nächsten Aufruf, wird die Softwarebereitstellung nicht erneut ausgeführt.

### Softwaredepot

Aus unserem aktuellen Arbeitsstand gehört außerdem das Verzeichnis

```text
wartung\download\
```

zum Konzept. Dort liegen die von dir geprüften bzw. vorbereiteten Softwarearchive, momentan unter anderem:

```text
7z2603-extra.zip
Arduino IDE.zip
chrome-win64.zip
ChromiumPortable.zip
FirefoxPortable.zip
Prusa3D.zip
thonny-5.0.0-windows-portable-x64.zip
WinPython64-3.14.7.0dot.zip
```

Noch **nicht alle diese Archive werden vom aktuellen `ag-tool.cmd` verarbeitet**. Insbesondere Arduino IDE, Firefox und Chrome sind damit bereits für die nächste Ausbaustufe vorbereitet.

## Ablage des Projekts

Nach deinem aktuellen Aufbau gibt es bewusst zwei unterschiedliche Projektstände:

```text
D:\Github\Andreas519\Lehrer-PC-415
```

ist die Entwicklungs- und GitHub-Arbeitskopie. Die großen Softwarearchive aus `wartung\download` werden **nicht nach GitHub übertragen**.

Die **vollständige Fassung einschließlich der Softwarearchive** befindet sich dagegen auf deinem hellgrünen AG-USB-Stick. Damit kann der AG-Server samt Softwaredepot auch unabhängig von GitHub in die Schule gebracht werden.

### Zielbild

Damit entwickelt sich `AG-Server` von einer einfachen Dateiablage zu einem **lokalen Werkzeugkasten für die AG-Arbeit im Schulnetz**:

```text
                         AG-Server
                             │
          ┌──────────────────┼──────────────────┐
          │                  │                  │
     Dateiablage         Minecraft          Wartung
          │                  │                  │
    Upload/Download    Welten/Mods/       portable
                       Schematics          Software
                                              │
                                         ag-tool.cmd
                                              │
                                     Schul-PC einrichten
```

Der entscheidende Vorteil ist dabei: **Die Schul-PCs müssen die benötigte AG-Software nicht selbst aus dem Internet beziehen.** Der AG-Server stellt die von dir ausgewählten und vorbereiteten Versionen im lokalen Netz bereit; `ag-tool.cmd` übernimmt Download und Entpacken. Das passt sehr gut zu der Situation ohne administrative Installationsrechte.