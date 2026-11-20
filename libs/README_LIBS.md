# Lokaler Bibliotheksordner `libs/` – Offline- und Intranet-Betrieb

> [!IMPORTANT]
> **Dieser Ordner enthält im Repository bewusst nur diese Anleitung und das Download-Skript.** Die Bibliotheken selbst stehen unter eigenen Lizenzen; deshalb liefern wir die Binärdateien nicht mit. Führen Sie **einmal** `libs_herunterladen.ps1` an einem Rechner mit Internetzugang aus. Erst danach laufen das ZIP-Paket bzw. Ihr Betriebsordner ohne Internet. In abgeschotteten Netzen bitten Sie Ihre IT, die Dateien aus der Tabelle unten bereitzustellen.

## So laden die Cockpits ihre Bibliotheken
- **Lernstände im Monorepo** (`stufe2-…` bis `stufe5-…/cockpit.html`, `stufe3-dropzone/prozess_editor.html`): zuerst `../libs/` (dieser Ordner, eine Ebene höher), dann `./libs/` (Ordner direkt neben der Datei), zuletzt das Internet (CDN). Ohne gefüllten Ordner laufen sie also online wie im Buch beschrieben, mit gefülltem Ordner auch offline.
- **Betriebsfassung** (`betrieb-uebergabe/2026-11-18_cockpit_v1.2_stabil.html`): zuerst `./libs/` wie im Ordnerbaum aus Abschnitt 8.1, dann `../libs/` (Monorepo) – **nie** aus dem Internet. Fehlt eine Datei, erscheint ein Hinweis statt eines Fehlers.
- Im Buch steht `./libs/`, weil `libs/` dort direkt neben Ihrer Cockpit-Datei liegt. Im Monorepo liegen die Stufen-Dateien eine Ebene tiefer, deshalb `../libs/`. Die Vorlagen probieren beide Pfade, Sie müssen nichts umschreiben.
- Die Fußzeile jedes Cockpits zeigt, woher die Bibliotheken kamen („… lokal aus libs/, … aus dem Internet“). Das hilft beim Offline-Nachweis.

## Inventar- und Lizenzliste (SBOM, für Übergabepaket Abschnitt 8.5)

| Datei in `libs/` | Bibliothek und Version | Eingesetzt ab | Lizenz | Bezugsquelle (vom Skript verwendet) |
|---|---|---|---|---|
| `chart.umd.min.js` | Chart.js 4.4.3 | Stufe 2 | MIT | `cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/` |
| `mermaid.min.js` | Mermaid 10.9.8 | Stufe 2 (Diagramme aus Stufe 1) | MIT | `cdn.jsdelivr.net/npm/mermaid@10.9.8/dist/` |
| `papaparse.min.js` | PapaParse 5.4.1 | Stufe 3 | MIT | `cdn.jsdelivr.net/npm/papaparse@5.4.1/` |
| `xlsx.full.min.js` | SheetJS Community Edition 0.20.3 | Stufe 3 | Apache-2.0 | `cdn.sheetjs.com/xlsx-0.20.3/package/dist/` |
| `bpmn-modeler.development.js`, `diagram-js.css`, `bpmn-js.css`, `bpmn-font/` (css + font) | bpmn-js 17.9.1 | Stufe 3, Zusatzwerkzeug `prozess_editor.html` | bpmn.io-Lizenz (frei nutzbar; das bpmn.io-Logo im Diagramm muss sichtbar bleiben) | `cdn.jsdelivr.net/npm/bpmn-js@17.9.1/dist/` |
| `sql-wasm.js`, `sql-wasm.wasm` | sql.js 1.10.3 | Stufe 4 | MIT | `cdn.jsdelivr.net/npm/sql.js@1.10.3/dist/` |
| `vis-network.min.js` | vis-network 9.1.9 | Stufe 4 | Apache-2.0 oder MIT (dual) | `cdn.jsdelivr.net/npm/vis-network@9.1.9/standalone/umd/` |
| `pdf.min.js`, `pdf.worker.min.js` | Mozilla pdf.js (pdfjs-dist) 3.11.174 | Stufe 5 | Apache-2.0 | `cdn.jsdelivr.net/npm/pdfjs-dist@3.11.174/build/` |
| `lizenzen/` | Lizenztexte aller Bibliotheken | – | – | vom Skript mitgeladen |
| `SHA256SUMS.txt` | Prüfsummen der geladenen Dateien | – | – | vom Skript erzeugt |

### Sicherheitshinweise zu den Versionen
- **SheetJS:** Die über npm/jsDelivr verbreitete Version 0.18.5 hat bekannte Lücken (CVE-2023-30533, CVE-2024-22363). Aktuelle Fassungen gibt es nur über `cdn.sheetjs.com`; verwendet wird 0.20.3.
- **pdf.js:** Version 3.11.174 ist die letzte Fassung als klassische Skriptdatei. Sie ist von CVE-2024-4367 betroffen (präparierte PDFs). Die Cockpits öffnen PDFs deshalb immer mit `isEvalSupported: false`; das ist der vom Hersteller genannte Schutz. Ein Umstieg auf pdf.js ab 4.2.67 wäre nur als JavaScript-Modul möglich, das Browser unter `file://` nicht laden.
- **Mermaid:** 10.9.8 enthält die Korrektur für CVE-2025-54881 (behoben ab 10.9.4).
- **Prüfrhythmus:** quartalsweise und bei Sicherheitsmeldungen zeitnah.

## Download-Skript ausführen
1. Rechtsklick auf `libs_herunterladen.ps1` → **Mit PowerShell ausführen**
   (oder in PowerShell im Ordner `libs`: `powershell -ExecutionPolicy Bypass -File .\libs_herunterladen.ps1`).
2. Das Skript lädt alle Dateien aus der Tabelle in diesen Ordner, legt die Lizenztexte unter `lizenzen/` ab und schreibt `SHA256SUMS.txt`.
3. Kopieren Sie den gefüllten Ordner `libs/` neben Ihre Cockpit-Datei (Betriebsordner, Abschnitt 8.1).

Lässt Ihr Rechner keine PowerShell-Skripte zu, laden Sie die Dateien an einem freigegebenen Internet-Arbeitsplatz einzeln über die Adressen im Skript herunter oder bitten Ihre IT darum.

## Wichtig für Stufe 4 (Datenbank)
`sql.js` lädt `sql-wasm.wasm` nach. Browser blockieren das, wenn Sie die Datei per Doppelklick (`file://`) öffnen. Mit gefülltem `libs/` öffnen Sie das Cockpit deshalb über den lokalen Mini-Server: im Cockpit-Ordner `python -m http.server 8000 --bind 127.0.0.1`, dann `http://127.0.0.1:8000/` im Browser. Python ist auf Dienstrechnern meist nicht vorinstalliert – fragen Sie Ihre IT. Die Reiter „Datenbank“ und „Wissensgraph“ zeigen unter `file://` einen Hinweis; alle anderen Reiter funktionieren weiter.

## Beispiel: CDN-Zeile gegen lokalen Pfad tauschen (eigene Dateien nach Abschnitt 8.1)
```html
<!-- Vorher (CDN, benötigt Internet) -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.3/dist/chart.umd.min.js"></script>
<!-- Nachher (offline; libs/ liegt neben der Cockpit-Datei) -->
<script src="./libs/chart.umd.min.js"></script>
```
