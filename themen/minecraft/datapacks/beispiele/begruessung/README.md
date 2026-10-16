# Erstes Datapack: Begrüßung

Ziel: Eine Nachricht ausgeben und Erfahrungspunkte vergeben. **Minecraft Java 26.2:** Das genaue Datenpack-Format muss in dieser Version mit `/datapack` und dem Spielprotokoll geprüft werden. Die mitgelieferte `pack.mcmeta` ist deshalb eine **Vorlage**, kein garantiert lauffertiges Paket.

## Dateien
- `pack.mcmeta`: Metadaten, Format für 26.2 prüfen
- `data/young/function/willkommen.mcfunction`: zwei Befehle

## Test
1. Ordner `begruessung` in `saves/<Welt>/datapacks/` kopieren.
2. Welt laden und `/reload` ausführen.
3. Mit `/datapack list` prüfen, ob das Pack erkannt wird.
4. `/function young:willkommen` ausführen.

Für den Unterricht: Nachricht verändern, Erfahrungspunkte verändern und den Effekt beobachten.
