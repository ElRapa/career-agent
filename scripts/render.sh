#!/usr/bin/env bash
set -euo pipefail

# Scripts directory
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Load .env if present
if [[ -f "${ROOT_DIR}/.env" ]]; then
  # Export variables from .env ignoring comments
  set -a
  source "${ROOT_DIR}/.env"
  set +a
fi

TYPE="${1:-}"
JSON_FILE="${2:-}"
OUTPUT_PDF="${3:-}"

if [[ -z "${TYPE}" || -z "${JSON_FILE}" ]]; then
  echo "Usage: $0 <cv|letter> <path_to_json> [output_pdf_path]"
  echo "Examples:"
  echo "  $0 cv sample-data/sample_cv.json output/test_cv.pdf"
  echo "  $0 letter sample-data/sample_letter.json output/test_letter.pdf"
  exit 1
fi

# Ensure typst is installed
if ! command -v typst &> /dev/null; then
  echo "❌ Fehler: 'typst' ist nicht installiert oder nicht im PATH."
  echo "   Installation unter macOS: brew install typst"
  echo "   Weitere Plattformen: https://github.com/typst/typst#installation"
  exit 1
fi

# Absoluter Pfad der JSON-Datei ermitteln
JSON_ABS="$(cd "$(dirname "${JSON_FILE}")" && pwd)/$(basename "${JSON_FILE}")"

# Berechne relativen Pfad von ROOT_DIR aus (mit führendem / für Typst Root)
if [[ "${JSON_ABS}" == "${ROOT_DIR}"* ]]; then
  TYPST_DATA_PATH="/${JSON_ABS#"${ROOT_DIR}/"}"
else
  # Falls außerhalb von ROOT_DIR, kopiere temporär in .tmp_data.json
  cp "${JSON_ABS}" "${ROOT_DIR}/.tmp_data.json"
  TYPST_DATA_PATH="/.tmp_data.json"
fi

# Bestimme Template
if [[ "${TYPE}" == "cv" ]]; then
  TEMPLATE="${ROOT_DIR}/templates/cv_modern.typ"
elif [[ "${TYPE}" == "letter" ]]; then
  TEMPLATE="${ROOT_DIR}/templates/cover_letter_modern.typ"
else
  echo "❌ Ungültiger Typ: '${TYPE}'. Erlaubt sind 'cv' oder 'letter'."
  exit 1
fi

# Bestimme Standard-Ausgabepfad falls nicht angegeben
if [[ -z "${OUTPUT_PDF}" ]]; then
  OUTPUT_DIR="${OUTPUT_DIR:-${ROOT_DIR}/output}"
  TIMESTAMP="$(date +"%Y%m%d_%H%M%S")"
  mkdir -p "${OUTPUT_DIR}"
  OUTPUT_PDF="${OUTPUT_DIR}/${TYPE}_${TIMESTAMP}.pdf"
else
  mkdir -p "$(dirname "${OUTPUT_PDF}")"
fi

echo "🚀 Kompiliere mit Typst..."
echo "   Template: ${TEMPLATE}"
echo "   Daten:    ${JSON_ABS}"
echo "   Ausgabe:  ${OUTPUT_PDF}"

typst compile --root "${ROOT_DIR}" --input data="${TYPST_DATA_PATH}" "${TEMPLATE}" "${OUTPUT_PDF}"

# Aufräumen temporärer Dateien
rm -f "${ROOT_DIR}/.tmp_data.json"

echo "✅ PDF erfolgreich generiert: ${OUTPUT_PDF}"
