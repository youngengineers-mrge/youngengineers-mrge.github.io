Korrektur: „Erstelle eine Zusammenfassung ab meinem Prompt: ‚~~in~~ **Ein** Modell mit Python in ein Blockraster umwandeln. Gib uns eine ~~ANleitung~~ **Anleitung** zum Testen.‘“

## Zusammenfassung: STL-Modell mit Python in ein Minecraft-Blockraster umwandeln

### Ausgangsziel

Wir wollten testen, ob sich ein in **Tinkercad bzw. Autodesk Fusion erzeugtes 3D-Modell** per Python in ein Raster aus Würfeln zerlegen lässt, das anschließend als Grundlage für ein Minecraft-Modell dienen kann.

Geplanter Weg:

```text
Tinkercad / Fusion
        ↓
       STL
        ↓
      Python
        ↓
   Blockraster
        ↓
 Minecraft-Blöcke
        ↓
      .schem
        ↓
    WorldEdit
```

### 1. Erster Test mit `trimesh`

Als Python-Bibliothek wurde `trimesh` verwendet.

Das STL-Modell wurde eingelesen und zunächst mit

```python
voxels = mesh.voxelized(pitch=BLOCKGROESSE)
```

voxelisiert.

Beim ersten Test mit:

```python
BLOCKGROESSE = 10.0
```

ergab sich:

```text
Abmessungen: [100.  10.  50.]
Geschlossen: True
Rastergröße: (11, 1, 6)
Belegte Blöcke: 66
```

Das Raster war zu grob, um die Zinnen der Burgmauer zuverlässig darzustellen.

### 2. Rasterweite auf 5 mm verkleinert

Mit:

```python
BLOCKGROESSE = 5.0
```

ergab sich:

```text
Abmessungen: [100.  10.  60.]
Geschlossen: True
Rastergröße: (21, 3, 13)
Belegte Blöcke: 602
```

Die Zinnen wurden nun erkannt.

Die X/Z-Darstellung zeigte bereits die Kontur:

```text
██████....██████..██████....██████..██████
██████....██████..██████....██████..██████
██████████████████████████████████████████
...
```

### 3. Blockmodell wieder als STL ausgegeben

Mit:

```python
blockmodell = voxels.as_boxes()
blockmodell.export("blockraster.stl")
```

wurde aus den Voxeln wieder eine STL-Datei erzeugt.

Diese wurde erfolgreich in:

* Tinkercad
* PrusaSlicer

importiert.

Damit konnte visuell überprüft werden, dass die Form des ursprünglichen Modells erhalten bleibt.

Allerdings zeigte sich ein Problem:

```text
Original:      100 × 10 × 60 mm
Voxelmodell:   105 × 15 × 65 mm
```

Die automatische Trimesh-Voxelisierung fügt an den Modellgrenzen zusätzliche Rasterpositionen hinzu.

### 4. Deshalb: eigenes Raster statt `voxelized()`

Wir haben anschließend ein eigenes Raster definiert.

Bei:

```python
BLOCK = 5.0
```

ergibt sich aus:

```text
100 × 10 × 60 mm
```

exakt:

```text
20 × 2 × 12 Rasterzellen
```

Die Mittelpunkte der Rasterzellen werden berechnet und anschließend mit:

```python
mesh.contains(punkte)
```

darauf geprüft, ob sie innerhalb des STL-Körpers liegen.

### 5. Fehlendes Paket `rtree`

Beim ersten Lauf erschien:

```text
ModuleNotFoundError: No module named 'rtree'
```

`mesh.contains()` benötigt `rtree`.

Nach der Installation funktionierte die Punktprüfung.

Ergebnis:

```text
Eigenes Raster: [20  2 12]
Belegte Blöcke: 432
```

### 6. Problem mit unterschiedlich breiten Zinnen

Die erste Darstellung zeigte:

```text
████......██......████......██......████
```

also Zinnen mit:

```text
2 – 1 – 2 – 1 – 2 Blöcken
```

Ursache war, dass einige Prüfpunkte genau auf einer STL-Grenzfläche lagen.

