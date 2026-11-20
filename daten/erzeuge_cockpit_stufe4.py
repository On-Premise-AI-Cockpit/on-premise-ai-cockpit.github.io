# -*- coding: utf-8 -*-
"""
Erzeugt die Beispieldatenbank daten/cockpit_stufe4.sqlite für Stufe 4 (Kapitel 5).

Aufruf (im Ordner daten/):   python erzeuge_cockpit_stufe4.py

Quelle der Behördendaten ist die Datei behoerde_kontakte_500.csv (Trennzeichen ;).
Alle Namen, Funktionen und Beträge sind fiktiv.

Aufbau der Datenbank:
  kmu_buchungen    Einzelbuchungen März 2026 der Werkbau Nord GmbH (11 Zeilen)
  lid_funktionen   500 Funktionen/Stellen des LID mit Gremien, Fachverfahren und
                   Funktions-Kritikalität (10–95). Bewertet wird die Funktion,
                   nicht die Person, die sie gerade innehat.
  lid_kontakte     500 dienstliche Ansprechpartner – nur Name, Funktion und
                   dienstliche E-Mail, bewusst OHNE Kritikalitätswert.
  lid_beschluesse  offene Gremienbeschlüsse (Grundlage für Stufe 5)
  lid_uebersicht   Sicht (View), die Funktion und Ansprechpartner verbindet

Hinweis: Bevor Sie echte Organisationsdaten verwenden, beteiligen Sie
Datenschutz und Personal- bzw. Betriebsrat (Verzeichnis von Verarbeitungs-
tätigkeiten, ggf. Dienst-/Betriebsvereinbarung).
"""
import csv
import os
import sqlite3

ORDNER = os.path.dirname(os.path.abspath(__file__))
CSV_DATEI = os.path.join(ORDNER, "behoerde_kontakte_500.csv")
DB_DATEI = os.path.join(ORDNER, "cockpit_stufe4.sqlite")

KMU_BUCHUNGEN = [
    # id, datum, monat, kostenstelle, kategorie, kostenart, lieferant, projekt, plan_eur, ist_eur, status
    (1, "2026-03-02", "2026-03", "KS-100", "Fix", "Personal & Hallenmiete", "Werkbau Lohn/Miete", "Grundbetrieb", 175000, 175000, "OK"),
    (2, "2026-03-05", "2026-03", "KS-100", "Variabel", "Material & Fertigung", "Stahlhandel Weser AG", "Projekt Halle 4", 68000, 68200, "OK"),
    (3, "2026-03-11", "2026-03", "KS-100", "Variabel", "Material & Fertigung", "Hanse Blechtechnik", "Projekt Logistikpark", 50000, 49800, "OK"),
    (4, "2026-03-14", "2026-03", "KS-100", "Variabel", "Fremdmontage & Subunternehmer", "NordMontage Partner GmbH", "Projekt Halle 4", 28000, 52400, "AUSREISSER"),
    (5, "2026-03-21", "2026-03", "KS-100", "Variabel", "Fremdmontage & Subunternehmer", "NordMontage Partner GmbH", "Projekt Halle 4", 24000, 38000, "AUSREISSER"),
    (6, "2026-03-04", "2026-03", "KS-200", "Fix", "Vertrieb Grundkosten", "Intern Vertrieb", "Grundbetrieb", 34000, 34000, "OK"),
    (7, "2026-03-18", "2026-03", "KS-200", "Variabel", "Provisionen & Reisekosten", "Diverse Reise/Prov.", "Akquise Q1", 58000, 57600, "OK"),
    (8, "2026-03-03", "2026-03", "KS-300", "Fix", "ERP-Lizenzen, Netz & Wartung", "ERP-Systemhaus Nord", "IT-Basis", 38800, 38800, "OK"),
    (9, "2026-03-09", "2026-03", "KS-300", "Fix", "ERP-Lizenzen, Netz & Wartung", "SafeCloud Backup GmbH", "IT-Sicherheit", 9200, 9200, "OK"),
    (10, "2026-03-19", "2026-03", "KS-300", "Fix", "ERP-Lizenzen, Netz & Wartung", "SafeCloud Backup GmbH", "IT-Sicherheit", 0, 9200, "DOPPELABRECHNUNG"),
    (11, "2026-03-01", "2026-03", "KS-400", "Fix", "Verwaltung & Zentrale", "Werkbau Zentrale", "Grundbetrieb", 85000, 85000, "OK"),
]

