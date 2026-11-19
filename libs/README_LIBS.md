# Lokaler Offline-Bibliotheksordner (`/libs`) — 100 % Intranet-Fähigkeit

Für den komplett abgeschotteten Betrieb ohne Internetverbindung (Kapitel 8.1) ersetzen Sie sämtliche externen `<script src="https://cdn...">`-Zeilen in Ihrem Cockpit durch lokale relative Pfade in diesen Ordner.

## Vollständige Inventar- und Lizenzliste (für IT-Sicherheit & Übergabepaket Kap. 8.5)

| Datei in `/libs/` | Bibliothek | Eingesetzt ab | Open-Source-Lizenz | Offizielle Bezugsquelle |
|---|---|---|---|---|
| `mermaid.min.js` | Mermaid.js (v10.9.1) | Stufe 1 / 2 | MIT License | https://mermaid.js.org |
| `bpmn-modeler.development.js` (+ CSS) | bpmn-js (v17.9.1) | Stufe 3 (`prozess_editor.html`) | bpmn.io License (Source-Available; kostenfrei nutzbar, Wasserzeichen/Logo muss sichtbar bleiben) | https://bpmn.io |
| `chart.umd.min.js` | Chart.js (v4.4.3) | Stufe 2 / 3 | MIT License | https://www.chartjs.org |
| `papaparse.min.js` | PapaParse (v5.4.1) | Stufe 3 | MIT License | https://www.papaparse.com |
| `xlsx.full.min.js` | SheetJS Community (v0.18.5) | Stufe 3 | Apache-2.0 License | https://sheetjs.com |
| `vis-network.min.js` | Vis.js Network (v9.1.9) | Stufe 4 | MIT / Apache-2.0 Dual | https://visjs.org |
| `sql-wasm.js` & `sql-wasm.wasm` | sql.js (v1.10.3) | Stufe 4 | MIT License | https://sql.js.org |
| `pdf.min.js` & `pdf.worker.min.js` | Mozilla pdf.js (v3.11.174) | Stufe 5 | Apache-2.0 License | https://mozilla.github.io/pdf.js |

## Beispiel-Ersetzung im `<head>` von `cockpit.html`

**Vorher (CDN — Entwicklungsstand):**
```html
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/papaparse@5.4.1/papaparse.min.js"></script>
```

**Nachher (100 % Offline / Intranet):**
```html
<script src="../libs/chart.umd.min.js"></script>
<script src="../libs/papaparse.min.js"></script>
```

## Automatisches Download-Skript (Windows PowerShell — einmalig am Internet-PC ausführen)
```powershell
$libs = @{
  "chart.umd.min.js" = "https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"
  "mermaid.min.js" = "https://cdn.jsdelivr.net/npm/mermaid@10.9.1/dist/mermaid.min.js"
  "papaparse.min.js" = "https://cdn.jsdelivr.net/npm/papaparse@5.4.1/papaparse.min.js"
  "xlsx.full.min.js" = "https://cdn.jsdelivr.net/npm/xlsx@0.18.5/dist/xlsx.full.min.js"
  "vis-network.min.js" = "https://unpkg.com/vis-network@9.1.9/standalone/umd/vis-network.min.js"
  "sql-wasm.js" = "https://cdn.jsdelivr.net/npm/sql.js@1.10.3/dist/sql-wasm.js"
  "sql-wasm.wasm" = "https://cdn.jsdelivr.net/npm/sql.js@1.10.3/dist/sql-wasm.wasm"
  "pdf.min.js" = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.min.js"
  "pdf.worker.min.js" = "https://cdnjs.cloudflare.com/ajax/libs/pdf.js/3.11.174/pdf.worker.min.js"
}
foreach ($k in $libs.Keys) { Invoke-WebRequest -Uri $libs[$k] -OutFile "./$k" }
```
