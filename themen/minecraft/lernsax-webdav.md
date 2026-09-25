# Zusammenfassung: LernSax-WebDAV

## Ziel

Auf den Schul-PCs sollen bestimmte Bereiche von LernSax über WebDAV als Windows-Netzlaufwerk eingebunden werden. Dadurch können AG-Mitglieder Dateien zwischen LernSax und dem lokalen Computer austauschen.

## Bereits vorhandene Schulnetzlaufwerke

Nach der Anmeldung am Schul-PC sind diese Laufwerke belegt:

| Laufwerk | Schulnetzwerk-Pfad |
|---|---|
| `H:` | `\\server\default-school\teachers\l1057` |
| `K:` | `\\server\default-school\program` |
| `P:` | `\\server\default-school\share\projects` |
| `R:` | `\\server\default-school\iso` |
| `T:` | `\\server\default-school\share` |

Diese Laufwerke dürfen durch das LernSax-Programm nicht verändert oder getrennt werden.

### Laufwerke für LernSax

Für LernSax wurden deshalb andere Buchstaben mit der Überlegung:

| Laufwerk | LernSax-Bereich |
|---|---|
| `L:` | persönlicher LernSax-Dateibereich |
| `Y:` | Young Engineers |
| `M:` | Minecraft |

Eine Verbindung zu Lernsax per WebDAV kann über die `Eingabeaufforderung` mittels einzelner Kommando's realisiert werden.
```
net use L: "\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\andreas.sigismund@mrge.lernsax.de/storage" /user:"andreas.sigismund@mrge.lernsax.de" * /persistent:no
net use Y: "\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\youngengineers@mrge.lernsax.de/storage" /user:"andreas.sigismund@mrge.lernsax.de" * /persistent:no
net use M: "\\www.lernsax.de@SSL\DavWWWRoot\webdav.php\ye-minecraft@mrge.lernsax.de/storage" /user:"andreas.sigismund@mrge.lernsax.de" * /persistent:no   
```
in Verbindung mit dem Kennwort des Lernsax-Nutzers erfolgen.
Werden nach 
```
net use   
M:   \\www.lernsax.de@SSL\webdav.php\ye-minecraft@mrge.lernsax.de/storage
P:   \\www.lernsax.de@SSL\webdav.php\andreas.sigismund@mrge.lernsax.de/storage
Y:   \\www.lernsax.de@SSL\webdav.php\youngengineers@mrge.lernsax.de/storage
```


Damit gibt es keine Überschneidung mit den bekannten Schulnetzlaufwerken.

### Programm

Die Anmeldung und Laufwerkszuordnung erfolgt mit dem AutoIt-Programm:

```text
lernsax-webdav.au3
```

Das Programm soll:

- die LernSax-Zugangsdaten abfragen,
- die drei WebDAV-Verbindungen herstellen,
- vorhandene Schulnetzlaufwerke nicht verändern,
- bereits korrekt verbundene LernSax-Laufwerke erneuern,
- bei einer tatsächlichen Laufwerksbelegung eine Warnung anzeigen.

### Nächster Test

1. Die korrigierte `.au3`-Datei mit AutoIt kompilieren.
2. Die neue `.exe` auf dem Schul-PC starten.
3. LernSax-Zugangsdaten eingeben.
4. Im Windows-Explorer prüfen, ob `L:`, `Y:` und `M:` erscheinen.
5. Auf jedem Laufwerk testweise eine kleine Datei kopieren.
6. Kontrollieren, dass `H:`, `K:`, `P:`, `R:` und `T:` unverändert bleiben.

Die lokalen Schulnetzbereiche `10.9.12.x` und `10.9.14.x` betreffen hauptsächlich den AG-Server. Der LernSax-WebDAV-Zugriff erfolgt über das Internet und ist grundsätzlich nicht an eines dieser beiden lokalen Teilnetze gebunden.