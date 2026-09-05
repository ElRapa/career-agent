# Career Agent

Ein schlankes, agentenbasiertes System zur automatischen Erstellung maßgeschneiderter Lebensläufe (CV) und Anschreiben direkt aus deinem persönlichen **Obsidian-Vault**, gerendert mit **Typst** zu erstklassigen PDFs.

Inspiriert von der modularen Pack- und Workflow-Architektur des `exxfer-agent`.

---

## 🏗️ Architektur im Überblick

```
career-agent/
├── .env                  # Lokale Pfade (Obsidian Vault, Akzentfarbe, etc.)
├── .env.example          # Vorlage für Umgebungsvariablen
├── templates/
│   ├── cv_modern.typ     # Modernes, visuelles Typst-Template für CVs (Badges, Pills, Cards)
│   └── cover_letter_modern.typ # Passendes Anschreiben-Template (Header, DIN-Absätze)
├── packs/                # Modulare Instruktionen für den KI-Agenten
│   ├── shared/           # Fact-Checking (Anti-Halluzination), STAR-Methode, ATS-Optimierung
│   ├── cv-tailored/      # Workflow & Schema für maßgeschneiderte Lebensläufe
│   └── cover-letter/     # Workflow & Schema für zielgerichtete Anschreiben
├── scripts/
│   ├── render.sh         # Wrapper für Typst-Kompilierung (JSON -> PDF)
│   └── vault_helper.py   # CLI-Tool zum Inspizieren und Durchsuchen des Vaults
├── sample-data/          # Beispieldaten & Obsidian-Notizvorlagen
└── output/               # Generierte PDFs und Zwischendateien
```

---

## ⚡ Schnelleinstieg

### 1. Voraussetzungen
* **Typst**: `brew install typst`
* **Python 3**: Bereits auf macOS vorinstalliert

### 2. Konfiguration
Passe die Datei `.env` an:
```bash
# Pfad zu deinem Obsidian Vault (dynamisch & nicht gehardcoded)
OBSIDIAN_VAULT_PATH="/path/to/your/obsidian-vault"

# Optionaler Unterordner im Vault
OBSIDIAN_CAREER_SUBDIR=""

# Akzentfarbe für Überschriften und Badges (z.B. #1a5fb4, #0f4c81, #0d5c75)
CV_ACCENT_COLOR="#1a5fb4"
```

### 3. Testlauf & Befehle
```bash
# 1. Prüfen, ob Obsidian-Notizen gefunden werden
make status

# 2. Vault nach bestimmten Skills/Begriffen durchsuchen
make search q=Databricks

# 3. Test-Lebenslauf als PDF kompilieren
make test-cv

# 4. Test-Anschreiben als PDF kompilieren
make test-letter
```

---

## 🤖 Wie der Agent arbeitet (Workflow)

Wenn du eine neue Bewerbung erstellen willst, übergibst du dem Agenten (z.B. im Copilot-Chat) einfach die Stellenausschreibung:

1. **Job-Analyse (`packs/shared/job-analysis.md`)**:
   - Der Agent extrahiert Kernanforderungen (Must-Haves, Nice-to-Haves) und ATS-Keywords.
2. **Vault-Matching**:
   - Der Agent durchsucht deine Obsidian-Notizen nach den passenden Projekten und Stationen.
3. **Drafting (`cv_data.json`)**:
   - Der Agent formuliert Projekt-Bullets nach der **STAR-Methode** (*Situation, Task, Action, Result*) um, ohne Fakten zu erfinden (`packs/shared/conventions.md`).
4. **PDF-Kompilierung**:
   - Der Agent ruft `./scripts/render.sh` auf – in Millisekunden entsteht ein perfektes PDF in `output/`.
