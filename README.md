# Career Agent

Ein schlankes, agentenbasiertes System zur automatischen Erstellung maßgeschneiderter Lebensläufe (CV) und Anschreiben direkt aus deinem persönlichen **Obsidian-Vault**, gerendert mit **Typst** zu erstklassigen PDFs.

Inspiriert von der modularen Pack- und Workflow-Architektur des `exxfer-agent`.

---

## 🏗️ Architektur im Überblick

```
career-agent/
├── .env                  # Lokale Pfade (Obsidian Vault, Akzentfarbe, etc.)
├── .env.example          # Vorlage für Umgebungsvariablen
├── CHANGELOG.md          # Änderungen am Repository und Setup-Hinweise
├── career-agent.code-workspace # VS-Code-Arbeitsbereich
├── templates/
│   ├── cv_modern.typ     # Modernes, visuelles Typst-Template für CVs (Badges, Pills, Cards)
│   └── cover_letter_modern.typ # Passendes Anschreiben-Template (Header, DIN-Absätze)
│   ├── neat_cv.typ        # Adapter für @preview/neat-cv
│   ├── neat_letter.typ    # Kompakter Letter-Adapter im neat-cv-Stil
│   ├── clean_print_cv.typ # Adapter für @preview/clean-print-cv
│   ├── nabcv.typ          # Adapter für @preview/nabcv
│   └── nabcv_letter.typ   # Passender nabcv-Anschreiben-Adapter
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
* **Python 3**: Für `vault_helper.py`; es werden ausschließlich Module aus der Python-Standardbibliothek verwendet
* **Typst**: `brew install typst` für die PDF-Erzeugung
* **Font Awesome 7**: `brew install --cask font-fontawesome` für die Icon-Ausgabe von `neat-cv` und `nabcv`
* **uv ist nicht erforderlich**: Das Repository hat derzeit keine Python-Abhängigkeiten, kein virtuelles Environment und keinen Lockfile-Bedarf. uv kann optional für einen eigenen Python-Workflow verwendet werden, ist aber nicht Teil des Projekt-Setups.

### 2. Konfiguration
Erstelle die lokale Konfiguration aus der Vorlage und passe sie an:
```bash
cp .env.example .env
```

In `.env`:
```bash
# Pfad zu deinem Obsidian Vault (dynamisch & nicht gehardcoded)
OBSIDIAN_VAULT_PATH="/path/to/your/obsidian-vault"

# Optionaler Unterordner im Vault
OBSIDIAN_CAREER_SUBDIR="02 Areas/Career"

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

# 5. Alle alternativen CV-/Anschreiben-Varianten testen
make test-variants
```

Der konfigurierte Karriere-Unterordner wird automatisch bevorzugt durchsucht. Persönliche Obsidian-Notizen, `.env` und generierte PDFs bleiben außerhalb des Git-Repositories beziehungsweise werden von Git ignoriert.

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
   - Der Agent ruft `./scripts/render.sh` auf – in Millisekunden entsteht ein PDF in `output/`.

## Template-Varianten

Die JSON-Datenquelle bleibt für alle Renderer identisch. Die vierte Argumentposition von `render.sh` wählt die Darstellung:

```bash
./scripts/render.sh cv <cv_data.json> <output.pdf> modern
./scripts/render.sh cv <cv_data.json> <output.pdf> neat-cv
./scripts/render.sh cv <cv_data.json> <output.pdf> clean-print-cv
./scripts/render.sh cv <cv_data.json> <output.pdf> nabcv
```

Für Anschreiben stehen `modern`, `neat-cv` und `nabcv` zur Verfügung. `clean-print-cv` ist ein CV-only-Paket ohne eigenen Letter-Renderer.

Die Pakete werden von Typst beim ersten Lauf aus Typst Universe geladen und sind in den Adaptern versionsgebunden. Die Adapter halten die Karriere-Datenquelle unabhängig vom jeweiligen Layout.

## Setup-Entscheidung

Dieses Projekt benötigt aktuell kein `pyproject.toml`, keine `requirements.txt` und keine `uv.lock`, weil `scripts/vault_helper.py` keine externen Python-Pakete verwendet. Die zentrale Render-Abhängigkeit ist Typst; die alternativen Layouts laden ihre versionsgebundenen Typst-Universe-Pakete beim ersten Lauf. `scripts/render.sh` prüft die Typst-Installation vor dem Kompilieren.
