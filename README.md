# Das KI-Cockpit — Zentrales Begleit-Monorepo

Offizielles Begleit-Repository zum Buch **„Das KI-Cockpit — Prozesse, Zahlen und Abhängigkeiten im Blick: Souveräne Dashboards bauen mit lokaler KI — ohne Vorkenntnisse und Lizenzkosten“** von Michael Estel.

Live-Startseite & Demos: **https://on-premise-ai-cockpit.github.io**  
Druckfertiger 1-Seiten-Spickzettel (DIN A4): **[KI-Cockpit_Spickzettel_A4.pdf](KI-Cockpit_Spickzettel_A4.pdf)**

## Warum dieses Repository? KI-Quick-Wins statt jahrelanger IT-Projekte
Große IT-Projekte in Unternehmen und Behörden dauern oft Jahre und kosten hohe Budgets – dabei lösen im Alltag häufig kleine, KI-gestützte **Quick Wins** das Problem sofort. Jede Mitarbeiterin und jeder Mitarbeiter sollte heute in der Lage sein, sich kleine digitale Hilfsmittel selbst mit KI zu bauen – **sicher, nachvollziehbar und governance-konform statt als unkontrollierte Schatten-IT.**

Dieses Monorepo liefert alle funktionsfähigen Vorlagen, Beispieldaten und IT-Freigabedokumente direkt zum Nachbauen – **ohne Vorkenntnisse, ohne Cloud-Zwang und für 0 Euro Lizenzkosten**.

## Ein-Klick-Start für KMU & Behörden (Intranet / Offline)
Klicken Sie oben rechts auf **`Code` → `Download ZIP`**, entpacken Sie den Ordner lokal auf Ihrem Dienstrechner (oder auf Ihrem Netzlaufwerk `L:`) und öffnen Sie `index.html` oder die gewünschte Ausbaustufe direkt im Browser.

## Ordnerstruktur (1:1 zum Buchaufbau)
- `KI-Cockpit_Spickzettel_A4.pdf` – Druckfertige DIN-A4-Kompakt-Referenz (5 Ausbaustufen, 6 Governance-Leitplanken, Master-Prompts & Startbefehle)
- `stufe1-diagramme/` – Mermaid-Kostenstruktur (*Werkbau Nord GmbH*), Behörden-Prozessaufnahme (*Landesamt LID*, Mermaid & BPMN 2.0 XML) und C4-Architekturdiagramme (PlantUML)
- `stufe2-html-cockpit/` – Statisches Basis-Cockpit (`cockpit.html` mit Chart.js & Reiternavigation)
- `stufe3-dropzone/` – Dynamisches Cockpit mit CSV/XLSX-Dropzone (`cockpit.html`) + lokaler BPMN-Editor (`prozess_editor.html`)
- `stufe4-datenbank-graph/` – SQLite-Datenbank (`sql.js`) & Wissensgraph (`Vis.js`) inkl. mehrstufiger Blast-Radius-Analyse
- `stufe5-smart-cockpit/` – Smart-Master-Cockpit mit lokaler Ollama-/`llama-server`-Anbindung (Rechnungs-Extraktor `pdf.js`, Triage, Firmen-Orakel, LID-Gremiennetz)
- `daten/` – Einheitliche Beispieldatensätze der **Werkbau Nord GmbH** und des **Landesamts für Infrastruktur und Digitalisierung (LID)** (500 Ansprechpartner, 12 Standorte, SQLite-DB, Beispielrechnung, Richtlinie)
- `libs/` – Anleitung, Lizenzliste (SBOM) & PowerShell-Skript für 100 % Offline-/Intranet-Betrieb ohne externe CDNs
- `betrieb-uebergabe/` – Fertige Vorlage für das Übergabepaket an IT-Abteilung, Informationssicherheit (ISB) und Personalrat inkl. der **6 Governance-Leitplanken** (Kapitel 8.5)

## Governance statt Schatten-IT: Die 6 Leitplanken (Kapitel 8.5)
1. **Datenhaltung (Tankdeckel-Prinzip):** HTML-Datei bleibt datenfrei; Fachdaten nur lokal im flüchtigen Browser-Arbeitsspeicher.
2. **100 % Offline-Fähigkeit (`/libs/`):** Keine externen Skripte – prüfbar über `F12 → Netzwerk` (exakt `0` ausgehende Verbindungen).
3. **Sichere lokale KI-Schnittstelle:** Gezielte Freigabe auf `127.0.0.1` statt pauschaler Wildcard (`*`) + Zündschlüssel-Regel.
4. **Verantwortung & Versionierung:** Zwei benannte Pflege-Verantwortliche (inkl. Vertretung), ISO-Datumsschema und `/archiv/`-Rollback.
5. **Lizenz- & Prüfsicherheit:** Vollständige SBOM (MIT, Apache-2.0, `bpmn.io`-Lizenz) plus 1-seitige C4-Architekturskizze.
6. **Mitbestimmung & Kontrolle:** Kein Login, kein Nutzer-Tracking, keine Leistungskontrolle – der Mensch prüft und entscheidet stets selbst.
