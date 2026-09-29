Aufgabenliste aktualisiert

Ich fasse das aktive Projekt `AG-Server` zusammen. Dafür prüfe ich seine Dateien und die vorhandene Projektdokumentation, damit die Übersicht den aktuellen Server, seine Funktionen und die Wartungsskripte abdeckt.

Die Projektstruktur bestätigt einen Windows-basierten Python-Dateiserver mit Weboberfläche; Teil 2 ist ein separates Arduino-Installationsskript mit eigener Erfolgsmarkierung. Ich lese jetzt Startskript, Weboberfläche und die HTTP-Routen nach, damit die Zusammenfassung auch Betrieb und Zugriffsschutz korrekt beschreibt.

Die Anleitung beschreibt Upload/Download, Minecraft und lokale Wartungsfunktionen; der Start erfolgt über eine kleine Batchdatei mit `python ag_server.py`. Ein Verzeichnisaufruf war nur mit falschem Zwischenpfad adressiert. Ich lese jetzt die Handler und Wartungsdateien direkt am aktiven Projektpfad, um Zugriffsbeschränkungen und Paketumfang vollständig einzuordnen.

**Zusammenfassung: AG-Server**

Das aktive Projekt unter `AG-Server` ist ein Python-basierter Datei- und Minecraft-Server für ein lokales Netzwerk. Der Server nutzt `ThreadingHTTPServer`, lauscht auf Port `8000` und stellt statische HTML-Seiten sowie dynamische Verzeichnisansichten bereit. Der Start erfolgt über `AG-Server-starten.bat` oder direkt mit `python ag_server.py`.

**Funktionen**
- Upload, Download und Verwaltung von Dateien; Uploads sind auf 200 MB begrenzt.
- Minecraft-Dateibereiche für Mods, Resourcepacks, Welten und Schematics; ausgewählte Dateitypen werden geprüft.
- Wartungsbereich für zusätzliche Dateien und Skripte.
- Transferprotokoll mit rotierenden Logdateien unter `%LOCALAPPDATA%\YoungEngineers\AG-Server`.
- Startseite und Anleitung in `index.html` und `anleitung.html`.

Die HTTP-Routen und Zugriffsbeschränkungen sind in `ag_server.py:930` implementiert. Administrative Dateioperationen und das Transferprotokoll sind auf den Server-PC beschränkt; der Server hat aber keine allgemeine Benutzeranmeldung.

Im Wartungsordner liegen mehrere Installationsskripte, darunter `ag-tool.cmd` für mehrere Pakete und `ag-tool-part_2.cmd` für Arduino IDE. Die Skripte können Archive herunterladen und entpacken und verwenden Erfolgsmarkierungen, um Wiederholungen zu verhindern.

**Hinweis zur Dokumentation:** Die workspaceweite Datei `AG-Server.md` beschreibt offenbar einen älteren Testserver auf Port `8765`. Die Anleitung im aktiven Projekt verweist außerdem noch auf `ag-tool.py`, während dort derzeit CMD-Skripte liegen.
