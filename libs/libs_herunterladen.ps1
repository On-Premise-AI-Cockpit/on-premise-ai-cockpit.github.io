# libs_herunterladen.ps1 – lädt alle Bibliotheken des KI-Cockpits einmalig in diesen Ordner (libs/)
#
# Warum ein Skript? Die Bibliotheken stehen unter eigenen Lizenzen (MIT, Apache-2.0, bpmn.io-Lizenz).
# Damit das Begleit-Repository schlank und lizenzrechtlich eindeutig bleibt, liegen die Binärdateien
# nicht im Repository. Führen Sie dieses Skript EINMAL an einem Rechner mit Internetzugang aus.
# Danach laufen die Cockpits ohne Internet. Den gefüllten Ordner libs/ kopieren Sie anschließend
# neben Ihr Cockpit (Abschnitt 8.1) bzw. auf das Netzlaufwerk.
#
# Aufruf: Rechtsklick auf die Datei -> "Mit PowerShell ausführen"
#   oder: powershell -ExecutionPolicy Bypass -File .\libs_herunterladen.ps1
# Lässt Ihr Rechner keine Skripte zu, bitten Sie Ihre IT, die Dateien aus der Liste in README_LIBS.md bereitzustellen.

$ErrorActionPreference = "Stop"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ziel = $PSScriptRoot
$jsd  = "https://cdn.jsdelivr.net/npm"

$dateien = [ordered]@{
  # Stufe 2
  "chart.umd.min.js"                 = "$jsd/chart.js@4.4.3/dist/chart.umd.min.js"
  "mermaid.min.js"                   = "$jsd/mermaid@10.9.8/dist/mermaid.min.js"
  # Stufe 3
  "papaparse.min.js"                 = "$jsd/papaparse@5.4.1/papaparse.min.js"
  "xlsx.full.min.js"                 = "https://cdn.sheetjs.com/xlsx-0.20.3/package/dist/xlsx.full.min.js"
  # Stufe 3 – Zusatzwerkzeug prozess_editor.html (bpmn-js, bpmn.io-Lizenz: Logo im Diagramm sichtbar lassen)
  "bpmn-modeler.development.js"      = "$jsd/bpmn-js@17.9.1/dist/bpmn-modeler.development.js"
  "diagram-js.css"                   = "$jsd/bpmn-js@17.9.1/dist/assets/diagram-js.css"
  "bpmn-js.css"                      = "$jsd/bpmn-js@17.9.1/dist/assets/bpmn-js.css"
  "bpmn-font/css/bpmn.css"           = "$jsd/bpmn-js@17.9.1/dist/assets/bpmn-font/css/bpmn.css"
  "bpmn-font/font/bpmn.woff2"        = "$jsd/bpmn-js@17.9.1/dist/assets/bpmn-font/font/bpmn.woff2"
  "bpmn-font/font/bpmn.woff"         = "$jsd/bpmn-js@17.9.1/dist/assets/bpmn-font/font/bpmn.woff"
  "bpmn-font/font/bpmn.ttf"          = "$jsd/bpmn-js@17.9.1/dist/assets/bpmn-font/font/bpmn.ttf"
  "bpmn-font/font/bpmn.eot"          = "$jsd/bpmn-js@17.9.1/dist/assets/bpmn-font/font/bpmn.eot"
  "bpmn-font/font/bpmn.svg"          = "$jsd/bpmn-js@17.9.1/dist/assets/bpmn-font/font/bpmn.svg"
  # Stufe 4
  "sql-wasm.js"                      = "$jsd/sql.js@1.10.3/dist/sql-wasm.js"
  "sql-wasm.wasm"                    = "$jsd/sql.js@1.10.3/dist/sql-wasm.wasm"
  "vis-network.min.js"               = "$jsd/vis-network@9.1.9/standalone/umd/vis-network.min.js"
  # Stufe 5 (pdf.js immer mit isEvalSupported: false verwenden, siehe Cockpit-Code)
  "pdf.min.js"                       = "$jsd/pdfjs-dist@3.11.174/build/pdf.min.js"
  "pdf.worker.min.js"                = "$jsd/pdfjs-dist@3.11.174/build/pdf.worker.min.js"
  # Lizenztexte (gehören zur Weitergabe dazu)
  "lizenzen/chart.js_LICENSE.md"     = "$jsd/chart.js@4.4.3/LICENSE.md"
  "lizenzen/mermaid_LICENSE"         = "https://raw.githubusercontent.com/mermaid-js/mermaid/develop/LICENSE"  # npm-Paket enthält keinen Lizenztext
  "lizenzen/papaparse_LICENSE"       = "$jsd/papaparse@5.4.1/LICENSE"
  "lizenzen/sheetjs_LICENSE"         = "https://cdn.sheetjs.com/xlsx-0.20.3/package/LICENSE"
  "lizenzen/bpmn-js_LICENSE"         = "$jsd/bpmn-js@17.9.1/LICENSE"
  "lizenzen/sql.js_LICENSE"          = "$jsd/sql.js@1.10.3/LICENSE"
  "lizenzen/vis-network_LICENSE-MIT" = "$jsd/vis-network@9.1.9/LICENSE-MIT"
  "lizenzen/vis-network_LICENSE-APACHE-2.0" = "$jsd/vis-network@9.1.9/LICENSE-APACHE-2.0"
  "lizenzen/pdfjs-dist_LICENSE"      = "$jsd/pdfjs-dist@3.11.174/LICENSE"
}

$fehler = 0
foreach ($name in $dateien.Keys) {
  $pfad = Join-Path $ziel $name
  New-Item -ItemType Directory -Force -Path (Split-Path $pfad) | Out-Null
  try {
    Invoke-WebRequest -Uri $dateien[$name] -OutFile $pfad -UseBasicParsing
    Write-Host ("OK      {0}" -f $name)
  } catch {
    Write-Host ("FEHLER  {0}  ({1})" -f $name, $_.Exception.Message) -ForegroundColor Red
    $fehler++
  }
}

# Prüfsummen für die Dokumentation (Übergabepaket / SBOM)
$summen = Get-ChildItem $ziel -Recurse -File | Where-Object { $_.Name -notmatch '\.(md|ps1|txt)$' -and $_.DirectoryName -notmatch 'lizenzen' } |
  Get-FileHash -Algorithm SHA256 |
  ForEach-Object { "{0}  {1}" -f $_.Hash, $_.Path.Substring($ziel.Length + 1) }
$summen | Set-Content -Encoding UTF8 (Join-Path $ziel "SHA256SUMS.txt")

if ($fehler -eq 0) {
  Write-Host "`nFertig: Alle Dateien liegen in $ziel. Prüfsummen: SHA256SUMS.txt" -ForegroundColor Green
} else {
  Write-Host "`n$fehler Datei(en) fehlen. Prüfen Sie Internetzugang bzw. Proxy und starten Sie das Skript erneut." -ForegroundColor Yellow
}
