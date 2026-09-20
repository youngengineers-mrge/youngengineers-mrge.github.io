# Autodesk Fusion für Minecraft nutzen
Es gibt **keine direkte offizielle Schnittstelle „Autodesk Fusion ↔ Minecraft“**, aber es gibt sehr brauchbare Wege über **3D-Dateien, Python und WorldEdit**. Gerade eure Kombination aus Fusion, Python und WorldEdit bietet dafür einiges. Autodesk Fusion kann aktuell u. a. **STL, OBJ und 3MF** importieren und exportieren. ([Autodesk][1])

## 1. Fusion → Minecraft

Der interessante Weg wäre:

```text
Autodesk Fusion
     ↓
 STL / OBJ
     ↓
Voxelisierung
     ↓
Minecraft-Blöcke
     ↓
.schem
     ↓
WorldEdit
     ↓
Minecraft
```

Fusion liefert beispielsweise ein `modell.stl`. Ein Python-Programm könnte dieses Modell anschließend in ein **3D-Raster aus Würfeln** zerlegen und daraus eine `.schem`-Datei erzeugen.

Das wäre im Prinzip genau das, was wir bei euren bisherigen **Tinkercad→Minecraft-Versuchen** beobachtet haben: Ein geometrischer Körper wird auf ein Blockraster abgebildet. Nur könnten wir bei Fusion mit Python selbst bestimmen, **wie diese Umwandlung erfolgt**.

Zum Beispiel:

```text
Fusion-Modell: Kugel Ø 100 mm

        ↓ Rastergröße festlegen

1 Minecraft-Block = 10 mm

        ↓

Kugel ungefähr 10 Blöcke Durchmesser

        ↓

kugel.schem
```

WorldEdit kann die erzeugte Schematic anschließend mit

```text
//schem load kugel
//paste
```

laden und einsetzen. WorldEdit unterstützt das Laden und Speichern von Schematics direkt. ([WorldEdit][2])

## 2. Minecraft → Fusion

Die Gegenrichtung funktioniert sogar schon recht komfortabel:

```text
Minecraft-Welt
     ↓
Mineways
     ↓
OBJ / STL
     ↓
Autodesk Fusion
```

**Mineways** kann Bereiche aus Minecraft Java als **OBJ oder STL** exportieren. Die aktuelle Version unterstützt Minecraft Java bis einschließlich 26.2. ([Erich Haines' Homepage][3])

Fusion kann diese Formate wiederum importieren. ([Autodesk][4])

Damit könnten wir zum Beispiel:

```text
Minecraft-Burg
      ↓
Mineways
      ↓
burg.obj
      ↓
Fusion
      ↓
bearbeiten
      ↓
3D-Druck
```

Das wäre für eure AG durchaus interessant: **Minecraft-Modell → echtes 3D-Modell → Prusa MK4**.

## 3. Python könnte die eigentliche Brücke werden

Hier wird es besonders spannend: Autodesk Fusion besitzt eine eigene API, die ausdrücklich auch mit **Python** verwendet werden kann. Python-Skripte und Add-ins lassen sich direkt innerhalb von Fusion erstellen. ([Autodesk Hilfe][5])

Damit wäre langfristig sogar diese Kette denkbar:

```text
        AUTODESK FUSION
              ↕
            Python
              ↕
      Minecraft-Schematic
              ↕
          WORLDEDIT
              ↕
           MINECRAFT
```

Wir könnten also ein eigenes Python-Werkzeug entwickeln, etwa:

```python
fusion_zu_minecraft(
    datei="turm.stl",
    blockgroesse=10,
    block="minecraft:stone_bricks"
)
```

und heraus kommt:

```text
turm.schem
```

Noch interessanter wäre eine Zuordnung verschiedener Fusion-Körper:

```text
Fusion-Körper           Minecraft
────────────────────────────────────
Fundament        →      stone_bricks
Dach             →      red_concrete
Fenster          →      glass
Holzbalken       →      oak_planks
```

## 4. Das eröffnet ein richtig interessantes Schülerprojekt

Ich sehe daraus sogar ein eigenständiges Projekt:

**„Von Fusion nach Minecraft“**

```text
1. Objekt in Fusion konstruieren
            ↓
2. STL/OBJ exportieren
            ↓
3. Python liest das Modell
            ↓
4. Modell voxelisieren
            ↓
5. Minecraft-Blöcke bestimmen
            ↓
6. .schem erzeugen
            ↓
7. mit WorldEdit einsetzen
```

Das wäre deutlich interessanter als ein fertiger Konverter, weil die Schüler dabei gleichzeitig **CAD, Koordinaten, 3D-Raster, Python und Minecraft** kennenlernen.

Und wir hätten gegenüber Tinkercads Minecraft-Export einen entscheidenden Vorteil: **Wir bestimmen den Voxel-Algorithmus selbst.** Genau das würde ich als nächsten Versuch angehen.

[1]: https://www.autodesk.com/support/technical/article/caas/sfdcarticles/sfdcarticles/File-formats-supported-by-Fusion-360.html?utm_source=chatgpt.com "File formats supported in Autodesk Fusion"
[2]: https://worldedit.enginehub.org/en/latest/commands/?utm_source=chatgpt.com "Commands - WorldEdit 7.4 documentation"
[3]: https://erich.realtimerendering.com/minecraft/public/mineways/?utm_source=chatgpt.com "Mineways"
[4]: https://www.autodesk.com/de/support/technical/article/caas/sfdcarticles/sfdcarticles/DEU/File-formats-supported-by-Fusion-360.html?utm_source=chatgpt.com "In Autodesk Fusion unterstützte Dateiformate"
[5]: https://help.autodesk.com/cloudhelp/ENU/Fusion-360-API/files/PythonSpecific_UM.htm?utm_source=chatgpt.com "Python Specific Issues"
