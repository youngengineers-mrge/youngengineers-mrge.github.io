### WorldEdit unter MultiMC installieren und testen

1. **MultiMC starten** und die gewünschte Minecraft-Instanz auswählen.

2. Rechtsklick auf die Instanz → **Instanz bearbeiten**.

3. Unter **Version** prüfen, ob **Fabric Loader** installiert ist. Falls nicht: **Fabric installieren**. Für Einzelspieler empfiehlt auch die WorldEdit-Dokumentation Fabric in Verbindung mit MultiMC. ([WorldEdit Dokumentation][1])

4. Die zur Minecraft-Version passende **WorldEdit-Fabric-Version** herunterladen. Wichtig: **Minecraft-Version und Fabric-Version müssen passen.** Die aktuelle WorldEdit-Dokumentation verweist dafür auf Modrinth. ([WorldEdit Dokumentation][1])

5. In MultiMC unter **Loader-Mods** → **Hinzufügen** die heruntergeladene `worldedit-...jar` einfügen und aktivieren.

6. Minecraft starten und eine **Einzelspielerwelt mit aktivierten Cheats** öffnen. Ohne Cheats stehen die WorldEdit-Befehle im Einzelspieler nicht zur Verfügung. ([WorldEdit Dokumentation][1])

7. Im Chat eingeben:

```text
//wand
```

Du solltest eine **Holzaxt** erhalten.

8. Mit der Holzaxt zwei Punkte auswählen:

   * Linksklick → Position 1
   * Rechtsklick → Position 2

9. Testbefehl:

```text
//set stone
```

Der markierte Bereich sollte mit Stein gefüllt werden.

10. Rückgängig machen:

```text
//undo
```

Wenn das funktioniert, ist **WorldEdit korrekt installiert und einsatzbereit**.

Für eure AG würde ich als ersten Standardtest sogar nur diese vier Befehle verwenden:

```text
//wand
//pos1
//pos2
//set stone
```

Damit lässt sich sehr schnell prüfen, ob eine vorbereitete MultiMC-Instanz auf einem Schul-PC vollständig funktioniert.

[1]: https://worldedit.enginehub.org/_/downloads/en/latest/pdf/ "WorldEdit Documentation Documentation"