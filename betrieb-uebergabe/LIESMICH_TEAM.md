# Kurze Anleitung für das Team – KI-Cockpit

## Vor der ersten Nutzung (einmalig, durch die Pflege-Verantwortlichen)
- Der Ordner `libs/` muss neben der Cockpit-Datei liegen und gefüllt sein. Dazu läuft `libs/libs_herunterladen.ps1` einmal an einem Rechner mit Internetzugang (siehe `libs/README_LIBS.md`). Die freigegebene Betriebsfassung lädt nichts aus dem Internet; fehlt `libs/`, zeigt sie einen Hinweis.

## So nutzen Sie das Cockpit
1. Öffnen Sie die freigegebene Datei **`2026-11-18_cockpit_v1.2_stabil.html`** per Doppelklick in Edge, Chrome oder Firefox.
2. Wechseln Sie auf den Reiter **„Monatsabschluss (Dropzone)“** und ziehen Sie den aktuellen Monatsexport (`.csv` oder `.xlsx`) mit der Maus in das gestrichelte Feld.
3. Kennzahlen, Balken und Ampeln werden im Browser neu berechnet. Die Datei wird nicht hochgeladen und verlässt Ihren Rechner nicht.

## Datenbank, Wissensgraph und KI-Assistent (ab Stufe 4 bzw. 5)
Diese Reiter brauchen einen lokalen Mini-Server und – für den KI-Assistenten – die freigegebene Ollama-Installation. Per Doppelklick zeigen sie deshalb einen Hinweis; die übrigen Reiter funktionieren weiter. Starten Sie stattdessen `start_cockpit_sicher.bat` (Python und Ollama müssen von der IT installiert sein). Im Begleit-Repository öffnet sie `stufe5-smart-cockpit/cockpit.html`; in Ihrem Betriebsordner passen die Pflege-Verantwortlichen Ordner und Dateinamen in den Zeilen `cd /d …` und `start http://…` an. Zum Feierabend schließen Sie beide Konsolenfenster (Zündschlüssel-Regel).

## Wichtige Spielregeln
- Speichern Sie Exporte nicht im Programmordner, sondern in Ihrem normalen Fachordner.
- KI-Ergebnisse sind Vorschläge. Prüfen Sie sie, bevor Sie etwas übernehmen.
- Änderungen an der Cockpit-Datei nehmen nur die zwei benannten Pflege-Verantwortlichen vor. Ältere Stände liegen im Unterordner `archiv/`.

## Hinweis zur `.aspx`-Datei
`2026-11-18_cockpit_v1.2_stabil.aspx` ist inhaltlich dieselbe Datei. SharePoint zeigt sie nur dann als Seite an, wenn Admins „Custom Script“ erlauben – in SharePoint Online lässt sich das nur noch für 24 Stunden einschalten. Nutzen Sie diesen Weg allenfalls als Übergangslösung (vor allem auf SharePoint Server) und nur mit Zustimmung von SharePoint-Admin und ISB. Standardweg bleiben Netzlaufwerk oder synchronisierter OneDrive-/SharePoint-Ordner.
