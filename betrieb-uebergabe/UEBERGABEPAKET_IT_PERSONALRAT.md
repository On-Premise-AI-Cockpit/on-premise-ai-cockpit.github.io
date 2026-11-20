# Übergabepaket für IT, Informationssicherheit, Datenschutz und Personal- bzw. Betriebsrat

**Vorlage zu Abschnitt 8.5 des Buchs „Das KI-Cockpit“** – bitte die Angaben in [eckigen Klammern] ersetzen.
Diese Vorlage ersetzt keine Rechtsberatung. Einzelheiten klären Sie mit Ihrer bzw. Ihrem Datenschutzbeauftragten.

| Feld | Angabe |
|---|---|
| Organisation | [Werkbau Nord GmbH / Landesamt für Infrastruktur und Digitalisierung (LID)] |
| Anwendung | Lokales KI-Cockpit, aktive Datei `[JJJJ-MM-TT]_cockpit_v[X.Y]_stabil.html` (Beispiel: `2026-11-18_cockpit_v1.2_stabil.html`) |
| Ausbaustand | [Stufe 3: Dropzone / Stufe 4: + Datenbank und Wissensgraph / Stufe 5: + lokale KI] |
| Pflege-Verantwortliche | [Name, Organisationseinheit] und Vertretung [Name] |
| Ablageort | [z. B. `L:\Controlling\KI-Cockpit\` oder synchronisierte SharePoint-Bibliothek] |
| Stand dieses Pakets | [Datum] |

ISB und DSB beraten und prüfen. Mitbestimmungsrechte hat der Personal- bzw. Betriebsrat.

---

## 1. Kurzbeschreibung und Zweck
Das KI-Cockpit ist eine HTML-/JavaScript-Datei, die im Standard-Browser läuft. Es zeigt Kennzahlen, Prozesse (Mermaid/BPMN) und Abhängigkeiten (Wissensgraph). Ab Stufe 5 kann es Texte mit einer **lokal** laufenden KI auswerten. Zweck: [konkreter Zweck, z. B. „Monatsabschluss der vier Kostenstellen prüfen“].

Das Cockpit trifft keine Entscheidungen über Menschen. KI-Ergebnisse sind als Vorschlag gekennzeichnet; ein Mensch prüft und entscheidet.

## 2. Die sechs Governance-Leitplanken

| Prüfpunkt | Unkontrollierte Schatten-IT (Risiko) | Dieses KI-Cockpit |
|---|---|---|
| 1. Datenhaltung | Sensible Exporte in fremden Cloud-Tools oder fest im Code | Tankdeckel-Prinzip: Die Cockpit-Datei enthält keine produktiven Echtdaten. Mitgelieferte Beispieldaten sind fiktiv; echte Daten laden Nutzende zur Laufzeit. |
| 2. Netzwerk und Offline-Betrieb | Lädt ungeprüfte Skripte aus dem Internet oder sendet Telemetrie | Lokaler `/libs`-Ordner: Das Cockpit lädt keine externen Ressourcen (prüfbar über `F12` → Netzwerk). |
| 3. Lokale KI-Schnittstelle | Ollama aus dem Netz erreichbar, `OLLAMA_ORIGINS="*"`, Cloud-Modelle oder Cloud-Upload vertraulicher PDFs | Ollama nur an `127.0.0.1` gebunden (Standard); nie `*`; `OLLAMA_ORIGINS` nur für eine dokumentierte Intranet-Adresse; Cloud-Funktionen abgeschaltet; `llama-server` mit `--host 127.0.0.1` und API-Schlüssel; Zündschlüssel-Regel |
| 4. Verantwortung und Pflege | Einzelkämpfer ohne Vertretung, kryptische Dateinamen | Zwei Pflege-Verantwortliche mit Vertretung, Versionierung (`v1.2_stabil`) und Unterordner `archiv/` |
| 5. Lizenz- und Prüfsicherheit | Unklare Fremd-Tools oder versteckte Abo-Modelle | Bibliotheksliste mit Version und Lizenz (MIT, Apache-2.0, `bpmn.io`-Lizenz) und C4-Architekturskizze |
| 6. Mitbestimmung und Kontrolle | Undurchsichtige Automatik oder Nutzer-Tracking | Kein Login und keine Nutzungsprotokolle im Cockpit; Inhalte, Zweck und technische Logs offengelegt und abgestimmt; der Mensch entscheidet |

## 3. Die fünf Nachweise

### Nachweis 1 – Architekturskizze (Leitplanke 5)
[C4-System-Context-Diagramm aus Abschnitt 2.4 einfügen.]

Kein zentraler oder öffentlich erreichbarer Webserver, keine externe Datenbank. Stufe 1 bis 3 laufen direkt im Browser. Ab Stufe 4 kommt ein lokaler Mini-Server auf `127.0.0.1:8000` hinzu (`python -m http.server 8000 --bind 127.0.0.1`), ab Stufe 5 Ollama auf `127.0.0.1:11434`. Beide laufen nur während der Arbeit (Zündschlüssel-Regel). Voraussetzung ab Stufe 4: Python, ab Stufe 5: Ollama – beides über die Softwareverteilung bzw. Freigabe der IT.

### Nachweis 2 – Bibliotheks- und Lizenzliste / SBOM (Leitplanke 5)
Siehe `libs/README_LIBS.md` (Datei, Version, Lizenz, Bezugsquelle) und die vom Download-Skript erzeugte Datei `libs/SHA256SUMS.txt` (Prüfsummen). Prüfrhythmus: quartalsweise und bei Sicherheitsmeldungen zeitnah. Hinweise zur aktuellen Fassung: SheetJS 0.20.3 (ältere 0.18.5 hat bekannte Lücken), Mermaid 10.9.8, pdf.js 3.11.174 wird nur mit `isEvalSupported: false` verwendet (Schutz gegen CVE-2024-4367).

### Nachweis 3 – Netzwerk- und KI-Konfiguration (Leitplanken 2 und 3)
- [Screenshot des Netzwerkmonitors aus dem Offline-Test (Abschnitt 8.1): keine externen Anfragen, auch keine fehlgeschlagenen.]
- Der Test belegt das Verhalten der Seite. Für die Systemebene: Ressourcenmonitor (Reiter „Netzwerk“) oder `netstat -ano`.
- `OLLAMA_HOST` bleibt auf `127.0.0.1` (Standard). Ollama lässt Browser-Anfragen von `localhost`/`127.0.0.1` (jeder Port) bereits ab Werk zu. `OLLAMA_ORIGINS` erweitert diese Liste nur, es schränkt nichts ein. Es ist [nicht gesetzt / nur auf die Intranet-Adresse `https://…` gesetzt]; niemals `*`.
- Cloud-Funktionen von Ollama sind abgeschaltet: [Einstellung in der App / `OLLAMA_NO_CLOUD=1` / `"disable_ollama_cloud": true` in `~/.ollama/server.json`, per Richtlinie festgeschrieben].
- `llama-server` (falls genutzt): `--host 127.0.0.1` und `--api-key-file` (siehe `start_llama_server_profil_a.bat`).
- Hinweis für Terminalserver (Citrix/RDS): Dort teilen sich alle angemeldeten Nutzenden `127.0.0.1`. Lokale KI und Mini-Server nur nach Abstimmung mit der IT.

### Nachweis 4 – Mitbestimmungs- und Pflegekonzept (Leitplanken 4 und 6)
**Welche Daten verarbeitet das Cockpit?** [z. B. Kostenstellen-Exporte (keine Personendaten); im LID-Beispiel Funktionen/Stellen mit dienstlichen Ansprechpersonen.]

**Wissensgraph und Kritikalität:** Der Wissensgraph bewertet Funktionen (z. B. „Referatsleitung 32 (IT-Betrieb & Sicherheit)“), nicht Personen. Der Kritikalitätswert steht in der Tabelle `lid_funktionen` und beschreibt die Abhängigkeit der Organisation von der Funktion. Die Tabelle `lid_kontakte` enthält nur Name, Funktion und dienstliche E-Mail. Ausfallszenario: „Funktion unbesetzt / Vertretung nicht geregelt“.

**Protokollierung:** Das Cockpit selbst legt keine Nutzungsprotokolle an: kein Login, keine Erfassung von Klicks oder Bearbeitungszeiten. Ollama, der Mini-Server und die Ollama-Desktop-App können eigene Logs bzw. Chatverläufe schreiben, etwa mit Zeitstempeln der Anfragen. [Regelung: abgeschaltet / Löschung alle … Tage durch die IT.]

**Leistungs- und Verhaltenskontrolle:** Das Cockpit ist nicht dafür ausgelegt und ohne Personenbezug konzipiert. Die Bewertung nimmt der Personal- bzw. Betriebsrat vor. Für die Mitbestimmung zählt die objektive Eignung zur Überwachung, nicht die Absicht; deshalb sind Logs und personenbezogene Inhalte hier offengelegt.

**Pflege:**
- Schreibrechte: zwei benannte Pflege-Verantwortliche; alle übrigen haben Leserechte.
- Versionierung: `JJJJ-MM-TT_cockpit_vX.Y_stabil.html`; Vorversionen im Unterordner `archiv/`.
- Aufwand: ca. 2–4 Stunden pro Quartal für Anpassungen und die Prüfung der Bibliotheken.

### Nachweis 5 – Datenschutz-Einordnung
| Unterlage | Stand |
|---|---|
| Verzeichnis von Verarbeitungstätigkeiten (Art. 30 DSGVO) | [neuer Eintrag / Ergänzung von Eintrag Nr. …, oder: keine personenbezogenen Daten] |
| Datenschutz-Folgenabschätzung (Art. 35 DSGVO) | [Prüfung durch DSB am …: erforderlich / nicht erforderlich, Begründung] |
| Dienst- bzw. Betriebsvereinbarung IT/KI | [Abgleich mit Vereinbarung … vom …] |
| Einstufung nach KI-Verordnung (VO (EU) 2024/1689) | Nach unserer Einschätzung kein Hochrisiko-System: Es trifft keine Entscheidungen über Menschen, ein Mensch prüft jedes KI-Ergebnis. Hochrisiko-Anwendungen nach Anhang III (z. B. Bewerbungsauswahl, Bewertung von Beschäftigten) sind ausgeschlossen. [Einstufung abgestimmt mit … am …] |
| KI-Kompetenz (Art. 4 KI-VO) | Einweisung der Nutzenden am [Datum], dokumentiert in [Ablage] (Abschnitt 8.4) |

Prüfen Sie den aktuellen Stand der KI-Verordnung vor der Übergabe, denn Fristen und Leitlinien ändern sich noch.

## 4. Unterschriften / Kenntnisnahme

| Rolle | Name | Datum | Ergebnis |
|---|---|---|---|
| IT-Abteilung | | | |
| Informationssicherheit (ISB) | | | |
| Datenschutz (DSB) | | | |
| Personal- bzw. Betriebsrat | | | |
| Fachverantwortung | | | |
