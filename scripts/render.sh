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
VARIANT="${4:-modern}"
SIGNATURE_DATA_PATH=""

if [[ -z "${TYPE}" || -z "${JSON_FILE}" ]]; then
  echo "Usage: $0 <cv|letter> <path_to_json> [output_pdf_path] [template]"
  echo "Examples:"
  echo "  $0 cv sample-data/sample_cv.json output/test_cv.pdf"
  echo "  $0 letter sample-data/sample_letter.json output/test_letter.pdf"
  echo "  $0 cv sample-data/sample_cv.json output/test_cv.pdf neat-cv"
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

# Bestimme Template-Variante
case "${TYPE}:${VARIANT}" in
  cv:modern)
    TEMPLATE="${ROOT_DIR}/templates/cv_modern.typ"
    ;;
  cv:neat-cv)
    TEMPLATE="${ROOT_DIR}/templates/neat_cv.typ"
    ;;
  cv:clean-print-cv)
    TEMPLATE="${ROOT_DIR}/templates/clean_print_cv.typ"
    ;;
  cv:nabcv)
    TEMPLATE="${ROOT_DIR}/templates/nabcv.typ"
    ;;
  letter:modern)
    TEMPLATE="${ROOT_DIR}/templates/cover_letter_modern.typ"
    ;;
  letter:neat-cv)
    TEMPLATE="${ROOT_DIR}/templates/neat_letter.typ"
    ;;
  letter:nabcv)
    TEMPLATE="${ROOT_DIR}/templates/nabcv_letter.typ"
    ;;
  letter:clean-print-cv)
    echo "❌ 'clean-print-cv' enthält keinen Anschreiben-Renderer."
    echo "   Verwende 'modern', 'neat-cv' oder 'nabcv' für Anschreiben."
    exit 1
    ;;
  cv:*|letter:*)
    echo "❌ Unbekannte Template-Variante: '${VARIANT}'."
    echo "   CV: modern, neat-cv, clean-print-cv, nabcv"
    echo "   Anschreiben: modern, neat-cv, nabcv"
    exit 1
    ;;
  *)
    echo "❌ Ungültiger Typ: '${TYPE}'. Erlaubt sind 'cv' oder 'letter'."
    exit 1
    ;;
esac

# Signatures stay outside the repository and are copied only for letter renders.
if [[ "${TYPE}" == "letter" && -n "${SIGNATURE_PATH:-}" ]]; then
  if [[ -r "${SIGNATURE_PATH}" ]]; then
    cp "${SIGNATURE_PATH}" "${ROOT_DIR}/.tmp_signature.png"
    SIGNATURE_DATA_PATH="/.tmp_signature.png"
  else
    echo "⚠️ Unterschrift nicht lesbar; Anschreiben wird ohne Unterschrift gerendert:"
    echo "   ${SIGNATURE_PATH}"
  fi
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
echo "   Variante:  ${VARIANT}"
echo "   Template: ${TEMPLATE}"
echo "   Daten:    ${JSON_ABS}"
echo "   Ausgabe:  ${OUTPUT_PDF}"

typst compile --root "${ROOT_DIR}" --input data="${TYPST_DATA_PATH}" --input signature="${SIGNATURE_DATA_PATH}" "${TEMPLATE}" "${OUTPUT_PDF}"

# Aufräumen temporärer Dateien
rm -f "${ROOT_DIR}/.tmp_data.json"
rm -f "${ROOT_DIR}/.tmp_signature.png"

echo "✅ PDF erfolgreich generiert: ${OUTPUT_PDF}"
