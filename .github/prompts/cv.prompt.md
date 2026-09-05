---
description: "Erstelle einen maßgeschneiderten Lebenslauf basierend auf einer Stellenausschreibung"
name: "cv"
argument-hint: "Füge hier die Stellenbeschreibung oder Anforderungen ein..."
---
Erstelle einen auf die folgende Stellenanzeige zugeschnittenen Lebenslauf für die Person aus dem konfigurierten Obsidian-Vault:

$ARGUMENTS

Vorgehen:
1. Analysiere die Stellenanzeige nach [packs/shared/job-analysis.md](packs/shared/job-analysis.md).
2. Durchsuche die Obsidian-Notizen über `python3 scripts/vault_helper.py` oder lies die Profildateien im Vault.
3. Wähle die relevantesten Projekte und Stationen gemäß [packs/shared/conventions.md](packs/shared/conventions.md) aus.
4. Wende zusätzlich [packs/shared/writing-style.md](packs/shared/writing-style.md) an. Trenne Vertragstitel, projektbezogene Rollen und Disziplinjahre; schreibe flüssige, konkrete Prosa und vermeide wiederholte Approximationen.
5. Generiere das passende `cv_data.json` und speichere es unter `output/<firmenname>/cv_data.json`.
6. Prüfe JSON, unbelegte Ansprüche, Senioritätskalibrierung, Wiederholungen und vertrauliche Inhalte.
7. Kompiliere das finale PDF mit `./scripts/render.sh cv ...`.
