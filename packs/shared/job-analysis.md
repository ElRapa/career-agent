# Job Ad Analysis & Extraction Guide

Wenn dem Agenten eine Stellenausschreibung übergeben wird (Text, PDF oder URL-Inhalt), extrahiert er strukturiert folgende Dimensionen:

## 1. Metadaten der Position
- **Unternehmen**: Name des Arbeitgebers / Kunden
- **Rolle / Jobtitel**: Exakte Bezeichnung (z.B. "Senior Data Engineer / Cloud Architect")
- **Standort / Remote-Anteil**: Arbeitsort, Reiseradius, Homeoffice-Regelung
- **Ansprechpartner / Kontakt**: Für Anschreiben (falls genannt)

## 2. Anforderungsprofil (Must-Haves vs. Nice-to-Haves)
- **Hard Skills (Must-Have)**: Explizit geforderte Kerntechnologien (z. B. Python, Databricks, Spark, AWS, Terraform)
- **Hard Skills (Nice-to-Have)**: Wünschenswerte Zusatzqualifikationen
- **Methoden & Domänen**: Agile, DevOps, CI/CD, Finanzbranche, MedTech, etc.
- **Soft Skills & Leadership**: Mentoring, Stakeholder-Management, Architektur-Verantwortung

## 3. Strategischer Fokus der Rolle
- Woran wird der Erfolg dieser Person gemessen? (z. B. Aufbau einer neuen Datenplattform, Migration eines Legacy-Monolithen, Team-Skalierung)

## 4. Tonalität & Kultur
- Duz- oder Siez-Kultur?
- Start-up-Sprache oder Enterprise-Formalität?
