# Das KI-Cockpit — Zentrales Begleit-Monorepo

Offizielles Begleit-Repository zum Buch **„Das KI-Cockpit — Prozesse, Zahlen und Abhängigkeiten im Blick: Souveräne Dashboards bauen mit lokaler KI — ohne Vorkenntnisse und Lizenzkosten“** von Michael Estel.

Live-Startseite & Demos: **https://on-premise-ai-cockpit.github.io**

## Ein-Klick-Start für KMU & Behörden (Intranet / Offline)
Klicken Sie oben rechts auf **`Code` → `Download ZIP`**, entpacken Sie den Ordner lokal auf Ihrem Dienstrechner (oder auf Ihrem Netzlaufwerk `L:`) und öffnen Sie `index.html` oder die gewünschte Ausbaustufe direkt im Browser.

## Ordnerstruktur (1:1 zum Buchaufbau)
- `stufe1-diagramme/` — Mermaid-Kostenstruktur (Werkbau Nord GmbH), Behörden-Prozessaufnahme (Mermaid & BPMN 2.0 XML) und C4-Architekturdiagramme (PlantUML)
- `stufe2-html-cockpit/` — Statisches Basis-Cockpit (`cockpit.html` mit Chart.js & Reiternavigation)
- `stufe3-dropzone/` — Dynamisches Cockpit mit CSV/XLSX-Dropzone (`cockpit.html`) + lokaler BPMN-Editor (`prozess_editor.html`)
- `stufe4-datenbank-graph/` — SQLite-Datenbank (`sql.js`) & Wissensgraph (`Vis.js`) inkl. Blast-Radius-Analyse
- `stufe5-smart-cockpit/` — Smart-Master-Cockpit mit lokaler Ollama-Anbindung (Rechnungs-Extraktor `pdf.js`, Triage, Firmen-Orakel, LID-Gremiennetz)
- `daten/` — Einheitliche Beispieldatensätze der **Werkbau Nord GmbH** und des **Landesamts für Infrastruktur und Digitalisierung (LID)** (500 Ansprechpartner, 12 Standorte, SQLite-DB, Beispielrechnung, Richtlinie)
- `libs/` — Anleitung, Lizenzliste (SBOM) & PowerShell-Skript für 100 % Offline-/Intranet-Betrieb ohne externe CDNs
- `betrieb-uebergabe/` — Fertige Vorlage für das Übergabepaket an IT-Abteilung, Informationssicherheit (ISB) und Personalrat (Kapitel 8.5)
