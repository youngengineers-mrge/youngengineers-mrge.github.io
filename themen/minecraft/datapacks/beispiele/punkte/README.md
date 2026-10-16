# Scoreboard-Übung

Im Spiel mit aktivierten Befehlen nacheinander ausführen:

```mcfunction
/scoreboard objectives add punkte dummy "AG-Punkte"
/scoreboard objectives setdisplay sidebar punkte
/scoreboard players add @p punkte 1
/scoreboard players get @p punkte
```

Aufgabe: Erhöhe den Punktestand um 5, setze ihn zurück und entwickle ein kleines Quiz. Achtung: `/scoreboard objectives add` nur einmal ausführen, solange das Ziel existiert.
