# Career Agent Instructions

This repository is an AI-powered system for generating tailored, modern CVs and cover letters from an Obsidian markdown vault using Typst.

## Architecture & Conventions

- **Candidate Data Source**: The user's Obsidian vault. Path is configured dynamically in `.env` (`OBSIDIAN_VAULT_PATH`).
- **Inspection Tool**: `python3 scripts/vault_helper.py status` or `python3 scripts/vault_helper.py search "<keyword>"`.
- **Quality Standards**: Strict anti-hallucination, STAR method, and JSON schemas in `packs/shared/conventions.md`.
- **Job Analysis**: Guidelines in `packs/shared/job-analysis.md`.
- **Renderer**: `./scripts/render.sh <cv|letter> <json_path> <output_pdf>` (uses Typst 0.15+).

## Workflow when User requests a CV or Cover Letter

1. **Analyze the Job Posting**:
   - Extract must-haves, nice-to-haves, role focus (hands-on vs architecture vs leadership), and keywords.
2. **Inspect Obsidian Vault**:
   - Check available notes using `scripts/vault_helper.py` or inspect relevant project and profile files in `$OBSIDIAN_VAULT_PATH`.
   - Never invent roles, certifications, companies, or metrics. Every fact must be grounded in the vault.
3. **Draft Tailored JSON**:
   - Structure JSON according to `sample-data/sample_cv.json` (or `sample-data/sample_letter.json`).
   - Highlight the 3–4 most relevant projects for the target position.
   - Formulate bullet points using the STAR method (Situation, Task, Action, Result).
   - Order skills so that required technologies appear first.
4. **Compile Output**:
   - Save the JSON to `output/<company>/cv_data.json`.
   - Run `./scripts/render.sh cv output/<company>/cv_data.json output/<company>/Lebenslauf_<Name>.pdf`.
   - Report the generated PDF path to the user.
