---
description: "Erstelle ein zielgerichtetes Anschreiben für eine Bewerbung"
name: "cover-letter"
argument-hint: "Füge hier die Stellenbeschreibung oder Anforderungen ein..."
---
Erstelle ein auf die folgende Stellenanzeige zugeschnittenes Anschreiben für Colin Ford:

$ARGUMENTS

Vorgehen:
1. Analysiere die Stellenanzeige nach [packs/shared/job-analysis.md](packs/shared/job-analysis.md).
2. Finde die besten Praxisbelege und Motivation im Obsidian-Vault.
3. Formuliere ein überzeugendes Anschreiben gemäß [packs/cover-letter/workflow.md](packs/cover-letter/workflow.md) und [packs/shared/conventions.md](packs/shared/conventions.md).
4. Generiere das passende `cover_letter_data.json` und speichere es unter `output/<firmenname>/cover_letter_data.json`.
5. Kompiliere das finale PDF mit `./scripts/render.sh letter ...`.
