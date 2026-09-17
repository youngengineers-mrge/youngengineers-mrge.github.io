# UltimMC in der AG „Young Engineers“

## 1. Überblick

`UltimMC` ist ein auf `MultiMC` basierender Minecraft-Launcher für die **Java Edition**.

In der AG wird `UltimMC` auf den Schul-PCs eingesetzt, weil die normale Anmeldung über Microsoft-Konten im praktischen AG-Betrieb problematisch sein kann:

- viele jüngere Schülerinnen und Schüler kennen ihre Zugangsdaten nicht sicher,
- teilweise stehen keine persönlichen PC- oder Netzwerk-Anmeldedaten zur Verfügung,
- die Schul-PCs werden deshalb über ein gemeinsam bekanntes lokales Windows-Konto genutzt,
- die AG soll möglichst ohne Administratorrechte funktionieren.

Die korrekte Schreibweise lautet:

```text
UltimMC
```

Nicht:

```text
UltiMC
Ultimmc
UltimMc
```

---

## 2. Einsatzort auf den Schul-PCs

`UltimMC` liegt auf den Schul-PCs unter:

```text
C:\Users\Public\Programme\UltimMC\
```

Der Ordner wurde bewusst gewählt, weil dort mit dem gemeinsamen lokalen Windows-Konto ohne Administratorrechte gearbeitet werden kann.

Typischer Aufbau:

```text
C:\Users\Public\Programme\UltimMC\
├─ UltimMC.exe
├─ instances\
│  └─ <Instanzname>\
│     └─ .minecraft\
│        ├─ mods\
│        ├─ saves\
│        ├─ config\
│        └─ ...
└─ weitere Launcher-Dateien
```

---

## 3. Verwendete Minecraft-Umgebung

Für die AG wird vor allem folgende Kombination genutzt:

```text
Minecraft Java Edition
+ UltimMC
+ Fabric
+ WorldEdit
```

Damit können unter anderem folgende Themen bearbeitet werden:

- Arbeiten mit Koordinaten
- Bauen mit WorldEdit
- `//pos1`
- `//pos2`
- `//set`
- `//walls`
- `//schem load`
- `//paste`
- Redstone
- digitale Schaltungen
- Automatisierung
- Import vorbereiteter Strukturen und Welten

---

## 4. Unterschied zu MultiMC

`UltimMC` basiert technisch stark auf `MultiMC`.

Beide Launcher verwenden ein Instanzkonzept:

```text
Launcher
└─ Instanzen
   ├─ eigene Minecraft-Version
   ├─ eigene Mods
   ├─ eigene Konfiguration
   └─ eigene Welten
```

Dadurch lassen sich verschiedene Minecraft-Versionen und Mod-Konfigurationen voneinander trennen.

### MultiMC

`MultiMC` ist für reguläre Minecraft-Konten und normale Authentifizierung gedacht.

Bei einem angemeldeten Microsoft-/Minecraft-Konto können im Launcher Authentifizierungsdaten bzw. Tokens gespeichert werden.

### UltimMC

`UltimMC` ermöglicht eine Nutzung ohne normale Microsoft-Anmeldung.

Das ist für die AG organisatorisch praktisch, weil dadurch keine persönlichen Microsoft-Zugangsdaten auf den gemeinsam genutzten Schul-PCs gespeichert werden müssen.

---

## 5. Sicherheitsaspekte

Die Schul-PCs werden teilweise mit einem allen bekannten lokalen Windows-Konto verwendet.

Damit gibt es praktisch keine Benutzertrennung zwischen den Schülerinnen und Schülern.

Alles, was dieses gemeinsame Windows-Konto lesen kann, kann grundsätzlich auch kopiert werden.

Alles, worauf dieses Konto Schreibrechte besitzt, kann grundsätzlich auch verändert oder gelöscht werden.

### Risiko bei MultiMC mit persönlichem Konto

Ein angemeldetes `MultiMC` in einem frei zugänglichen Ordner wie

```text
C:\Users\Public\Programme\MultiMC\
```

wäre problematisch.

Bei gespeicherten Konten können Authentifizierungs-Tokens vorhanden sein.

Ein kopierter Launcher-Ordner könnte deshalb unter Umständen auch eine noch gültige Minecraft-Anmeldung enthalten.

Deshalb sollte auf einem gemeinsam genutzten Windows-Konto kein persönliches Microsoft-/Minecraft-Konto dauerhaft gespeichert werden.

### Risiko auch bei UltimMC

Auch bei `UltimMC` bleibt ein anderes Risiko bestehen:

```text
C:\Users\Public\Programme\UltimMC\
```

ist für das gemeinsame Konto beschreibbar.

Dadurch könnten Schülerinnen und Schüler beispielsweise:

- Mods verändern,
- Konfigurationsdateien verändern,
- Welten löschen,
- Dateien versehentlich überschreiben,
- Bestandteile einer Instanz beschädigen.

---

## 6. Master-Version

Für die AG existiert eine geprüfte **Master-Version** von `UltimMC`.

Diese dient als saubere Referenz.

Prinzip:

```text
UltimMC_MASTER
    ↓
geprüfte Arbeitskopie
    ↓
Schul-PC
    ↓
C:\Users\Public\Programme\UltimMC\
```

Wenn eine Installation beschädigt oder verändert wurde, kann die Arbeitskopie wieder aus der Master-Version hergestellt werden.

Vorteile:

- einheitlicher Stand auf allen PCs,
- getestete Minecraft-Version,
- getestete Fabric-Version,
- getestete WorldEdit-Version,
- schnelle Wiederherstellung,
- keine Administratorrechte erforderlich.

---

## 7. Welten der Schülerinnen und Schüler

Die Schülerinnen und Schüler sollen lernen, mit vorgegebenen Welten zu arbeiten.

