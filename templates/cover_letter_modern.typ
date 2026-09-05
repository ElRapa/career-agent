// Modern & Visual Cover Letter Template for Typst
// Compatible with Typst 0.11+

#let data-file = sys.inputs.at("data", default: "cover_letter_data.json")
#let data = json(data-file)

// Farbschema
#let accent-hex = data.at("accent_color", default: "#1a5fb4")
#let accent = rgb(accent-hex)
#let text-dark = rgb("#1e293b")
#let text-muted = rgb("#64748b")
#let border-light = rgb("#e2e8f0")

#set document(
  title: data.sender.name + " - Anschreiben",
  author: data.sender.name,
)

#set page(
  paper: "a4",
  margin: (x: 2.2cm, top: 2.0cm, bottom: 2.2cm),
)

#set text(
  font: ("Helvetica Neue", "Arial"),
  size: 10pt,
  fill: text-dark,
  lang: data.at("language", default: "de")
)

#set par(justify: true, leading: 0.65em)

// =================== HEADER ===================
#block(width: 100%, stroke: (bottom: 0.5pt + border-light), inset: (bottom: 1.2em))[
  #grid(
    columns: (1fr, auto),
    gutter: 1.5cm,
    align: (left + horizon, right + horizon),
    [
      #text(size: 20pt, weight: "bold", fill: accent)[#data.sender.name] \
      #v(0.2em)
      #text(size: 11pt, weight: "medium", fill: text-dark)[#data.sender.title]
    ],
    [
      #set text(size: 8.5pt, fill: text-muted)
      #if "email" in data.sender and data.sender.email != "" [
        📧 #link("mailto:" + data.sender.email)[#data.sender.email] \
      ]
      #if "phone" in data.sender and data.sender.phone != "" [
        📱 #data.sender.phone \
      ]
      #if "location" in data.sender and data.sender.location != "" [
        📍 #data.sender.location \
      ]
    ]
  )
]

#v(0.9cm)

// =================== RECIPIENT & METADATA ===================
#grid(
  columns: (1fr, 1fr),
  align: (left, right),
  [
    #text(size: 9.5pt, weight: "bold")[#data.recipient.company] \
    #if "department" in data.recipient and data.recipient.department != "" [
      #text(size: 9pt)[#data.recipient.department] \
    ]
    #if "contact_person" in data.recipient and data.recipient.contact_person != "" [
      #text(size: 9pt)[#data.recipient.contact_person] \
    ]
    #if "address" in data.recipient and data.recipient.address != "" [
      #text(size: 9pt)[#data.recipient.address] \
    ]
    #if "city" in data.recipient and data.recipient.city != "" [
      #text(size: 9pt)[#data.recipient.city] \
    ]
  ],
  [
    #set text(size: 9pt, fill: text-muted)
    #if "date" in data [
      #data.at("location", default: "Köln"), den #data.date
    ]
  ]
)

#v(0.8cm)

// =================== SUBJECT ===================
#block(width: 100%)[
  #text(size: 13pt, weight: "bold", fill: accent)[#data.subject]
  #if "reference" in data and data.reference != "" [
    \ #text(size: 8.5pt, fill: text-muted)[Referenznummer: #data.reference]
  ]
]

#v(0.55cm)

// =================== SALUTATION ===================
#text(weight: "medium")[#data.salutation]

#v(0.4cm)

// =================== BODY PARAGRAPHS ===================
#for p in data.paragraphs [
  #p
  #v(0.5em)
]

#v(1.0cm)

// =================== SIGN-OFF ===================
#text(weight: "medium")[#data.closing] \
#v(1.2cm)
#text(weight: "bold")[#data.sender.name]
