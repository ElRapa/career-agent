# Workflow: CV-Tailoring & Generation

Folge diesen Schritten strikt der Reihe nach:

## Schritt 0: Konfiguration & Pfade laden
1. Lade `.env` bzw. die Konfiguration:
   - Ermittle `OBSIDIAN_VAULT_PATH` und `OBSIDIAN_CAREER_SUBDIR`.
   - Ermittle `CV_ACCENT_COLOR` (Standard: `#1a5fb4`).
   - Ermittle `OUTPUT_DIR` (Standard: `./output`).

## Schritt 1: Stellenausschreibung analysieren
1. Lies die übergebene Stellenausschreibung (Text / Datei).
2. Folge den Richtlinien in `packs/shared/job-analysis.md`.
3. Notiere:
   - Zielrolle & Unternehmen.
   - Top 5 Kernkompetenzen (Must-Haves).
   - ATS-Keywords.

## Schritt 2: Obsidian-Vault Discovery
1. Durchsuche den konfigurierten Obsidian-Pfad:
   - Profil-/Basisdaten (Kontaktdaten, bisherige Titel).
   - Ausbildungs- und Zertifizierungsnotizen.
   - Skill-Katalog.
   - Projekt- und Stationennotizen.
2. Identifiziere die 3–5 Projekte, die die stärkste Deckung mit den Must-Haves der Stellenausschreibung aufweisen.

## Schritt 3: Drafting `cv_data.json`
Erstelle eine JSON-Datei mit folgender Struktur:
```json
{
  "personal": {
    "name": "...",
    "title": "...",
    "email": "...",
    "phone": "...",
    "location": "...",
    "linkedin": "...",
    "github": "..."
  },
  "accent_color": "#1a5fb4",
  "language": "de",
  "summary": "3-4 prägnante Sätze: USP, Schwerpunkte und spezifischer Mehrwert für die Zielrolle.",
  "skills": [
    {
      "category": "Cloud & DevOps",
      "items": ["AWS", "Kubernetes", "Terraform", "CI/CD"]
    }
  ],
  "projects": [
    {
      "title": "Projektname",
      "client": "Branche / Kunde",
      "role": "Rolle im Projekt",
      "period": "01/2023 – 12/2023",
      "tech": ["Python", "Databricks", "Azure"],
      "bullets": [
        "Aktionsorientierter Bulletpoint nach STAR mit konkretem Ergebnis",
        "Weiterer Bulletpoint"
      ]
    }
  ],
  "experience": [
    {
      "company": "Firma XYZ",
      "role": "Senior Consultant",
      "location": "Frankfurt / Remote",
      "period": "2021 – heute",
      "bullets": [
        "Kernverantwortung und Schwerpunkte"
      ]
    }
  ],
  "education": [
    {
      "degree": "M.Sc. Wirtschaftsinformatik",
      "institution": "Universität XYZ",
      "period": "2015 – 2017"
    }
  ],
  "certifications": [
    {
      "name": "AWS Certified Solutions Architect",
      "issuer": "Amazon Web Services",
      "year": "2023"
    }
  ]
}
```

## Schritt 4: Fact-Checking & Quality Gate
1. Prüfe gegen `packs/shared/conventions.md`:
   - Wurden keine Daten/Zahlen frei erfunden?
   - Sind die ATS-Keywords der Stelle in Skills & Projekten vertreten?
   - Sind die Bulletpoints nach STAR formuliert?

## Schritt 5: Typst-Rendering
Führe das Build-Kommando aus:
```bash
./scripts/render.sh cv <pfad-zu-cv_data.json> <output-pfad.pdf>
```
oder direkt mit Typst:
```bash
typst compile --input data="<pfad-zu-cv_data.json>" templates/cv_modern.typ "<output-pfad.pdf>"
```
