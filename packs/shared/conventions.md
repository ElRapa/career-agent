# Career Agent Conventions & Quality Gates

Diese Konventionen gelten für jede Generierung von Lebensläufen und Bewerbungsunterlagen.

## 1. Grounding & Anti-Halluzination (Strict Fact-Checking)
- **Niemals Fakten erfinden**: Jedes genannte Projekt, jede Station, jeder Abschluss und jede Technologie MUSS aus den Obsidian-Dateien oder den bereitgestellten Daten belegt sein.
- **Metriken & Zahlen**: Nur Zahlen und KPIs verwenden, die in den Notizen dokumentiert sind (z. B. "2 Mio. Events/Tag", "Team von 8 Entwicklern"). Wenn keine exakte Zahl vorliegt, formuliere wirkungsorientiert qualitativ, anstatt Zahlen zu erfinden.
- **Gaps & Unsicherheiten**: Wenn eine Kernanforderung der Stelle nicht durch das Vault belegt werden kann, markiere sie intern als Gap – erfinde keine passenden Projekte.

## 2. STAR-Methode für Projekt-Bulletpoints
Jeder Bulletpoint in ausgewählten Projekten sollte nach Möglichkeit der STAR-Struktur folgen:
- **Situation / Task**: Kontext oder Problemstellung.
- **Action**: Was war dein konkreter Beitrag, deine architektonische Entscheidung oder Implementierung?
- **Result**: Welcher Mehrwert, welche Performance-Verbesserung oder welche Kostenersparnis wurde erzielt?
- **Stil**: Starte mit starken Aktionsverben (*"Konzipiert"*, *"Implementiert"*, *"Skaliert"*, *"Optimiert"*, *"Geleitet"*).

## 3. ATS-Optimierung (Applicant Tracking Systems)
- **Keyword-Matching**: Übernimm die exakte Terminologie aus der Stellenausschreibung (z. B. "Kubernetes" statt nur "Container", "Databricks" statt nur "Data Lakehouse"), sofern im Vault vorhanden.
- **Kategorisierte Skills**: Skills klar nach Kategorien bündeln (z. B. Cloud & Infrastructure, Data Engineering, Sprachen & Frameworks, Methoden & Architektur).

## 4. Relevanz & Selektivität (Weniger ist mehr)
- Ein CV sollte nicht jedes jemals geschriebene Skript auflisten, sondern **die 3 bis 5 stärksten Belege für die Zielstelle**.
- Ältere oder weniger relevante Projekte werden nur kurz zusammengefasst oder im chronologischen Werdegang als Station erwähnt.

## 5. Output-Standard (JSON für Typst)
- Der Agent generiert immer valides JSON, das direkt vom Typst-Template (`templates/cv_modern.typ` oder `templates/cover_letter_modern.typ`) konsumiert werden kann.
- Keine Typst-Code-Manipulation nötig: Alle Texte, Formatierungen, Listen und Metadaten werden im JSON-Schema übergeben.