Die Welten liegen innerhalb der jeweiligen Instanz typischerweise unter:

```text
UltimMC\
└─ instances\
   └─ <Instanzname>\
      └─ .minecraft\
         └─ saves\
            └─ <Weltname>\
```

Beispiel:

```text
saves\
├─ YE_WorldEdit_01
├─ YE_Redstone_01
├─ YE_Tinkercad_Import
├─ Gruppe_01
└─ Gruppe_02
```

---

## 8. Sicherung über LernSax

Eigene Minecraft-Welten können von den Schülerinnen und Schülern über ihren **LernSax-Zugang** gesichert werden.

Wichtig ist die Regel:

> Nicht die gesamte Minecraft-Installation sichern, sondern nur den eigenen Weltordner.

Beispiel:

```text
saves\Meine_Welt\
```

Dieser Ordner kann nach LernSax kopiert und bei Bedarf später wieder zurückgesichert werden.

Dadurch können:

- persönliche Arbeitsergebnisse erhalten bleiben,
- beschädigte lokale Installationen ersetzt werden,
- Welten zwischen AG-Terminen gesichert werden.

---

## 9. Lokales Netzwerk

`UltimMC` wird in der AG nur im lokalen Netz des Klassenraums eingesetzt.

Das hat praktische Vorteile:

- keine öffentlichen Minecraft-Server notwendig,
- kein Zugriff auf fremde öffentliche Server erforderlich,
- überschaubare Netzwerkumgebung,
- keine persönlichen Microsoft-Konten auf den Schul-PCs notwendig,
- gemeinsame Arbeit innerhalb des Klassenraums möglich.

Die Beschränkung auf das lokale Netzwerk ändert jedoch nichts an möglichen Lizenzfragen.

---

## 10. Verhältnis zu Minecraft Education

`Minecraft Education` wurde in der AG bereits mehrere Jahre genutzt.

Positive Erfahrungen:

- sehr gute Lernwelten,
- besonders interessant ist das Programmieren,
- Agent und MakeCode machen Schleifen, Bedingungen und Koordinaten anschaulich.

Probleme im praktischen Einsatz:

- Anmeldung kann schwierig sein,
- Schüler kennen ihre Zugangsdaten teilweise nicht,
- Verfügbarkeit der Konten kann problematisch sein,
- die Programmierumgebung bleibt gelegentlich hängen,
- viele hochwertige Welten sind nur auf Englisch verfügbar,
- Schülerinnen und Schüler der Klassen 5 und 6 sind damit häufig überfordert.

Hinzu kommt der AG-Zeitraum am Freitagnachmittag von 13:30 bis 15:10 Uhr, wodurch einfache und stabile Abläufe besonders wichtig sind.

---

## 11. Welten aus Minecraft Education

Welten aus `Minecraft Education` sind nicht einfach auf die Java Edition übertragbar.

Gründe:

- anderes Weltformat,
- Education basiert technisch auf der Bedrock-Familie,
- Education-spezifische Blöcke,
- NPCs,
- Chemie-Funktionen,
- spezielle Verhaltenspakete,
- eigene Unterrichtsmechanismen.

Für `Minecraft Java + Fabric + WorldEdit` können solche Welten deshalb nicht direkt verwendet werden.

Eine mögliche Alternative ist:

```text
gute Education-Lernidee
        ↓
didaktisch übernehmen
        ↓
eigene deutschsprachige Java-Welt erstellen
```

---

## 12. Lizenzrechtlicher Hinweis

Die Nutzung eines alternativen Launchers ist nicht automatisch rechtswidrig.

Entscheidend ist, ob die jeweilige Nutzung durch eine gültige Minecraft-Lizenz gedeckt ist.

Problematisch kann eine Nutzung werden, wenn Schülerinnen und Schüler Minecraft Java verwenden, ohne selbst über eine entsprechende Berechtigung zu verfügen bzw. wenn eine Lizenzprüfung bewusst umgangen wird.

Die Beschränkung auf das lokale Klassenraum-Netz ändert diese Lizenzfrage nicht.

Die zwei privat vorhandenen Minecraft-Lizenzen werden dadurch nicht automatisch zu einer Klassen- oder Schullizenz.

Dieser Punkt sollte deshalb getrennt von der technischen Funktionsfähigkeit betrachtet werden.

---

## 13. Bezeichnung in öffentlichen AG-Dokumenten

In den öffentlich verfügbaren Dokumenten unter

```text
youngengineers-mrge.github.io
```

soll nach aktueller Planung überwiegend die Bezeichnung

```text
MultiMC
```

verwendet werden.

Technisch ist jedoch zu beachten:

- `MultiMC` und `UltimMC` sind nicht dasselbe Programm,
- `UltimMC` ist ein Fork von `MultiMC`,
- konkrete Funktionen von `UltimMC` sollten nicht `MultiMC` zugeschrieben werden, wenn sie dort nicht vorhanden sind.

Für allgemeine Beschreibungen kann gegebenenfalls neutral formuliert werden:

```text
MultiMC-basierter Minecraft-Launcher
```

---

## 14. Zusammenfassung

Für die AG erfüllt `UltimMC` vor allem diese praktischen Anforderungen:

```text
keine Administratorrechte
+ gemeinsames lokales Windows-Konto
+ keine dauerhafte persönliche Microsoft-Anmeldung
+ vorbereitete Minecraft-Instanzen
+ Fabric
+ WorldEdit
+ lokales Klassenraum-Netz
+ Master-Version
+ Sicherung der Schülerwelten über LernSax
```

Die technische Lösung ist für den praktischen AG-Betrieb sehr komfortabel.

Davon getrennt sollten weiterhin die Lizenzbedingungen von Minecraft betrachtet werden.
