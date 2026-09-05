.PHONY: help status search test-cv test-letter test-cv-neat test-cv-clean test-cv-nabcv test-letter-neat test-letter-nabcv test-variants clean

help:
	@echo "Verfügbare Befehle für Career Agent:"
	@echo "  make status         - Zeigt Status und Notizen im Obsidian-Vault an"
	@echo "  make search q=TERM  - Durchsucht das Vault nach Begriff (z.B. make search q=Kubernetes)"
	@echo "  make test-cv        - Rendert den Beispiel-Lebenslauf mit Typst"
	@echo "  make test-letter    - Rendert das Beispiel-Anschreiben mit Typst"
	@echo "  make test-cv-neat   - Rendert die neat-cv-Variante"
	@echo "  make test-cv-clean  - Rendert die clean-print-cv-Variante"
	@echo "  make test-cv-nabcv  - Rendert die nabcv-Variante"
	@echo "  make test-variants  - Rendert alle drei CV-Varianten und Letter-Varianten"
	@echo "  make clean          - Löscht generierte Dateien im output-Ordner"

status:
	python3 scripts/vault_helper.py status

search:
	python3 scripts/vault_helper.py search "$(q)"

test-cv:
	./scripts/render.sh cv sample-data/sample_cv.json output/test_cv.pdf

test-letter:
	./scripts/render.sh letter sample-data/sample_letter.json output/test_letter.pdf

test-cv-neat:
	./scripts/render.sh cv sample-data/sample_cv.json output/test_cv_neat.pdf neat-cv

test-cv-clean:
	./scripts/render.sh cv sample-data/sample_cv.json output/test_cv_clean_print.pdf clean-print-cv

test-cv-nabcv:
	./scripts/render.sh cv sample-data/sample_cv.json output/test_cv_nabcv.pdf nabcv

test-letter-neat:
	./scripts/render.sh letter sample-data/sample_letter.json output/test_letter_neat.pdf neat-cv

test-letter-nabcv:
	./scripts/render.sh letter sample-data/sample_letter.json output/test_letter_nabcv.pdf nabcv

test-variants: test-cv-neat test-cv-clean test-cv-nabcv test-letter-neat test-letter-nabcv

clean:
	rm -rf output/*.pdf
