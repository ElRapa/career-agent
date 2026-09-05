# Workflow: Anschreiben (Cover Letter)

## Schritt 1: Empfänger & Ansprechpartner ermitteln
Aus der Stellenanzeige oder Firmenangaben:
- Firmenname, Anschrift, Ansprechpartner (Name/Titel).
- Wenn kein Ansprechpartner angegeben: *"Sehr geehrte Damen und Herren"* oder *"Liebes Recruiting-Team"*.

## Schritt 2: Aufbau des Anschreibens
Das Anschreiben besteht aus genau 4 fokussierten Absätzen (maximal 1 DIN A4-Seite):
1. **Hook & Motivation**: Warum genau dieses Unternehmen und diese Mission? Kein Standard-Einstieg ("Hiermit bewerbe ich mich..."), sondern ein starker Aufhänger.
2. **Kernkompetenz & Praxisbeleg 1**: Was qualifiziert dich besonders für die Top-Anforderung der Stelle? Verknüpft mit einem realen Projekterfolg aus dem Vault.
3. **Ergänzender Mehrwert & Praxisbeleg 2**: Wie löst dein Background ein weiteres wichtiges Thema (z. B. Skalierung, Architektur, Team-Führung)?
4. **Call to Action**: Verfügbarkeit / Kündigungsfrist, Gehaltsvorstellung (falls gefordert), Freude auf das persönliche Gespräch.

## Schritt 3: Drafting `cover_letter_data.json`
Struktur:
```json
{
  "sender": {
    "name": "...",
    "title": "...",
    "email": "...",
    "phone": "...",
    "location": "..."
  },
  "recipient": {
    "company": "Unternehmen GmbH",
    "department": "Talent Acquisition",
    "contact_person": "Frau Dr. Schmidt",
    "address": "Musterstraße 12",
    "city": "80331 München"
  },
  "accent_color": "#1a5fb4",
  "language": "de",
  "date": "05. September 2026",
  "location": "Köln",
  "subject": "Bewerbung als Lead Cloud Architect",
  "reference": "JOB-12345",
  "salutation": "Sehr geehrte Frau Dr. Schmidt,",
  "paragraphs": [
    "Absatz 1...",
    "Absatz 2...",
    "Absatz 3...",
    "Absatz 4..."
  ],
  "closing": "Mit freundlichen Grüßen"
}
```

## Schritt 4: Typst-Rendering
```bash
./scripts/render.sh letter <pfad-zu-cover_letter_data.json> <output-pfad.pdf>
```
