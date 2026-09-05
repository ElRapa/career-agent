# Changelog

Alle relevanten Änderungen am Career Agent werden hier festgehalten.

## [Repository Privacy Cleanup] - 2026-09-05

### Changed

- Persönliche Beispielidentität aus den Sample-Daten entfernt und durch `Colin Ford` ersetzt.
- Karriere-Prompts und Schreibregeln verallgemeinert, damit sie nicht an eine einzelne Person gebunden sind.
- Lokale Benutzerpfade, persönliche Kontaktdaten und personenbezogene Beispiel-URLs aus dem Repository und seiner veröffentlichten Historie entfernt.
- Exxeta bleibt als bewusst zugelassener Beispiel- und Kontextname erhalten.

## [Initial Setup] - 2026-09-05

Der aktuelle Stand des gesamten Repositories wurde am 05.09.2026 aufgesetzt und entwickelt. Dieser Eintrag beschreibt daher das vollständige Initial-Setup des Career Agents und nicht nur nachträgliche Dokumentationsänderungen.

### Added

- Initiale Repository-Struktur mit Typst-Templates, modularen CV-/Anschreiben-Workflows, JSON-Beispieldaten, Render-Skript und Obsidian-Vault-Helper.
- Am 05.09.2026 wurde die initiale Karriere-Datenbasis im konfigurierten Obsidian-Vault erstellt und strukturiert. Sie umfasst 21 validierte Karriere-Notizen zu Profil, Berufserfahrung, Projekten, Kompetenzen, Ausbildung, Präferenzen und Zeugnis-Evidenz.
- VS-Code-Arbeitsbereich `career-agent.code-workspace`.
- Dokumentation der Repository-Struktur, des Obsidian-Karriere-Unterordners und des lokalen Setup-Ablaufs.
- Explizite Setup-Entscheidung: Das Projekt benötigt aktuell keine Python-Paketverwaltung mit `uv`, weil das Vault-Hilfsskript ausschließlich die Python-Standardbibliothek verwendet.

### Changed

- `.env.example` verwendet einen neutralen Platzhalter für den lokalen Obsidian-Pfad.
- Die README beschreibt Typst als einzige externe Render-Abhängigkeit und erklärt die Trennung zwischen Repository und persönlichem Obsidian-Vault.

### Notes

- Die Karriere-Datenbasis und die privaten Kontaktdaten wurden am 05.09.2026 erstellt beziehungsweise strukturiert. Die Obsidian-Dateien liegen außerhalb dieses Git-Repositories und werden nicht in den Commit kopiert.
- Der persönliche Obsidian-Vault wird über `.env` eingebunden und nicht in dieses Repository kopiert.
- `.env`, private Bewerbungsdaten, generierte PDFs und andere lokale Ausgaben bleiben durch `.gitignore` außerhalb des Commits.