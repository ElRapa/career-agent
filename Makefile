.PHONY: help status search test-cv test-letter clean

help:
	@echo "Verfügbare Befehle für Career Agent:"
	@echo "  make status         - Zeigt Status und Notizen im Obsidian-Vault an"
	@echo "  make search q=TERM  - Durchsucht das Vault nach Begriff (z.B. make search q=Kubernetes)"
	@echo "  make test-cv        - Rendert den Beispiel-Lebenslauf mit Typst"
	@echo "  make test-letter    - Rendert das Beispiel-Anschreiben mit Typst"
	@echo "  make clean          - Löscht generierte Dateien im output-Ordner"

status:
	python3 scripts/vault_helper.py status

search:
	python3 scripts/vault_helper.py search "$(q)"

test-cv:
	./scripts/render.sh cv sample-data/sample_cv.json output/test_cv.pdf

test-letter:
	./scripts/render.sh letter sample-data/sample_letter.json output/test_letter.pdf

clean:
	rm -rf output/*.pdf
