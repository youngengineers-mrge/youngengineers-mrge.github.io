# Schülerprojekt: Tinkercad trifft Minecraft

### Hinweis für die Lehrkraft

Die bisherige Untersuchung liefert bereits interessante Vergleichswerte, die ich den Schülerinnen und Schülern **zunächst nicht geben würde**. Besonders geeignet ist das Projekt, weil eine zunächst naheliegende Vermutung – „1-fach, 2-fach und 3-fach bedeutet einfach eine proportionale Vergrößerung“ – offenbar **nicht ausreicht**. Die Schülerinnen und Schüler müssen deshalb messen, Hypothesen bilden und ihre Vermutungen durch neue Experimente überprüfen.

Ich würde das Projekt deshalb eher als **Forschungsauftrag** denn als klassische Schritt-für-Schritt-Anleitung einsetzen. Das passt sehr gut zu Mathematik, Informatik und 3D-Konstruktion zugleich.



## Forschungsfrage
 - unbearbeitet von ChatGPT erstellt

**Wie wandelt Tinkercad die Abmessungen und Positionen eines 3D-Modells in Minecraft-Blöcke um?**

Tinkercad kann einen normalen 3D-Entwurf im Modus **„Blöcke“** in eine Minecraft-Struktur umwandeln und als `.schematic`-Datei exportieren. Dabei stehen drei verschiedene **Entwurfsgrößen** zur Verfügung.

Noch ist nicht vollständig geklärt, nach welcher Regel Tinkercad entscheidet,

* wie viele Minecraft-Blöcke aus einem bestimmten Maß in Millimetern entstehen,
* welche Bedeutung die drei Entwurfsgrößen haben,
* ob die Position eines Körpers im Tinkercad-Koordinatensystem das Ergebnis beeinflusst,
* und warum ein Würfel manchmal beispielsweise nicht als `4 × 4 × 4`, sondern als `4 × 5 × 4` Blöcke erscheint.

## Euer Auftrag

Untersucht den Tinkercad-Minecraft-Export experimentell und versucht, die dahinterliegende Regel zu bestimmen.

Arbeitet dabei wie bei einem naturwissenschaftlichen Experiment: **Immer nur eine Größe verändern und alle anderen Bedingungen gleich lassen.**

### Teil 1 – Einfluss der Größe

Erstellt in Tinkercad jeweils **einen einzelnen Würfel**. Seine linke untere Ecke soll genau im Koordinatenursprung liegen.

Untersucht zum Beispiel Würfel mit:

```text
5 mm
6 mm
7 mm
...
15 mm
```

Kantenlänge.

Exportiert jeden Versuch mit den drei Tinkercad-Einstellungen:

```text
1-fache Entwurfsgröße
2-fache Entwurfsgröße
3-fache Entwurfsgröße
```

Importiert die `.schematic`-Dateien mit WorldEdit in eine Minecraft-Testwelt.

Beispiel:

```text
//schem load dateiname.schematic
//paste -a
```

Messt anschließend die Größe des entstandenen Minecraft-Körpers in Blöcken.

Dokumentiert eure Ergebnisse beispielsweise so:

| Tinkercad-Kantenlänge | 1-fach | 2-fach | 3-fach |
| --------------------: | -----: | -----: | -----: |
|                  5 mm |      ? |      ? |      ? |
|                  6 mm |      ? |      ? |      ? |
|                  7 mm |      ? |      ? |      ? |
|                     … |      … |      … |      … |
|                 15 mm |      ? |      ? |      ? |

## Teil 2 – Einfluss der Position

Nehmt anschließend **immer denselben Würfel**, beispielsweise:

```text
10 × 10 × 10 mm
```

Verschiebt ihn in Tinkercad schrittweise gegenüber dem Koordinatenursprung:

```text
X = 0 mm
X = 1 mm
X = 2 mm
X = 3 mm
...
```

Untersucht danach dasselbe für die Y- und gegebenenfalls Z-Richtung.

Ändert dabei **nicht gleichzeitig Größe und Position**.

Prüft insbesondere:

> Kann ein geometrisch perfekter Würfel nach dem Export unterschiedlich viele Blöcke in X-, Y- und Z-Richtung besitzen?

## Teil 3 – Findet eine Regel

Versucht aus euren Messwerten eine mathematische Beschreibung abzuleiten.

Untersucht insbesondere:

```text
Wie groß könnte ein Tinkercad-Rasterelement sein?

Wann erhöht sich die Zahl der Minecraft-Blöcke um 1?

Werden Randpunkte oder teilweise getroffene Rasterzellen mitgezählt?

Liegt das Raster bei allen drei Raumrichtungen gleich?

Welche Unterschiede bestehen zwischen
1-facher, 2-facher und 3-facher Entwurfsgröße?
```

Formuliert zunächst eine **Hypothese** und entwickelt anschließend einen neuen Versuch, mit dem ihr diese Hypothese gezielt testen könnt.

## Dokumentation

Am Ende soll euer Projekt mindestens enthalten:

1. Beschreibung des Versuchsaufbaus und der Forschungsfrage.
2. Tabelle der Messwerte.
3. Screenshots aus Tinkercad und Minecraft.
4. Mindestens eine selbst formulierte Hypothese.
5. Einen Versuch, der diese Hypothese bestätigt oder widerlegt.
6. Eure vermutete Regel für den Tinkercad-Minecraft-Export.
7. Eine kurze Beschreibung, welche Fragen noch offen geblieben sind.

## Zusatzaufgabe

Untersucht anschließend andere Körper, beispielsweise **Kugel, Zylinder, Kegel oder Pyramide**.

Dabei wird eine zusätzliche Frage interessant:

> **Nach welcher Regel entscheidet Tinkercad, ob eine teilweise vom 3D-Körper ausgefüllte Rasterzelle zu einem Minecraft-Block wird oder leer bleibt?**

---