LID_BESCHLUESSE = [
    # id, gremium, standort, zustaendig (Funktion), ansprechpartner, thema, offen_seit, status
    (1, "DigitalPakt-Netzausbau", "Regionalstelle Sued (Goettingen)", "Koordination DigitalPakt (Ref. 51), Regionalstelle Sued", "Anja Krueger", "Glasfaser-Anbindung Berufsschulen Los 3", "2026-01-19", "Offen (ueberfaellig)"),
    (2, "IT-Lenkungsausschuss", "Zentrale Nord (Hannover)", "Referatsleitung Ref. 32 IT-Betrieb & Sicherheit", "Dr. Sabine Weber", "Freigabe lokales KI-Cockpit (Offline /libs)", "2026-02-28", "In Pruefung"),
    (3, "Vergabeausschuss Nord", "Zentrale Nord (Hannover)", "Teamleitung Vergabestelle (Ref. 21), Vorsitz Vergabeausschuss Nord", "Stefan Hartmann", "Rahmenvertrag eVergabe-Schnittstelle", "2026-01-12", "Offen (ueberfaellig)"),
    (4, "Architektur-Board", "Zentrale Nord (Hannover)", "Fachreferat IT-Architektur (Ref. 32)", "Kerstin Lindner", "Abloesung Altsystem Liegenschaftskataster", "2026-02-10", "Offen"),
]


def main():
    if os.path.exists(DB_DATEI):
        os.remove(DB_DATEI)
    db = sqlite3.connect(DB_DATEI)
    db.executescript(
        """
        CREATE TABLE kmu_buchungen (
            id INTEGER PRIMARY KEY, datum TEXT, monat TEXT, kostenstelle TEXT,
            kategorie TEXT, kostenart TEXT, lieferant TEXT, projekt TEXT,
            plan_eur REAL, ist_eur REAL, status TEXT
        );
        CREATE TABLE lid_funktionen (
            id INTEGER PRIMARY KEY,
            funktion TEXT,              -- Bezeichnung der Funktion/Stelle
            ebene TEXT,                 -- z. B. Referatsleitung, Teamleitung, Sachbearbeitung
            referat TEXT,
            standort TEXT,
            gremien TEXT,               -- mehrere Werte mit ; getrennt
            fachverfahren TEXT,         -- mehrere Werte mit ; getrennt
            kritikalitaet INTEGER,      -- Abhängigkeit der Organisation von der FUNKTION (10–95)
            vertretung_geregelt TEXT    -- ja / nein
        );
        CREATE TABLE lid_kontakte (
            id INTEGER PRIMARY KEY,
            name TEXT,                  -- dienstliche Ansprechperson der Funktion
            funktion_id INTEGER REFERENCES lid_funktionen(id),
            email TEXT
        );
        CREATE TABLE lid_beschluesse (
            id INTEGER PRIMARY KEY, gremium TEXT, standort TEXT, zustaendig TEXT,
            ansprechpartner TEXT, thema TEXT, offen_seit TEXT, status TEXT
        );
        CREATE VIEW lid_uebersicht AS
            SELECT f.id, f.funktion, f.ebene, f.referat, f.standort, f.gremien,
                   f.fachverfahren, f.kritikalitaet, f.vertretung_geregelt,
                   k.name AS ansprechpartner, k.email
            FROM lid_funktionen f
            LEFT JOIN lid_kontakte k ON k.funktion_id = f.id;
        """
    )
    db.executemany("INSERT INTO kmu_buchungen VALUES (?,?,?,?,?,?,?,?,?,?,?)", KMU_BUCHUNGEN)
    db.executemany("INSERT INTO lid_beschluesse VALUES (?,?,?,?,?,?,?,?)", LID_BESCHLUESSE)

    with open(CSV_DATEI, encoding="utf-8-sig", newline="") as f:
        for z in csv.DictReader(f, delimiter=";"):
            i = int(z["ID"])
            db.execute(
                "INSERT INTO lid_funktionen VALUES (?,?,?,?,?,?,?,?,?)",
                (i, z["Funktion"], z["Ebene"], z["Referat"], z["Standort"], z["Gremien"],
                 z["Fachverfahren"], int(z["Kritikalitaet_Funktion"]), z["Vertretung_geregelt"]),
            )
            db.execute("INSERT INTO lid_kontakte VALUES (?,?,?,?)", (i, z["Ansprechpartner"], i, z["Email"]))
    db.commit()

    n = db.execute("SELECT COUNT(*) FROM lid_kontakte").fetchone()[0]
    s = db.execute("SELECT COUNT(DISTINCT standort) FROM lid_funktionen").fetchone()[0]
    r = db.execute("SELECT COUNT(DISTINCT referat) FROM lid_funktionen").fetchone()[0]
    db.close()
    db_vacuum = sqlite3.connect(DB_DATEI)
    db_vacuum.execute("VACUUM")
    db_vacuum.close()
    print(f"Fertig: {DB_DATEI}")
    print(f"{n} Ansprechpartner, {s} Standorte, {r} Referate")


if __name__ == "__main__":
    main()
