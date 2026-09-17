# Kleine Burg in Minecraft 26.2 mit WorldEdit verwenden

Diese Anleitung erklärt Schritt für Schritt, wie die Datei `kleine_burg_minecraft_26_2.schem` in **Minecraft Java Edition 26.2** mit **Fabric + WorldEdit 7.4.x** verwendet wird.

Die Anleitung richtet sich an Einsteiger.

## 1. Voraussetzungen

Du brauchst:

- Minecraft Java Edition 26.2
- Fabric
- WorldEdit 7.4.x
- eine funktionierende Minecraft-Instanz, z. B. in MultiMC oder UltimMC
- die Datei `kleine_burg_minecraft_26_2.schem`

Die Burg ist ungefähr **27 × 13 × 27 Blöcke** groß.

Sie enthält unter anderem vier Ecktürme, Außenmauern mit Zinnen, ein Tor, einen Innenhof, einen zentralen Bergfried, Wege und Beleuchtung.

## 2. Was ist eine `.schem`-Datei?

Eine `.schem`-Datei ist eine gespeicherte Minecraft-Struktur. Sie kann mit WorldEdit geladen und an einer beliebigen Stelle in eine Welt eingefügt werden.

`*.schem` ist das aktuelle WorldEdit-/Sponge-Schematic-Format. Die ältere Endung `*.schematic` ist ein Legacy-Format.

## 3. Wo kommt die Datei hin?

Die Datei muss in den WorldEdit-Schematic-Ordner der verwendeten Minecraft-Instanz kopiert werden.

Typischer Pfad:

```text
.minecraft\config\worldedit\schematics\
```

Bei einer UltimMC- oder MultiMC-Instanz beispielsweise:

```text
UltimMC\
└─ instances\
   └─ <Name der Minecraft-Instanz>\
      └─ .minecraft\
         └─ config\
            └─ worldedit\
               └─ schematics\
                  └─ kleine_burg_minecraft_26_2.schem
```

Falls der Ordner `schematics` noch nicht existiert, kann er angelegt werden.

## 4. Minecraft starten

Starte die Minecraft-26.2-Instanz mit **Fabric + WorldEdit** und öffne eine Welt.

Zum ersten Test eignet sich eine flache Welt oder eine große freie Fläche.

## 5. Prüfen, ob WorldEdit die Datei gefunden hat

Gib im Chat ein:

```text
//schem list
```

WorldEdit sollte die Datei anzeigen:

```text
kleine_burg_minecraft_26_2.schem
```

Falls sie nicht erscheint, liegt sie wahrscheinlich im falschen Ordner.

## 6. Burg laden

Gib ein:

```text
//schem load kleine_burg_minecraft_26_2.schem
```

Tipp: Nach

```text
//schem load kle
```

kann häufig mit der `Tab`-Taste der Dateiname automatisch ergänzt werden.

## 7. Wo wird die Burg eingefügt?

Die Burg wird relativ zu deiner aktuellen Position eingefügt.

Der Einfügepunkt der Datei liegt ungefähr **mittig vor dem Haupttor**. Stelle dich also an die Stelle, an der der Eingang der Burg liegen soll.

## 8. Burg einfügen

Normal einfügen:

```text
//paste
```

Dabei werden auch Luftblöcke aus der Schematic eingefügt. Vorhandene Blöcke im Bereich der Burg können dadurch entfernt werden.

Für einen vorsichtigen ersten Versuch:

```text
//paste -a
```

Das `-a` bedeutet, dass Luftblöcke ignoriert werden.

## 9. Wenn die Burg falsch steht

Kein Problem. Der letzte WorldEdit-Befehl kann rückgängig gemacht werden:

```text
//undo
```

Danach an eine andere Stelle gehen und erneut einfügen:

```text
//paste -a
```

## 10. Burg drehen

Wenn das Tor in die falsche Richtung zeigt:

```text
//rotate 90
```

Danach:

```text
//paste -a
```

Weitere Möglichkeiten:

```text
//rotate 180
//rotate 270
```

Beispiel:

```text
//schem load kleine_burg_minecraft_26_2.schem
//rotate 90
//paste -a
```

## 11. Burg spiegeln

Eine geladene Schematic kann auch gespiegelt werden:

```text
//flip
```

Danach:

```text
//paste
```

Für Einsteiger ist `//rotate` meist einfacher.

## 12. Eigene Position anzeigen

Mit:

```text
F3
```

kannst du deine aktuelle Position sehen.

Wichtig sind:

```text
X
Y
Z
```

Beispiel:

```text
X = 120
Y = 64
Z = -35
```

## 13. Zu einer bestimmten Position gehen

Mit dem Minecraft-Befehl:

```text
/tp 120 64 -35
```

kannst du dich direkt zu einer Position teleportieren.

Anschließend:

```text
//paste -a
```

