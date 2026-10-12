# Das Geheimnis der beiden Banner
## Leitfaden für die Spielleitung

Stand: 12. Oktober 2026  
Regelgrundlage: Capture the Flag, Version 0.4  
Zielgruppe: Minecraft-AG, bis zu zehn Spieler

## 1. Ziel und aktueller Entwicklungsstand

Zwei möglichst gleich große Mannschaften treten als Rotfels und Blauburg gegeneinander an. Sie erobern die gegnerische Flagge, verteidigen die eigene Basis und entwickeln gemeinsame Strategien.

**Bereits vorbereitet:**
- Welt mit zwei Burgen, drei Brücken, Deckung und markierten Startbereichen.
- Automatische, zufällige Mannschaftszuordnung.
- Farbige Teamnamen und Teleportation zu den Startpunkten.
- Befehle für Start, Status, Stopp und Zurücksetzen.

**Noch nicht umgesetzt:**
- Flaggenaufnahme, Transport, Verlust und Rückgabe.
- Punktevergabe und 15-Minuten-Timer.
- Einheitliche Ausrüstung und fünf Sekunden Wiedergeburtswartezeit.
- Bauverbot und Schutz der Spawnzonen.

Die aktuelle Welt eignet sich für Erkundung und Teamtests. Das vollständige Spiel beginnt erst, wenn diese Funktionen umgesetzt und geprüft sind.

## 2. Vorbereitung vor der AG

### Welt und Technik

- Eine unveränderte Ausgangskopie der Welt aufbewahren.
- Für jeden Test oder Spieltermin eine Arbeitskopie verwenden.
- Welt auf dem Gastgeber-PC in Minecraft Java 26.2 öffnen.
- Beim ersten Öffnen die notwendige Weltenaktualisierung durchführen.
- LAN-Freigabe prüfen; IP-Adresse und Port für direkte Verbindungen notieren.
- Befehle für die Spielleitung erlauben, für die übrigen Spieler ausschalten.
- Eindeutige Spielernamen nach dem vereinbarten Schema verwenden.

### Datapacks und Startpunkte

Im Chat des Gastgebers:

/reload
/datapack list enabled
/function bannerwelt:vorbereiten

In der Liste müssen diese Datapacks erscheinen:

- CTF_AUTO_Phase1_0.1.0.zip
- Bannerwelt_Setup

Wenn der Gastgeber ausschließlich leitet:

/tag @s add ctf.leitung

Wenn der Gastgeber mitspielt:

/tag @s remove ctf.leitung

Das Spielleiter-Tag verhindert nur die Aufnahme in die automatische Verteilung. Es gewährt keinen Schutz und aktiviert keinen Zuschauermodus.

### Spielfeld kontrollieren

- Sind beide Startpunkte frei und sicher?
- Sind Haupt- und Seitentore begehbar?
- Können alle drei Brücken erreicht werden?
- Sind Flaggenplätze und Startbereiche gut erkennbar?
- Wurde die Karte durch frühere Erkundungen verändert?

## 3. Einstieg mit den Spielern

1. Die Geschichte „Das Geheimnis der beiden Banner“ vorlesen.
2. Beide Basen, Flaggenplätze und die drei Wege zeigen.
3. Die wichtigsten Regeln erläutern.
4. Fragen der Spieler sammeln.
5. Klar benennen, ob heute eine Erkundung, ein Teamtest oder ein vollständiges Spiel stattfindet.

### Die wesentlichen Regeln des vollständigen Spiels

- Zwei Teams: Rot und Blau.
- Spieldauer: 15 Minuten.
- Ein Punkt für die gegnerische Flagge in der eigenen Basis.
- Die eigene Flagge muss dafür zu Hause sein.
- Beim Tod des Trägers fällt die Flagge auf den Boden.
- Eigene Flagge aufheben: sofortige Rückgabe zur eigenen Basis.
- Nach 60 Sekunden ununterbrochen auf dem Boden: automatische Rückgabe.
- Nach dem Tod: fünf Sekunden Wartezeit.
- Gleiche Ausrüstung für alle.
- Kein Bauen oder Abbauen.
- PvP nur außerhalb geschützter Spawnzonen.
- Gleichstand bedeutet Unentschieden.

## 4. Durchführung des aktuellen Phase-1-Tests

Dieser Test prüft die Teamverwaltung, nicht die grundlegende LAN-Funktion. Gemeinsames LAN-Spiel mit bis zu zehn Spielern wurde bereits erprobt.

### Ablauf

1. Alle Teilnehmer betreten die Welt.
2. Spielleiter und weitere Zuschauer gegebenenfalls mit `ctf.leitung` ausschließen.
3. Prüfen, ob zwei bis zehn Teilnehmer für die Verteilung bereitstehen.
4. Teamtest starten:

/function ctf:start

5. Zuordnung kontrollieren:

/function ctf:status

6. Spieler prüfen ihre Teamfarbe und Startposition.
7. Teamtest beenden:

/function ctf:stopp

8. Erneut starten und die neue Verteilung prüfen:

/function ctf:start

9. Zum Abschluss Teams leeren:

/function ctf:reset

### Erwartetes Verhalten

| Prüfung | Erwartung |
|---|---|
| Gerade Teilnehmerzahl | Gleich große Teams |
| Ungerade Teilnehmerzahl | Unterschied von höchstens einem Spieler |
| Erneuter Start während eines laufenden Tests | Keine neue Verteilung |
| Stopp und anschließender Start | Neue zufällige Verteilung |
| Neuer Spieler tritt während des Tests bei | Keine automatische Teamaufnahme |
| Teilnehmer meldet sich ab und wieder an | Team bleibt erhalten, sofern inzwischen kein Start oder Reset erfolgt ist |
| Reset | CTF-Teams werden geleert; Startpunkte bleiben gespeichert |

**Wichtig:** `ctf:stopp` beendet die Testverwaltung. Der Befehl verhindert derzeit keine Kämpfe. Auch der Spielmodus wird durch Phase 1 nicht geändert.

## 5. Durchführung des vollständigen Spiels

Dieser Ablauf gilt erst nach Fertigstellung und Prüfung der Spielmechanik.

### Vor dem Start

- Alle Spieler sind verbunden.
- Teams werden automatisch verteilt.
- Jeder kennt seine Basis und seinen Startbereich.
- Alle erhalten die festgelegte Ausrüstung.
- Beide Flaggen befinden sich an ihren Ausgangspositionen.
- Punktestand und Spielzeit sind zurückgesetzt.
- Jedes Team erhält kurz Zeit zur
