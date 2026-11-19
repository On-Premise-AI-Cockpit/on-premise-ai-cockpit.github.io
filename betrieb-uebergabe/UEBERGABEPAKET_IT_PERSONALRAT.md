# Übergabepaket für IT-Abteilung, Informationssicherheit (ISB) & Personalrat

**Vorlage aus Kapitel 8.5 („Das KI-Cockpit“)**  
**Organisation:** [Werkbau Nord GmbH / Landesamt für Infrastruktur und Digitalisierung (LID)]  
**Anwendungsname:** Lokales KI-Cockpit (`JJJJ-MM-TT_cockpit_v1.2_stabil.html`)  
**Verantwortliche Fachstelle / Pflege:** [Name, Referat / Abteilung, Vertretung]

---

## 1. Kurzbeschreibung & Zweckbestimmung
Das KI-Cockpit ist eine rein clientseitige HTML-/JavaScript-Anwendung zur internen Visualisierung von Kennzahlen, Geschäftsprozessen (BPMN/Mermaid), Systemabhängigkeiten (Wissensgraph) und optionalen lokalen Dokumentenauswertungen. Es ersetzt fehleranfällige statische Excel-/PowerPoint-Sammlungen, eliminiert Dokumentationsverfall („Doc-Rot“) und schließt fachliche Lücken als schneller, governance-konformer **Quick Win** – ohne die zentrale IT mit einem mehrjährigen Großprojekt zu belasten und ohne unkontrollierte Schatten-IT zu erzeugen.

## 2. Architekturskizze & Datenfluss-Nachweis (Rein lokale Verarbeitung)
- **Ausführungsort:** Ausschließlich im lokalen Webbrowser (Microsoft Edge / Firefox / Chrome) des jeweiligen Dienstrechners.
- **Kein externer Server / Keine Cloud:** Es existieren weder externe Datenbanken noch Cloud-Uploads oder Telemetrie-Aufrufe.
- **100 % Offline-Fähigkeit:** Alle verwendeten JavaScript-Open-Source-Bibliotheken liegen fest versioniert im lokalen Verzeichnis `/libs/`. Im Browser-Netzwerkmonitor (`F12 → Netzwerk`) sind bei der Ausführung **0 ausgehende externe Verbindungen** nachweisbar.
- **Datenhaltung (Tankdeckel-Prinzip):** Die HTML-Datei selbst enthält keine produktiven Echtdaten. Fachdaten (`.csv`, `.xlsx`, `.sqlite`, `.pdf`) werden lokal über den Browser-`FileReader` in den flüchtigen Arbeitsspeicher geladen und beim Schließen des Tabs automatisch verworfen.
- **Optionale KI-Schnittstelle (Stufe 5):** Erfolgt ausschließlich über die lokale Loopback-Adresse (`127.0.0.1` / `localhost`) an eine lokal freigegebene Instanz von Ollama oder `llama-server` mit restriktivem Origin (kein Wildcard `*`) und nach der Zündschlüssel-Regel (nur bei aktivem Bedarf gestartet).

## 3. Verzeichnis der Bibliotheks-Lizenzen (SBOM)
Siehe beigefügte Tabelle in `/libs/README_LIBS.md` – ausschließlich etablierte, kommerziell und behördlich kostenfrei nutzbare Lizenzen (**MIT**, **Apache-2.0** sowie für den optionalen Prozess-Editor die **bpmn.io-Lizenz** mit der einzigen Auflage, dass das kleine `bpmn.io`-Logo im Diagramm sichtbar bleibt). Keine GPL-Verpflichtungen zur Offenlegung eigener Geschäftsdaten, **0 Euro laufende Lizenzkosten**.

## 4. Mitbestimmung / Personalrats-Hinweis (Behörde & Betriebsrat)
- **Keine Leistungs- oder Verhaltenskontrolle:** Das Cockpit speichert keine Nutzungsprotokolle, Klick-Historien oder personenbezogene Arbeitszeit-Auswertungen von Beschäftigten.
- Das Kontakt- und Gremien-Dashboard bildet ausschließlich ohnehin im Intranet/Organigramm vorhandene dienstliche Zuständigkeiten ab.
- Optionale KI-Vorschläge (Stufe 5) dienen ausschließlich als Entwurfshilfe; die fachliche Prüfung und Entscheidung verbleibt stets beim Menschen.

## 5. Betriebs-, Rollen- & Pflegekonzept
- **Ablageort:** Internes Netzlaufwerk `L:\Controlling\KI-Cockpit\` bzw. synchronisierte SharePoint-Bibliothek.
- **Rechtekonzept:**
  - *Schreibrechte (Pflege):* Ausschließlich Fachverantwortliche + benannte Vertretung (2 Personen).
  - *Leserechte (Nutzung):* Alle berechtigten Mitarbeitenden der Fachabteilung / Leitungsebene.
- **Versionierung:** Klare Datums- und Statuskonvention (`JJJJ-MM-TT_cockpit_vX.Y_stabil.html`); Vorversionen verbleiben im Unterordner `/archiv/` als sofortiges Rollback.
- **Pflegeaufwand:** Geschätzt ca. 2–4 Stunden pro Quartal für fachliche Anpassungen und jährliche Aktualisierung der `/libs`-Bibliotheken.

## 6. Governance-Nachweis: Kontrollierte Selbsthilfe statt Schatten-IT (Die 6 Leitplanken)
| Prüfpunkt | Unkontrollierte Schatten-IT (Risiko) | Dieses KI-Cockpit (Governance-konformer Quick Win) |
|---|---|---|
| **1. Datenhaltung** | Sensible Exporte in fremden Cloud-Tools oder fest im Code gespeichert | **Tankdeckel-Prinzip:** Datei bleibt datenfrei; Fachdaten nur lokal im Browser-RAM |
| **2. Netzwerk & Offline** | Lädt ungeprüfte Skripte aus dem Internet oder sendet Telemetrie | **Lokaler `/libs`-Ordner:** 0 ausgehende Verbindungen (`F12 → Netzwerk`) |
| **3. Lokale KI-Brücke** | Pauschale Öffnung (`OLLAMA_ORIGINS="*"`) oder Cloud-Upload vertraulicher PDFs | **Gezielte Freigabe (`127.0.0.1`)** für Ollama/`llama-server` + Zündschlüssel-Regel |
| **4. Verantwortung & Pflege** | Einzelkämpfer ohne Vertretung; unklare Dateiversionen | **Zwei Pflege-Verantwortliche** (inkl. Vertretung), Versionierung + `/archiv/` |
| **5. Lizenz- & Prüfsicherheit** | Unklare Fremd-Tools oder versteckte Abo-Modelle | **Dokumentierte SBOM** (MIT, Apache-2.0, `bpmn.io`-Lizenz) + C4-Architekturskizze |
| **6. Mitbestimmung & Kontrolle** | Undurchsichtige Automatik oder Nutzer-Tracking | **Keine Leistungskontrolle**, kein Login-Tracking; Mensch prüft und entscheidet |
