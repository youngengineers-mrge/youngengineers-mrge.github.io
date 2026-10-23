# Vom Softwaredepot zur nachvollziehbaren PC-Wartung · [Zur Webseite](./index.html#wartung-artikel)

*Projektstand: 23. Oktober 2026*

Wie bringen wir die benötigten Programme auf unsere AG-Rechner? Und wie sorgen wir anschließend dafür, dass Startmenü, Browser und Benutzerumgebung in einem nachvollziehbaren Zustand bleiben?

Unser Projekt begann mit einem lokalen Softwaredepot. Inzwischen ist daraus ein Werkzeugkasten für Softwarebereitstellung, getrennte Wartungsaufgaben und deren Dokumentation geworden. Ein wichtiges Ziel bleibt dabei: Nicht nur Änderungen ausführen, sondern später erklären können, **welche Aufgabe unter welchem Konto was verändert hat**.

Dieser Artikel ergänzt die [bisherige Vorstellung der Softwareverteilung](https://youngengineers-mrge.github.io/themen/software/index.html).

## Der Ausgangspunkt: Programme aus dem Schulnetz

Für unsere AG-Arbeit benötigen wir unter anderem Python-Werkzeuge, Browser und Software für den 3D-Druck. Jeden PC einzeln einzurichten und große Pakete immer wieder aus dem Internet zu laden, kostet Zeit und belastet die Verbindung.

Der lokale **AG-Server** stellt deshalb vorbereitete Softwarearchive im Schulnetz bereit. Das Bereitstellungsskript lädt ausgewählte Pakete herunter und entpackt sie in einen gemeinsamen Programmordner. Für geeignete portable Programme ist dafür keine klassische Installation erforderlich.

Zur bisher beschriebenen Auswahl gehören Thonny, Chromium, WinPython und Prusa3D. Weitere Archive sind vorbereitet. Welche Pakete tatsächlich verteilt werden, entscheidet das jeweilige Skript – eine vorhandene ZIP-Datei bedeutet noch nicht, dass sie bereits automatisch eingesetzt wird.

Das Depot bleibt die Grundlage. Neu hinzugekommen ist die Frage: **Was passiert nach der Bereitstellung?**

## Drei Kontexte statt eines allmächtigen Skripts

Windows unterscheidet nicht nur zwischen Benutzerkonten, sondern auch zwischen normalen und erhöhten Prozessrechten. Diese Unterscheidung ist für unsere Wartung entscheidend:

| Kontext | Aufgabe im Projekt |
|---|---|
| `mcn` mit erhöhten Rechten | Wartung einrichten, Aufgaben verwalten, Skripte aktualisieren und Analysen erstellen. |
| `nutzer` mit normalen Rechten | Persönliche Einstellungen des Schülerkontos bearbeiten. |
| SYSTEM | Rechnerweite Wartung durchführen, etwa zentrale Startmenü- und Browserkonfiguration. |

Ein Administratorfenster ist nicht automatisch ein SYSTEM-Prozess. Und ein unter `mcn` gestartetes Skript arbeitet nicht allein deshalb im Profil von `nutzer`, weil es dessen Einstellungen verändern soll.

Benutzerbezogene Wartung und zentrale Wartung werden deshalb über getrennte Windows-Aufgaben ausgeführt. Das aufrufende Wartungskonto kann einen Start anfordern; ausgeführt wird die Aufgabe unter dem in ihrer Definition hinterlegten Konto.

```text
AG-Server: Skripte, Pakete und Auftragslisten
                      |
                      v
       Windows-Aufgaben auf dem AG-PC
           |                    |
           v                    v
   SYSTEM-Wartung        Nutzer-Wartung
   rechnerweit           persönliches Profil
           \                    /
            v                  v
             lokale Protokolle
                      |
                      v
               Task-Analyse
```

## Was die Wartung übernimmt

### Zentrale Wartung unter SYSTEM

Die zentrale Wartung bearbeitet den gemeinsamen AG-Startmenübestand und die dafür vorgesehenen persönlichen Menüordner des Schülerkontos. Sie prüft außerdem SYSTEM-Aufträge vom Server, aktualisiert bei Bedarf Open-Shell und setzt zentrale Open-Shell- und Firefox-Vorgaben.

Ein weiterer Schritt kann den lokalen Starter der Desktop-Rückfallwartung erneuern.

Diese Arbeiten sind mehr als eine portable Softwarebereitstellung: Sie können systemweite Einstellungen verändern und benötigen entsprechende Rechte. Die Trennung der Aufgaben macht diesen Unterschied sichtbar.

### Wartung im Schülerkonto

Die Nutzer-Wartung kümmert sich um die persönliche Umgebung von `nutzer`. Dazu gehören Desktopgestaltung, Aufräumen des persönlichen Desktops, zusätzliche Nutzer-Aufträge sowie benutzerbezogene Open-Shell- und Firefox-Einstellungen.

**Aufräumen ist hier eine echte Veränderung:** Dateien direkt auf dem persönlichen Desktop werden in den Papierkorb verschoben; Unterordner bleiben bestehen. Die Browserwartung kann ebenfalls persönliche Daten zurücksetzen. Solche Funktionen gehören ausschließlich in eine bewusst dafür vorgesehene Schülerumgebung – nicht ungeprüft auf einen privaten Arbeitsrechner.

### Einmalige Aufträge

Für zusätzliche Arbeiten gibt es getrennte Auftragslisten für SYSTEM und `nutzer`. Aufträge besitzen eine Kennung, einen Skriptnamen und einen SHA-256-Wert. Nach erfolgreicher Ausführung wird ein lokaler Erledigungsvermerk gespeichert.

Das soll unnötige Wiederholungen vermeiden. Es ersetzt aber keine sorgfältige Gestaltung der Skripte: Ein unterbrochener Auftrag kann erneut laufen und muss damit umgehen können.

Die Prüfsumme vergleicht den heruntergeladenen Inhalt mit der Liste. Sie authentifiziert nicht den Server, wenn Liste und Datei über dieselbe ungeschützte Verbindung kommen.

## Lokal vorhanden heißt nicht ständig aktiv

Eine Aufgabe trägt den Namen `wartung-nutzer-permanent`. Bei der Analyse wurde deutlich, dass dieser Name Erklärung braucht.

Die Aufgabe läuft nicht ständig. Sie startet bei der Anmeldung von `nutzer` eine lokal vorhandene Rückfalllösung:

- Ist die Server-Startseite nicht erreichbar, wird die lokale Desktopwartung ausgeführt.
- Ist sie erreichbar, beendet sich der Starter und erwartet, dass die separate Anmeldewartung übernimmt.

Hier liegt eine bekannte Grenze: **Ein erreichbarer Server belegt noch keine erfolgreiche Wartung.** Er beweist weder, dass die andere Aufgabe gestartet wurde, noch dass deren Downloads und Arbeitsschritte erfolgreich waren.

Auf dem Arbeitsrechner wurden die beiden Anmeldetasks bewusst ohne automatische Trigger für manuelle Tests eingerichtet. Dort darf aus ihrem Namen erst recht kein automatischer Anmeldestart abgeleitet werden.

## Bedienung im Terminal

Für die Wartung ist nicht immer eine grafische Oberfläche verfügbar oder erwünscht. Deshalb gibt es einen CMD-Starter mit vier Bereichen:

1. Aktionen im Kontext `mcn`
2. Aktionen im Kontext `nutzer`
3. AG-Aufgaben-Manager
4. Task-Analyse

Der Starter verlangt das lokale Konto `mcn` mit erhöhten Rechten. Der Aufgaben-Manager zeigt die eingerichteten Aufgaben, ihren Zustand und Informationen zum letzten Lauf und bietet Verwaltungsfunktionen.

Auch die Fensterfarbe wurde Teil der Bedienung:

- **Grün:** Der Wartungsprozess läuft erhöht.
- **Blau:** Der Prozess ist nicht erhöht – auch wenn das Konto Mitglied der Administratorengruppe ist.

Die Textanzeige der Rechte bleibt zusätzlich erhalten. Diese kleine Änderung entstand aus einer konkreten Fehlersuche: Aufgaben waren eingerichtet, wurden aber in einem nicht erhöhten Managerfenster nicht wie erwartet angezeigt.

## PowerShell: Ausführungsrichtlinie und Rechte sind verschiedene Dinge

Eine weitere Erfahrung betraf PowerShell-Skripte. Die Meldung „Die Ausführung von Skripts ist deaktiviert“ ist nicht gleichbedeutend mit fehlenden Administratorrechten.

PowerShell besitzt eigene Ausführungsrichtlinien:

- `Restricted` blockiert Skriptdateien.
- `RemoteSigned` erlaubt lokale unsignierte Skripte; als Internetdownload markierte Dateien benötigen eine vertrauenswürdige Signatur.
- `AllSigned` verlangt Signaturen auch für selbst geschriebene lokale Skripte.
- `Bypass` unterdrückt diese Prüfung im betreffenden Gültigkeitsbereich.

Für einzelne geprüfte Wartungsaufrufe kann eine Einstellung nur für den gestarteten Prozess gelten. Eine dauerhafte Änderung für das Wartungskonto ist eine andere, bewusst zu treffende Entscheidung.

Die Ausführungsrichtlinie ist keine Sicherheitsgrenze und kein Ersatz für eine Codeprüfung. Auch eine Signatur besagt nicht, dass ein Skript ungefährlich ist.

## Eine Aufgabe als untersuchbares Archiv

Der größte neue Baustein ist die **Task-Analyse**. Sie soll nicht bloß einen Bildschirmzustand festhalten, sondern Material für eine spätere Prüfung durch Menschen und KI zusammenstellen.

Nach Auswahl einer Aufgabe entsteht ein ZIP mit Taskname, Datum und Uhrzeit. Es enthält unter anderem:

- die vollständige Aufgaben-XML mit Konto, Aktionen, Triggern und Bedingungen;
- Laufzeitinformationen und das zuletzt gemeldete Ergebnis;
- erkannte lokale Skripte und zugehörige Protokolle;
- aktuelle Serverdateien, getrennt von den lokalen Kopien;
- bekannte Auftragslisten und die darin referenzierten Skripte;
- auslesbare Datei-, Verzeichnis- und Taskrechte sowie Junction-Ziele;
- zusätzliche relevante Taskdefinitionen und mögliche Aufrufer als Texttreffer;
- den verwendeten Sammler selbst;
- ein Manifest mit Herkunft, Erfassungszeiten und SHA-256-Werten.

Für die bekannten Startmenü- und Open-Shell-Helfer wurde der Sammler außerdem um Originalpakete und ZIP-Inhaltsverzeichnisse erweitert. Diese Pakete werden zur Analyse weder entpackt noch ausgeführt.

**Der Export startet keine Wartung.** Er liest und kopiert Untersuchungsmaterial.

## Was wir mit den Archiven bereits gelernt haben

Die ersten Archive wurden anschließend außerhalb des Sammlers gelesen und ausgewertet. Dabei ließen sich sowohl Wartungsverhalten als auch Schwächen des Analysewerkzeugs erkennen.

Anfangs behandelte der Sammler beispielsweise Variablenzuweisungen wie `PS1=…` als Dateinamen. Auch erzeugte Ausgabedateien wurden teilweise als fehlende Eingaben gemeldet. Diese Fehlalarme führten zu einer genaueren Unterscheidung von Aufrufkandidaten, gelesenen Dateien, Downloads und Ausgabepfaden.

In einem Vergleich sank die Zahl der Sammlerhinweise von 37 auf zwölf. Das bedeutet nicht, dass 25 Wartungsfehler behoben wurden: **Verbessert wurde vor allem die Erfassung und Einordnung.**

Eine SYSTEM-Analyse zeigte einen anderen, tatsächlichen Ablauf: Die Startmenüwartung brach an einer Schutzprüfung ab, während weitere Wartungsschritte weiterliefen. Das Gesamtergebnis blieb ein Fehler. Ein einzelner erfolgreicher Teilschritt hätte diesen Zustand nicht beschrieben.

Die ausgewerteten Archive enthielten 13 beziehungsweise 29 im Manifest erfasste Dateien; deren Prüfsummen stimmten bei der Prüfung überein.

## Schul-PC und Arbeitsrechner sind nicht gleich

Auf den vorgesehenen Schul-PCs soll der gemeinsame Programmordner ein regulärer Ordner sein. Der Arbeitsrechner verwendet dagegen eine Junction, also eine Ordnerumleitung auf ein anderes Laufwerk.

Die Startmenüwartung lehnt solche Umleitungen bewusst ab, damit Bereinigungen nicht unbeabsichtigt andere Ziele erreichen. Auf dem Arbeitsrechner kollidiert diese Schutzregel mit der vorhandenen Struktur.

Die richtige Konsequenz ist nicht, die Prüfung nebenbei abzuschalten. Zunächst muss die Abweichung dokumentiert und eine geeignete Behandlung entschieden werden.

Für das reine Aktualisieren der beiden Task-Starter gibt es deshalb bereits eine getrennte Arbeitsrechner-Variante. Sie prüft die erwartete Junction und aktualisiert die Dateien am physischen Ziel. Sie richtet keine Aufgaben ein, startet keine Wartung und macht die nachgelagerte Schulwartung nicht automatisch arbeitsrechnertauglich.

## Archive ohne Browser übertragen

Nach einer interaktiven Task-Analyse kann das erstellte Archiv ausdrücklich zum lokalen AG-Server hochgeladen werden. Das funktioniert vollständig im Terminal.

Erst nach Rückdownload und übereinstimmender SHA-256-Prüfsumme wird der Upload als bestätigt gemeldet. Das lokale Original bleibt erhalten. Dieser Weg wurde bereits mit einem echten Analyseexport erfolgreich genutzt.

**Analysearchive sind keine öffentlichen Projektdateien.** Sie können Benutzernamen, Pfade, persönliche Daten oder Geheimnisse enthalten. Vor einer Weitergabe – insbesondere an einen KI-Dienst – müssen sie geprüft und erforderlichenfalls bereinigt werden. HTTP überträgt die Daten unverschlüsselt; der Upload-Bereich ist keine vertrauliche Archivablage.

## Grenzen und nächste Schritte

Der aktuelle Stand ist ein wachsender, praktisch erprobter Werkzeugkasten, keine fertig zertifizierte zentrale Schulverwaltung.

Offen bleiben insbesondere:

- **Wartungserfolg statt bloßer Erreichbarkeit prüfen:** Die Rückfalllösung darf nicht allein aus einer Serverantwort auf erledigte Nutzerwartung schließen.
- **Zielverzeichnisse und Rechte vollständig vorbereiten:** Ein vorgesehener Download kann nur funktionieren, wenn sein Ziel erreichbar und beschreibbar ist.
- **Schul- und Arbeitsrechner sauber trennen:** Testkonfigurationen ohne Trigger dürfen nicht mit dem automatischen Schulbetrieb verwechselt werden.
- **Analysegrenzen sichtbar halten:** Berechnete Pfade und dynamische Aufrufe sind statisch nicht immer auflösbar. Ein Texttreffer beweist keinen tatsächlichen Start.
- **Unterschiedliche Zeitstände beachten:** Aktuelle Serverdateien belegen nicht, welche Fassung beim letzten protokollierten Lauf ausgeführt wurde. Während eines Exports können Protokolle weiterwachsen.
- **Weitere Tests am Zielsystem durchführen:** Isolierte Sammlertests und erfolgreiche Einzelabläufe ersetzen keinen vollständigen Test aller Funktionen auf den Schüler-PCs.

## Unser Zielbild

Aus „Programme auf den PC bringen“ ist ein umfassenderes Vorhaben geworden: **Software bereitstellen, Wartung nach Kontokontext trennen und das tatsächliche Verhalten nachvollziehbar dokumentieren.**

Die Arbeit mit KI unterstützt dabei zwei unterschiedliche Schritte: beim Entwickeln der Werkzeuge und beim anschließenden Prüfen ihrer Ergebnisse. Entscheidend sind nicht die Behauptungen eines Skripts oder einer KI, sondern überprüfbare Definitionen, Originaldateien, Protokolle und klar benannte Lücken.

So soll aus einzelnen Wartungsskripten ein verständlicher Ablauf werden – für die Menschen, die ihn heute bedienen, und für diejenigen, die ihn später übernehmen.
