# Das KI-Cockpit – Begleit-Monorepo

Begleit-Repository zum Buch **„Das KI-Cockpit – Prozesse, Zahlen und Abhängigkeiten im Blick: Souveräne Dashboards bauen mit lokaler KI — ohne Vorkenntnisse und Lizenzkosten“** von Michael Estel.

- Live-Startseite mit Demos und allen Prompts aus dem Buch: **https://on-premise-ai-cockpit.github.io**
- A4-Spickzettel zum Ausdrucken: [KI-Cockpit_Spickzettel_A4.pdf](KI-Cockpit_Spickzettel_A4.pdf)

## Worum es geht
Große IT-Projekte dauern oft Jahre. Viele Alltagsprobleme lassen sich dagegen mit kleinen Werkzeugen lösen, die eine Fachabteilung selbst baut – nachvollziehbar und mit IT, Datenschutz und Personal- bzw. Betriebsrat abgestimmt statt als Schatten-IT. Genauso eignen sich alle Vorlagen für Kleinunternehmer, Vereine und Privatpersonen auf dem eigenen Rechner (dort ohne IT-Freigabe direkt startklar). Dieses Repository enthält die Vorlagen, fiktiven Beispieldaten und Freigabe-Unterlagen zum Buch.

## Herunterladen und loslegen
1. Oben rechts **`Code` → `Download ZIP`** wählen und den Ordner entpacken (lokal oder auf einem Netzlaufwerk). Ist GitHub in Ihrem Netz gesperrt, laden Sie das ZIP an einem freigegebenen Internet-Arbeitsplatz herunter oder bitten Ihre IT darum.
2. `index.html` oder eine Ausbaustufe im Browser öffnen.
3. **Für den Betrieb ohne Internet:** Der Ordner `libs/` ist im ZIP leer, weil die Bibliotheken unter eigenen Lizenzen stehen. Führen Sie `libs/libs_herunterladen.ps1` einmal an einem Rechner mit Internetzugang aus (Details: [libs/README_LIBS.md](libs/README_LIBS.md)). Ohne gefüllten Ordner laden die Lernstände ihre Bibliotheken aus dem Internet.

## Was Sie je Stufe brauchen

| Stufe | Inhalt | Voraussetzung |
|---|---|---|
| 1 | Diagramme aus Text (Mermaid, BPMN, C4) | keine Installation; Online-Editoren nur mit unkritischen bzw. anonymisierten Inhalten oder nach Freigabe |
| 2–3 | `cockpit.html` mit Dashboard, Prozessseite, Dropzone | Browser und Windows-Editor, keine Admin-Rechte; Öffnen per Doppelklick |
| 4 | + Reiter Datenbank (SQLite) und Wissensgraph | lokaler Mini-Server `python -m http.server 8000 --bind 127.0.0.1`, weil Browser die Datenbank-Engine unter `file://` blockieren; Python stellt meist die IT bereit |
| 5 | + Reiter KI-Assistent | zusätzlich Ollama (Installation über IT-Freigabe) |

Die optionale lokale KI aus Kapitel 1 (Pseudonymisierung) braucht ebenfalls Ollama.

## Ordnerstruktur
- `index.html` – Startseite mit Links, Voraussetzungen und allen Prompts aus dem Buch
- `stufe1-diagramme/` – Mermaid-Kostenfluss und -Torte (Werkbau Nord GmbH), Prozessaufnahme des Landesamts LID (Mermaid und BPMN 2.0), C4-Diagramme (PlantUML)
- `stufe2-html-cockpit/cockpit.html` – Stand nach Stufe 2 (Reiter KMU-Controlling, Behörde: Prozess & Wegweiser, IT-Architektur)
- `stufe3-dropzone/cockpit.html` – Stand nach Stufe 3 (+ Reiter „Monatsabschluss (Dropzone)“); dazu das eigenständige Zusatzwerkzeug `prozess_editor.html` (BPMN-Editor)
- `stufe4-datenbank-graph/cockpit.html` – Stand nach Stufe 4 (+ Reiter „Datenbank (SQLite)“ und „Wissensgraph“)
- `stufe5-smart-cockpit/cockpit.html` – Stand nach Stufe 5 (+ Reiter „KI-Assistent (lokal)“ mit Demo-Modus für die Online-Vorschau)
- `daten/` – fiktive Beispieldaten: Monatsabschlüsse (CSV/XLSX), `cockpit_stufe4.sqlite`, `behoerde_kontakte_500.csv`, Erzeugungs-Skript `erzeuge_cockpit_stufe4.py`, Beispielrechnung (PDF/TXT), Richtlinie (TXT)
- `libs/` – Download-Skript `libs_herunterladen.ps1` und Bibliotheksliste mit Versionen und Lizenzen (SBOM)
- `betrieb-uebergabe/` – Betriebsfassung `2026-11-18_cockpit_v1.2_stabil.html` (lädt nur aus `libs/`), `.aspx`-Variante (nur Übergangslösung), Vorlage `UEBERGABEPAKET_IT_PERSONALRAT.md`, `LIESMICH_TEAM.md`, Startdateien `start_cockpit_sicher.bat` und `start_llama_server_profil_a.bat`, `Modelfile.controlling`