Deshalb wurde ein sehr kleiner Versatz eingeführt:

```python
EPS = 0.001
pruefpunkte = punkte + np.array([EPS, EPS, EPS])

innen = mesh.contains(pruefpunkte)
```

Danach ergab sich:

```text
Belegte Blöcke: 440
```

und:

```text
████....████......████....████......████
```

Damit waren alle fünf Zinnen gleich breit.

### 7. Warum waren die Zwischenräume noch unterschiedlich?

Bei einer Rasterweite von 5 mm lassen sich die ursprünglichen Maße nicht vollständig exakt darstellen.

Die Zinnen sind:

```text
10 mm breit
```

also:

```text
10 / 5 = 2 Blöcke
```

Die Zwischenräume sind dagegen:

```text
12,5 mm breit
```

also:

```text
12,5 / 5 = 2,5 Blöcke
```

Minecraft kann aber keine halben Blöcke verwenden.

Daher mussten die Zwischenräume als 2 bzw. 3 Rasterblöcke dargestellt werden.

### 8. Rasterweite auf 2,5 mm verkleinert

Daraufhin wurde getestet:

```python
BLOCK = 2.5
```

Ergebnis:

```text
Abmessungen: [100.  10.  60.]
Eigenes Raster: [40  4 24]
EPS: 0.001
Belegte Blöcke: 3520
```

Jetzt lassen sich alle Maße exakt abbilden:

```text
Zinne:
10 mm / 2,5 mm = 4 Blöcke

Zwischenraum:
12,5 mm / 2,5 mm = 5 Blöcke
```

Die Darstellung lautet:

```text
████████..........████████..........████████..........████████..........████████
████████..........████████..........████████..........████████..........████████
████████..........████████..........████████..........████████..........████████
████████..........████████..........████████..........████████..........████████
████████████████████████████████████████████████████████████████████████████████
...
```

Damit besteht das Modell aus:

```text
40 Blöcken Breite
 4 Blöcken Tiefe
24 Blöcken Höhe
```

### 9. Kontrolle der Blockzahl

Die `3520` belegten Blöcke lassen sich exakt nachvollziehen.

Grundkörper:

```text
40 × 4 × 20 = 3200
```

Zinnen:

```text
5 × 4 × 4 × 4 = 320
```

Gesamt:

```text
3200 + 320 = 3520
```

Die Python-Ausgabe stimmt damit exakt mit der erwarteten Geometrie überein.

## Wichtigste Erkenntnis

Die automatische Funktion

```python
mesh.voxelized(...)
```

eignet sich gut zur schnellen Voxelisierung und Visualisierung.

Für einen **maßstäblichen Minecraft-Konverter** ist aber das selbst definierte Raster besser:

```text
STL-Abmessungen
      ↓
gewünschte Rasterweite
      ↓
eigene Rasterzellen
      ↓
Mittelpunkte prüfen
      ↓
Minecraft-Blöcke
```

Bei der Burgmauer hat sich:

```text
BLOCK = 2.5 mm
```

als besonders geeignet erwiesen, weil damit sowohl die 10-mm-Zinnen als auch die 12,5-mm-Zwischenräume exakt dargestellt werden können.

## Aktueller Stand

Wir haben jetzt erfolgreich:

```text
Tinkercad
   ↓
STL
   ↓
Python
   ↓
eigenes 2,5-mm-Raster
   ↓
40 × 4 × 24
   ↓
3520 belegte Blöcke
```

Der nächste Schritt ist nun:

```text
belegte_bloecke
      ↓
Minecraft-Koordinaten
      ↓
.schem-Datei
      ↓
WorldEdit
      ↓
Minecraft
```

Dabei wird die Achsenzuordnung:

```text
STL                 Minecraft
--------------------------------
X  Breite       →   X
Y  Tiefe        →   Z
Z  Höhe         →   Y
```

also im Python-Code:

```python
(x, z, y)
```

Damit steht die Grundlage für einen eigenen **STL→Minecraft-Konverter mit Python**.
