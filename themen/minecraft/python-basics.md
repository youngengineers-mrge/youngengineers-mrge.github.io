# Python und Minecraft - die Basisc

**Python → `.schem`-Datei → WorldEdit → Minecraft**

WorldEdit verwendet für aktuelle Minecraft-Versionen das Sponge-Schematic-Format `.schem`; geladen wird eine Datei mit `//schem load <name>` und anschließend mit `//paste` eingefügt. ([GitHub][1])
## G

### 1. Python erzeugt die Blöcke

Eine geeignete Python-Bibliothek ist `mcschematic`. Sie ist genau dafür gedacht, Minecraft-Schematic-Dateien per Python zu erzeugen. Installation:

```bash
pip install mcschematic
```

Die Grundidee ist sehr einfach:

```python
import mcschematic

schem = mcschematic.MCSchematic()

schem.setBlock((0, 0, 0), "minecraft:stone")
schem.setBlock((1, 0, 0), "minecraft:stone")
schem.setBlock((2, 0, 0), "minecraft:stone")
```

Die Koordinaten sind dabei normale

```text
(x, y, z)
```

-Koordinaten relativ zum Ursprung des späteren Bauwerks. `mcschematic` unterstützt außerdem Transformationen sowie gefüllte und hohle Quader. ([GitHub][2])

### 2. Schon mit Schleifen entstehen richtige Bauwerke

Beispielsweise eine 10 Blöcke lange Mauer:

```python
import mcschematic

schem = mcschematic.MCSchematic()

for x in range(10):
    for y in range(5):
        schem.setBlock((x, y, 0), "minecraft:stone_bricks")
```

Oder eine Grundfläche:

```python
for x in range(10):
    for z in range(10):
        schem.setBlock((x, 0, z), "minecraft:oak_planks")
```

Damit wird Minecraft plötzlich zu einer sehr anschaulichen **3D-Ausgabe für Python-Programme**.

### 3. Besonders interessant für die AG

Man könnte schrittweise Funktionen entwickeln wie:

```python
quader(...)
mauer(...)
turm(...)
pyramide(...)
kugel(...)
linie(...)
treppe(...)
haus(...)
```

Dann beispielsweise:

```python
turm(0, 0, 0, breite=9, hoehe=15)
turm(30, 0, 0, breite=9, hoehe=15)
mauer(4, 0, 4, 30, 8)
```

Python würde daraus die `.schem`-Datei erzeugen.

Das eröffnet einige sehr schöne Schülerprojekte:

* Würfel und Quader mit `for`-Schleifen
* Pyramiden
* Türme und Burgen
* Koordinatensysteme
* mathematische Funktionen als Blocklandschaften
* Kreise und Kugeln
* Zufallslandschaften
* Labyrinthe
* Fraktale
* Binärzahlen und digitale Schaltungen
* automatisch erzeugte Redstone-Strukturen

Gerade die Verbindung **Mathematik → Algorithmus → Python → sichtbares Minecraft-Bauwerk** finde ich für eure AG besonders passend.

### 4. Vorteil gegenüber direkter Minecraft-Steuerung

Man könnte Python auch über Server-Schnittstellen oder Plugins direkt Befehle an Minecraft schicken lassen. Für eure Schulrechner würde ich zunächst davon abraten.

Mit `.schem` bleibt die Architektur viel einfacher:

```text
Python
   ↓
Koordinaten + Blocktypen
   ↓
objekt.schem
   ↓
WorldEdit
   ↓
Minecraft-Welt
```

Und eure vorhandene WorldEdit-Infrastruktur passt direkt dazu.

`mcschematic` beschreibt genau diesen Ablauf: Blöcke programmatisch setzen, die Struktur speichern und anschließend als Schematic in Minecraft verwenden. ([GitHub][3])

### Mein Vorschlag für unseren ersten Versuch

Wir bauen zunächst etwas sehr Überschaubares:

**Python erzeugt einen hohlen Würfel mit 10 × 10 × 10 Blöcken aus Glas.**

Danach:

```text
//schem load python_wuerfel
//paste
```

Wenn das funktioniert, bauen wir darauf unsere eigene kleine **Minecraft-Python-Bibliothek** auf, zum Beispiel:

```python
mc.setze_block(...)
mc.quader(...)
mc.mauer(...)
mc.pyramide(...)
mc.turm(...)
mc.kugel(...)
```

Das könnte später sogar ein eigener Bereich auf eurer Minecraft-Seite werden: **„Minecraft mit Python programmieren“**.

[1]: https://github.com/EngineHub/WorldEditDocs/blob/master/source/usage/clipboard.rst?utm_source=chatgpt.com "WorldEditDocs/source/usage/clipboard.rst at master · EngineHub/WorldEditDocs · GitHub"
[2]: https://github.com/Sloimayyy/mcschematic "GitHub - Sloimayyy/mcschematic: MCSchematic is a python package used for creating Minecraft Schematics through code. · GitHub"
[3]: https://github.com/Sloimayyy/mcschematic?utm_source=chatgpt.com "GitHub - Sloimayyy/mcschematic: MCSchematic is a python package used for creating Minecraft Schematics through code. · GitHub"