## Ein Cockpit, das mitwächst
Von Stufe 2 bis 5 wird eine einzige Datei `cockpit.html` erweitert. Jede Stufe ergänzt Reiter; die vorhandenen bleiben unverändert. Funktionen, die einen lokalen Server bzw. Ollama brauchen, zeigen beim Öffnen per Doppelklick einen Hinweis statt eines Fehlers – der Rest des Cockpits funktioniert weiter. Verteilt wird der zuletzt von Ihrer Organisation freigegebene Stand.

## Die sechs Governance-Leitplanken (Abschnitt 8.5)
1. **Datenhaltung (Tankdeckel-Prinzip):** Die Cockpit-Datei enthält keine produktiven Echtdaten. Mitgelieferte Beispieldaten sind fiktiv; Ihre echten Daten laden Sie zur Laufzeit.
2. **Netzwerk und Offline-Betrieb:** Mit gefülltem `libs/` lädt das Cockpit keine externen Ressourcen (prüfbar über `F12` → Netzwerk; der Test belegt das Verhalten der Seite).
3. **Lokale KI-Schnittstelle:** Ollama nur an `127.0.0.1` gebunden (Standard), nie `OLLAMA_ORIGINS="*"`, Cloud-Funktionen abgeschaltet (`OLLAMA_NO_CLOUD=1`). `OLLAMA_ORIGINS` erweitert die Freigaben nur und wird lediglich für eine dokumentierte Intranet-Adresse gesetzt. `llama-server` mit `--host 127.0.0.1` und API-Schlüssel. Zündschlüssel-Regel.
4. **Verantwortung und Pflege:** zwei benannte Pflege-Verantwortliche mit Vertretung, Versionierung `JJJJ-MM-TT_cockpit_vX.Y_stabil.html`, Unterordner `archiv/`.
5. **Lizenz- und Prüfsicherheit:** Bibliotheksliste mit Version und Lizenz (MIT, Apache-2.0, `bpmn.io`-Lizenz) und C4-Architekturskizze.
6. **Mitbestimmung und Kontrolle:** kein Login und keine Nutzungsprotokolle im Cockpit; Ollama und Mini-Server können eigene Logs schreiben, diese werden offengelegt. Das Cockpit ist nicht für Leistungskontrolle ausgelegt und ohne Personenbezug konzipiert; die Bewertung nimmt der Personal- bzw. Betriebsrat vor. Der Wissensgraph bewertet Funktionen, nicht Personen.

## Sicherheit
Das Cockpit verarbeitet Dateien Dritter (Rechnungen, E-Mails, Exporte). Die Vorlagen setzen Datei- und KI-Inhalte deshalb nur als Text ein (`textContent`), öffnen PDFs mit `isEvalSupported: false` und verwenden SheetJS 0.20.3. Prüfen Sie die Bibliotheken quartalsweise und bei Sicherheitsmeldungen zeitnah.

## Lizenz
Vorlagen und Beispieldaten: MIT-Lizenz (siehe [LICENSE](LICENSE)). Sie dürfen sie in Ihrer Organisation frei verwenden und anpassen. Die Bibliotheken in `libs/` stehen unter ihren eigenen Lizenzen (siehe [libs/README_LIBS.md](libs/README_LIBS.md)).