## 14. Eine Region mit WorldEdit auswählen

Hole dir die WorldEdit-Axt:

```text
//wand
```

Mit der Axt gilt normalerweise:

- Linksklick = Position 1
- Rechtsklick = Position 2

Alternativ:

```text
//pos1
//pos2
```

## 15. Burg kopieren

Wenn eine Burg bereits in der Welt steht und du sie kopieren möchtest:

1. Burg vollständig markieren.
2. Dann:

```text
//copy
```

3. Neue Position aufsuchen.
4. Dann:

```text
//paste
```

## 16. Eigene Schematic speichern

Eine ausgewählte Struktur kann selbst gespeichert werden:

```text
//copy
```

anschließend:

```text
//schem save meine_burg
```

Danach sollte sie bei:

```text
//schem list
```

erscheinen.

## 17. Die wichtigsten Befehle

### Schematics anzeigen

```text
//schem list
```

### Schematic laden

```text
//schem load kleine_burg_minecraft_26_2.schem
```

### Einfügen

```text
//paste
```

### Ohne Luftblöcke einfügen

```text
//paste -a
```

### Letzten Schritt rückgängig machen

```text
//undo
```

### Rückgängig gemachten Schritt wiederholen

```text
//redo
```

### Um 90 Grad drehen

```text
//rotate 90
```

### WorldEdit-Axt erhalten

```text
//wand
```

### Position 1 setzen

```text
//pos1
```

### Position 2 setzen

```text
//pos2
```

## 18. Typischer Ablauf für Anfänger

Der komplette Ablauf kann so aussehen:

```text
//schem list
//schem load kleine_burg_minecraft_26_2.schem
//paste -a
```

Gefällt die Position nicht:

```text
//undo
```

Dann an eine andere Stelle gehen und erneut:

```text
//paste -a
```

Soll die Burg gedreht werden:

```text
//undo
//rotate 90
//paste -a
```

## 19. Häufiger Fehler: Datei wird nicht gefunden

Wenn WorldEdit meldet, dass die Schematic nicht gefunden wurde:

```text
//schem list
```

ausführen.

Wenn die Datei dort nicht erscheint, kontrolliere:

```text
.minecraft\config\worldedit\schematics\
```

Der vollständige Dateiname lautet:

```text
kleine_burg_minecraft_26_2.schem
```

## 20. Häufiger Fehler: Endung vergessen

In manchen WorldEdit-Versionen funktioniert der Dateiname ohne Endung nicht zuverlässig.

Nicht:

```text
//schem load kleine_burg_minecraft_26_2
```

Sondern:

```text
//schem load kleine_burg_minecraft_26_2.schem
```

## 21. Häufiger Fehler: Burg steckt im Boden

Dann standest du beim Einfügen zu tief.

Lösung:

```text
//undo
```

Dann etwas höher gehen, z. B.:

```text
/tp ~ ~3 ~
```

und erneut:

```text
//paste -a
```

## 22. Häufiger Fehler: Burg schwebt

Dann standest du beim Einfügen zu hoch.

Wieder:

```text
//undo
```

Dann einige Blöcke tiefer gehen und erneut einfügen.

## 23. Gelände vorbereiten

Für den ersten Versuch eignet sich eine ebene Fläche.

Eine markierte Fläche kann beispielsweise vereinheitlicht werden:

```text
//set grass_block
```

Achtung: WorldEdit kann sehr große Bereiche verändern. Deshalb vor großen Befehlen immer die Auswahl kontrollieren.

## 24. Sicherheitsregel für WorldEdit

Vor jedem größeren WorldEdit-Befehl:

1. Auswahl kontrollieren.
2. Befehl prüfen.
3. Erst dann ausführen.

Wenn etwas schiefgeht:

```text
//undo
```

## 25. Empfohlene Übung

### Aufgabe 1

Importiere die Burg:

```text
//schem load kleine_burg_minecraft_26_2.schem
//paste -a
```

### Aufgabe 2

Entferne sie wieder:

```text
//undo
```

### Aufgabe 3

Drehe sie um 90 Grad:

```text
//rotate 90
//paste -a
```

### Aufgabe 4

Suche den Bergfried und bestimme seine ungefähren Koordinaten.

### Aufgabe 5

Verändere einen Turm.

### Aufgabe 6

Speichere die veränderte Burg als eigene Schematic.

## 26. Zusammenfassung

Für den ersten Import reichen diese drei Befehle:

```text
//schem list
//schem load kleine_burg_minecraft_26_2.schem
//paste -a
```

Die wichtigsten weiteren Befehle sind:

```text
//undo
//redo
//rotate 90
//wand
//pos1
//pos2
//copy
//schem save meine_burg
```

Damit kann die kleine Burg in wenigen Sekunden in eine Minecraft-Welt eingefügt, gedreht, verändert und als eigene Schematic gespeichert werden.
